#!/bin/env bash

set -Eeuo pipefail

top_n="${1:-5}"

result_tmpfile="$(mktemp)"

trap "rm -f $result_tmpfile" EXIT

measure_download() {
    while read -r server; do
        if [[ "$server" = 'https://geo-mirror.chaotic.cx/$repo/$arch' ]]; then
            continue
        fi
        read -r base_url < <(echo "$server" | sed 's/$repo/chaotic-aur/g' | sed 's/$arch/x86_64/g')
        read -r startt speed < <(curl -sLw '%{time_starttransfer} %{speed_download}\n' -o /dev/null "$base_url/chaotic-aur.files.tar.zst")
        echo "$startt $speed $server"
    done
}

curl -sL 'https://raw.githubusercontent.com/chaotic-aur/pkgbuild-chaotic-mirrorlist/main/mirrorlist' |
    rg -r'$1' '^ *Server = (http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|)+)' |
    measure_download >"$result_tmpfile"

echo "Show last $top_n mirrors..."
echo 'Sort by speed:'
sort -rnk2 <"$result_tmpfile" | head -"$top_n"
echo
echo 'Sort by ping:'
sort -nk1 <"$result_tmpfile" | head -"$top_n"
