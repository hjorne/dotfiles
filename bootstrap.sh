#!/usr/bin/env bash

set -u
set -o pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/bootstrap/common.sh
. "$REPO_ROOT/scripts/bootstrap/common.sh"

usage() {
    cat <<USAGE
Usage: ./bootstrap.sh [options]

Options:
  --dry-run              Show planned actions without changing anything.
  --yes                  Accept package, plugin, and chezmoi prompts.
                         Fish login shell changes still require confirmation.
  --skip-packages        Do not install OS packages or chezmoi.
  --skip-chezmoi-apply   Do not run chezmoi init/diff/apply.
  --skip-plugins         Do not install Fisher, TPM, or Neovim plugins.
  --skip-chsh            Do not offer to change the login shell to Fish.
  -h, --help             Show this help.
USAGE
}

parse_args() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            --dry-run)
                DRY_RUN=1
                ;;
            --yes)
                YES=1
                ;;
            --skip-packages)
                SKIP_PACKAGES=1
                ;;
            --skip-chezmoi-apply)
                SKIP_CHEZMOI_APPLY=1
                ;;
            --skip-plugins)
                SKIP_PLUGINS=1
                ;;
            --skip-chsh)
                SKIP_CHSH=1
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                usage >&2
                die "Unknown option: $1"
                ;;
        esac
        shift
    done
}

main() {
    parse_args "$@"

    if [ "$(id -u)" -eq 0 ]; then
        die "Do not run bootstrap as root. Run it as the target user; the script will use sudo only for the steps that need it."
    fi

    info "Dotfiles bootstrap"
    info "Repository: $REPO_ROOT"

    case "$(uname -s)" in
        Darwin)
            BOOTSTRAP_OS="macos"
            # shellcheck source=scripts/bootstrap/macos.sh
            . "$REPO_ROOT/scripts/bootstrap/macos.sh"
            bootstrap_macos
            ;;
        Linux)
            BOOTSTRAP_OS="ubuntu"
            # shellcheck source=scripts/bootstrap/ubuntu.sh
            . "$REPO_ROOT/scripts/bootstrap/ubuntu.sh"
            bootstrap_ubuntu
            ;;
        *)
            die "Unsupported OS: $(uname -s). This bootstrap supports macOS and Ubuntu only."
            ;;
    esac

    bootstrap_chezmoi

    # shellcheck source=scripts/bootstrap/post_apply.sh
    . "$REPO_ROOT/scripts/bootstrap/post_apply.sh"
    bootstrap_post_apply

    info "Bootstrap finished."
}

main "$@"
