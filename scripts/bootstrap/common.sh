#!/usr/bin/env bash

DRY_RUN=${DRY_RUN:-0}
YES=${YES:-0}
SKIP_PACKAGES=${SKIP_PACKAGES:-0}
SKIP_CHEZMOI_APPLY=${SKIP_CHEZMOI_APPLY:-0}
SKIP_PLUGINS=${SKIP_PLUGINS:-0}
SKIP_CHSH=${SKIP_CHSH:-0}
BOOTSTRAP_OS=${BOOTSTRAP_OS:-unknown}

info() {
    printf '==> %s\n' "$*"
}

warn() {
    printf 'WARN: %s\n' "$*" >&2
}

die() {
    printf 'ERROR: %s\n' "$*" >&2
    exit 1
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

print_command() {
    printf '+'
    while [ "$#" -gt 0 ]; do
        printf ' %q' "$1"
        shift
    done
    printf '\n'
}

run() {
    if [ "$DRY_RUN" -eq 1 ]; then
        print_command "$@"
        return 0
    fi

    print_command "$@"
    "$@"
    status=$?
    if [ "$status" -ne 0 ]; then
        die "Command failed with exit status $status. Re-run with --dry-run to inspect the planned steps."
    fi
}

run_shell() {
    description=$1
    command_text=$2

    if [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] $description"
        printf '+ %s\n' "$command_text"
        return 0
    fi

    info "$description"
    /bin/sh -c "$command_text"
    status=$?
    if [ "$status" -ne 0 ]; then
        die "$description failed with exit status $status."
    fi
}

confirm() {
    prompt=$1
    default=${2:-n}
    respect_yes=${3:-1}

    if [ "$respect_yes" -eq 1 ] && [ "$YES" -eq 1 ]; then
        info "Auto-confirmed: $prompt"
        return 0
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] Would prompt: $prompt"
        return 0
    fi

    if [ ! -t 0 ]; then
        warn "Skipping prompt in non-interactive shell: $prompt"
        return 1
    fi

    case "$default" in
        y|Y)
            suffix='[Y/n]'
            ;;
        *)
            suffix='[y/N]'
            ;;
    esac

    while true; do
        printf '%s %s ' "$prompt" "$suffix"
        read -r answer
        if [ -z "$answer" ]; then
            answer=$default
        fi
        case "$answer" in
            y|Y|yes|YES)
                return 0
                ;;
            n|N|no|NO)
                return 1
                ;;
            *)
                printf 'Please answer yes or no.\n'
                ;;
        esac
    done
}

sudo_run() {
    if [ "$(id -u)" -eq 0 ]; then
        run "$@"
        return
    fi

    if ! command_exists sudo; then
        die "sudo is required for this step but is not installed."
    fi

    run sudo "$@"
}

sudo_append_line_if_missing() {
    file=$1
    line=$2

    if [ -f "$file" ] && grep -Fqx "$line" "$file"; then
        info "$line is already present in $file"
        return
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] Would append '$line' to $file"
        return
    fi

    if [ "$(id -u)" -eq 0 ]; then
        printf '%s\n' "$line" >> "$file"
    else
        printf '%s\n' "$line" | sudo tee -a "$file" >/dev/null
    fi
}

ensure_local_bin_on_path() {
    case ":$PATH:" in
        *":$HOME/.local/bin:"*)
            ;;
        *)
            export PATH="$HOME/.local/bin:$PATH"
            ;;
    esac
}

bootstrap_chezmoi() {
    ensure_local_bin_on_path

    if [ "$SKIP_CHEZMOI_APPLY" -eq 1 ]; then
        info "Skipping chezmoi init/apply."
        return
    fi

    if ! command_exists chezmoi && [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] chezmoi is not currently installed; package steps would install it before init/apply."
    elif ! command_exists chezmoi; then
        die "chezmoi is not installed or not on PATH. Re-run without --skip-packages, or install chezmoi first."
    fi

    existing_source=
    if command_exists chezmoi; then
        existing_source=$(chezmoi source-path 2>/dev/null || true)
    fi
    if [ -n "$existing_source" ] && [ -d "$existing_source" ] && [ "$existing_source" != "$REPO_ROOT" ]; then
        die "chezmoi is configured for '$existing_source', not '$REPO_ROOT'. Fix ~/.config/chezmoi/chezmoi.toml or run with --skip-chezmoi-apply."
    fi

    info "Initializing chezmoi with this repo as the source."
    run chezmoi init --source "$REPO_ROOT"

    info "Previewing chezmoi changes."
    run chezmoi diff

    if confirm "Apply chezmoi changes now?" n 1; then
        run chezmoi apply
    else
        warn "Skipped chezmoi apply. Run 'chezmoi diff' and 'chezmoi apply' when ready."
    fi
}
