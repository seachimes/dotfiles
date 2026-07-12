# Shell aliases.

# --- ls -> eza ---
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -lah --group-directories-first --icons=auto --git'
  alias la='eza -a --group-directories-first --icons=auto'
  alias lt='eza --tree --level=2 --icons=auto'
else
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -A'
fi

# --- cat -> bat ---
if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
elif command -v batcat >/dev/null 2>&1; then
  alias cat='batcat --paging=never'
  alias bat='batcat'
fi

# --- grep colour ---
alias grep='grep --color=auto'

# --- editors / git tools ---
command -v nvim    >/dev/null 2>&1 && alias vim='nvim' vi='nvim'
command -v lazygit >/dev/null 2>&1 && alias lg='lazygit'

# --- claude -> headroom (token-compression proxy) ---
# `wrap` starts the proxy, sets ANTHROPIC_BASE_URL, registers the MCP retrieve
# tool, and keeps tool-search deferral on, then launches claude. Port 18787
# avoids the default 8787 (RStudio etc.). Use `command claude` for raw claude.
# Guarded so a machine without headroom still gets the real claude.
command -v headroom >/dev/null 2>&1 && alias claude='headroom wrap claude -p 18787'

# --- claude-raw: one-shot launch without the headroom wrap ---
# (e.g. before a Remote Control session). Drops the durable
# ANTHROPIC_BASE_URL override from .claude/settings.local.json, then
# launches claude directly (bypassing the `claude` alias above so it
# doesn't immediately re-wrap). Run plain `claude` next time to re-wrap.
command -v headroom >/dev/null 2>&1 && alias claude-raw='headroom unwrap claude; command claude'

# --- herdr (agent-aware multiplexer; replaced tmux) ---
if command -v herdr >/dev/null 2>&1; then
  alias t='herdr'
fi

# --- navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --- git shorthands ---
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --graph --oneline --decorate --all'

# --- tool versions (mise) ---
alias toolup='mise up'                        # bump pinned tool versions
alias toolls='mise ls'

# --- dotfiles management (chezmoi) ---
alias dots='chezmoi'
alias dotsup='chezmoi update'                 # git pull + apply
alias dotsa='chezmoi apply'
alias dotsd='chezmoi diff'
alias dotsr='chezmoi re-add'                   # pull $HOME edits back into repo (primary save flow)
alias dotse='chezmoi edit'                     # edit templated files at source (e.g. ~/.gitconfig)
alias dotscd='cd "$(chezmoi source-path)"'
