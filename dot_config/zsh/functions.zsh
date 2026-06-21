# Helper functions.

# Make a directory (and parents) then cd into it.
mkcd() { mkdir -p -- "$1" && cd -- "$1"; }

# Extract most archive types by extension.
extract() {
  [[ -f "$1" ]] || { echo "extract: '$1' is not a file"; return 1; }
  case "$1" in
    *.tar.gz|*.tgz)  tar xzf "$1" ;;
    *.tar.bz2|*.tbz) tar xjf "$1" ;;
    *.tar.xz)        tar xJf "$1" ;;
    *.tar)           tar xf  "$1" ;;
    *.zip)           unzip   "$1" ;;
    *.gz)            gunzip  "$1" ;;
    *.bz2)           bunzip2 "$1" ;;
    *) echo "extract: don't know how to extract '$1'" ;;
  esac
}
