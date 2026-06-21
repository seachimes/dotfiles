# Initialise the completion system. Sourced from plugins.txt at the right point
# in load order (after fpath completions, before fzf-tab / syntax highlighting).
autoload -Uz compinit
_zcompcache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$_zcompcache" ]] || mkdir -p "$_zcompcache"
# -C skips the slow security check on the cached dump for faster startup.
compinit -C -d "$_zcompcache/zcompdump"
unset _zcompcache
