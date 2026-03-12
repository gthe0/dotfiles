#!/usr/bin/env bash

set -eu

usage() {
    echo "Usage: $0 [-u] manifest_file [term1 term2 ...]"
    exit 1
}

do_symlink() {
	src="$1"
    dest="$2"

    # If dest is a directory, append basename of src
    if [ -d "$dest" ]; then
        dest="$dest/$(basename "$src")"
    fi

    mkdir -p $(dirname "$dest")

    if [ -L "$dest" ]; then
        echo "[WARNING] $src already symlinked"
        return
    fi

    if [ -e "$dest" ]; then
        echo "[ERROR] $dest exists but it's not a symlink. Please fix that manually"
        exit 1
    fi

    ln -s "$src" "$dest"
    echo "[OK] $src -> $dest"
}

undo_symlink() {
    dest="$1"

    if [ -L "$dest" ]; then
        rm "$dest"
        echo "[OK] removed symlink $dest"
    elif [ -e "$dest" ]; then
        # Exists but not a symlink
        echo "[ERROR] $dest exists but is not a symlink. Not touching it."
        exit 1
    else
        # Nothing there
        echo "[WARNING] $dest does not exist"
    fi
}


# Parse options
UFLAG=0
while getopts ":u" opt; do
  case $opt in
    u) UFLAG=1 ;;
    *) usage ;;
  esac
done
shift $((OPTIND -1))

# Check arguments
if [ $# -lt 1 ]; then
    usage
fi

manifest="$1"
shift

configs=("$@")
section=$(sed -n "/^\[Linux\]/,/^\[/p" "$manifest" | sed '1d;$d' | grep -v '^#')

if [ -z $@ ]; then
    while IFS= read -r line; do
        key=$(  echo "$line" | cut -d = -f 1 | tr -d ' "')
        value=$(echo "$line" | cut -d = -f 2 | tr -d ' "')

        key="$(pwd)/$key"
        value=$(eval echo "$value")
        # Symlink function
        if [ "$UFLAG" -eq 0 ]; then
            do_symlink $key $value
        else 
            undo_symlink $value
        fi

    done <<< "$section"
else
    for i in "${configs[@]}"
    do
        mapping=$(echo "$section" | grep -iw "$i" | tr -d ' "')

        key=$(echo "$mapping" | cut -d = -f 1)
        value=$(echo "$mapping" | cut -d = -f 2)

        key="$(pwd)/$key"
        value=$(eval echo "$value")
        # Symlink function
        if [ "$UFLAG" -eq 0 ]; then
            do_symlink $key $value
        else 
            undo_symlink $key $value
        fi

    done
fi

