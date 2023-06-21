#!/bin/sh
echo -ne '\033c\033]0;LostArcana\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/LostArcana.x86_64" "$@"
