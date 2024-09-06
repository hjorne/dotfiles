# Dotfiles (chezmoi)

This repo manages my personal/work dotfiles with [chezmoi](https://www.chezmoi.io/).

## Quick Setup

1. Install `chezmoi`.
2. Initialize this repo on a machine:
```bash
chezmoi init --apply <your-repo-url>
```
3. Set required data variables (below).
4. Re-apply:
```bash
chezmoi apply
```

## Required chezmoi Data

`dot_gitconfig.tmpl` expects:

- `git_name`
- `git_email`

Set these in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
git_name = "Your Name"
git_email = "you@company.com"
```

Optional machine-specific git overrides can go in:

- `~/.gitconfig.local`

This file is included by generated `.gitconfig`.

## Daily chezmoi Workflow

```bash
# see drift
chezmoi status

# edit a managed file
chezmoi edit ~/.gitconfig

# apply source changes to target
chezmoi apply

# add a new file to source state
chezmoi add ~/.somefile

# stop managing a file
chezmoi forget ~/.somefile
```

## Machine-Specific Notes

- SSH 1Password agent is configured conditionally in `.ssh/config`.
- `IdentityAgent` is applied only when the 1Password socket exists.
- This is a portable pattern across machines that may or may not have 1Password installed.
- `ForwardAgent yes` is currently global. This is convenient but broad. Consider changing to `ForwardAgent no` globally and enabling per-host if you want tighter security.
- Cursor and VS Code user settings are both managed:
- `~/Library/Application Support/Cursor/User/settings.json`
- `~/Library/Application Support/Code/User/settings.json`

## Fish Shell Policy

Do not commit machine-generated fish files. This repo already ignores:

- `.config/fish/fish_variables`
- `.config/fish/config.fish-e`

About `~/.config/fish/functions`:

- Recommended: keep your custom functions in repo, but do not vendor third-party plugin functions.
- Keep plugin declarations in `.config/fish/fish_plugins`, then install/update plugins on each machine with Fisher.
- Vendoring plugin functions can work, but it causes churn and makes updates/reviews noisier.

Plugin bootstrap on a new machine:

```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install (cat ~/.config/fish/fish_plugins)
```
