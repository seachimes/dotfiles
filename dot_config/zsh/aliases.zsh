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

# --- tmux ---
if command -v tmux >/dev/null 2>&1; then
  alias t='tmux'
  alias ta='tmux attach -t'
  alias tn='tmux new -s'
  alias tl='tmux ls'
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
