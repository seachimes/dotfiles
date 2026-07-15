# Initialise external tools.
# mise MUST come first: it puts the mise-managed tools (starship, zoxide, fzf,
# atuin, …) on PATH, so their init below can find them on a fresh machine.

# mise (runtime/version manager)
if [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
elif command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# starship prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# zoxide (smarter cd)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# fzf key bindings + completion (fzf >= 0.48 ships its own integration;
# the bootstrap keeps a modern fzf installed via mise)
if command -v fzf >/dev/null 2>&1 && fzf --zsh >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# ghq + fzf: jump to any ghq-managed repository (Ctrl-G).
if command -v ghq >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
  _ghq_fzf_widget() {
    local root repo
    root=$(ghq root) || return
    repo=$(ghq list | fzf --preview "eza -la --icons --git ${root}/{} 2>/dev/null || ls -la ${root}/{}") || return
    [[ -n "$repo" ]] || return
    BUFFER="cd ${(q)root}/${repo}"
    zle accept-line
  }
  zle -N _ghq_fzf_widget
  bindkey '^g' _ghq_fzf_widget
fi

# atuin (magical shell history) — owns Ctrl-R, leaves the up arrow alone
command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh --disable-up-arrow)"

# OSC 7: report the working directory so terminals (wezterm, etc.) can open new
# tabs/panes in the same directory instead of falling back to $HOME.
autoload -Uz add-zsh-hook
_osc7_report_cwd() {
  emulate -L zsh -o extended_glob
  # percent-encode everything outside the URL path-safe set
  local encoded=${PWD//(#m)[^A-Za-z0-9_.~\/-]/%${(l:2::0:)$(([##16]#MATCH))}}
  printf '\e]7;file://%s%s\e\\' "${HOST}" "${encoded}"
}
add-zsh-hook -Uz chpwd _osc7_report_cwd
_osc7_report_cwd   # report the initial directory
