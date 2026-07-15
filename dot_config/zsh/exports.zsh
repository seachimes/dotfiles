# Environment variables for interactive shells.

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-FRX"

# --- fzf: blue palette matching the starship theme ---
export FZF_DEFAULT_OPTS="\
--height 40% --layout reverse --border rounded \
--color=hl:#6c94ff,fg+:#ffffff,bg+:#212736,hl+:#769ff0 \
--color=info:#a0a9cb,prompt:#6c94ff,pointer:#769ff0 \
--color=marker:#6c94ff,spinner:#769ff0,header:#769ff0,border:#394260"
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi

# --- bat / eza theming ---
export BAT_THEME="Coldark-Dark"
export EZA_COLORS="di=38;5;111:ln=38;5;110:ur=38;5;75:uw=38;5;111:ux=38;5;110"

# --- ghq (repository manager) ---
export GHQ_ROOT="$HOME/ghq"   # where ghq clones live; also ghq's default, declared explicitly
