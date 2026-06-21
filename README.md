# dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io). Cross-machine
(WSL / Linux / macOS), zsh-first with a bash fallback, unified blue theme.

## What's inside

| Area        | Files                                                        |
| ----------- | ----------------------------------------------------------- |
| Shell       | `dot_zshrc`, `dot_zshenv`, `dot_zprofile`, `dot_bashrc`, `dot_config/zsh/` |
| Prompt      | `dot_config/starship.toml` (custom blue palette)            |
| Plugins     | `antidote` (see `dot_config/zsh/plugins.txt`)               |
| CLI         | eza, bat, fd, ripgrep, fzf, zoxide, atuin, delta            |
| Git         | `dot_gitconfig.tmpl` (delta pager + aliases)                |
| tmux        | `dot_config/tmux/tmux.conf` (tpm + resurrect/continuum, C-b) |
| Tools       | `dot_config/{lazygit,bat,gh}`, `dot_config/nvim`            |
| Claude Code | `dot_claude/` (settings + commands + rtk hook)               |
| AI tooling  | rtk (token-reducing CLI proxy) wired into Claude Code        |
| Bootstrap   | `run_onchange_after_10-install-packages.sh.tmpl`            |

## Installation

```sh
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply <github-user>
```

The `/lb` installer puts the `chezmoi` binary in `~/.local/bin` (which `.zshenv`
adds to `PATH`); the plain `get.chezmoi.io` installs to `./bin`, which is not on
`PATH`. This installs chezmoi, clones this repo, installs the CLI tools via mise,
and applies every config. Then make zsh your login shell:

```sh
chsh -s "$(command -v zsh)"
```

tmux plugins install themselves on first `tmux` launch (or press `prefix + I`).
Sessions are auto-saved and restored across reboots via continuum.

## Usage

| Command    | Action                          |
| ---------- | ------------------------------- |
| `dotsd`    | `chezmoi diff` — preview        |
| `dotsa`    | `chezmoi apply`                 |
| `dotsup`   | `chezmoi update` — pull + apply |
| `dotsr`    | `chezmoi re-add` — pull `$HOME` edits back |
| `dotse <f>`| edit a managed file (applies on save) |
| `dotscd`   | cd into the source repo         |

Edit dotfiles directly in `$HOME`, then `chezmoi re-add` to pull the changes
back into the repo and commit from `dotscd`. The only templated file is
`dot_gitconfig.tmpl` (it injects your name/email) — `re-add` skips templates, so
edit that one at the source with `dotse` (it applies on save).
