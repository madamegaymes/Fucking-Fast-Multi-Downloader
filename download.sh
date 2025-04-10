#!/usr/bin/env bash

working_dir=$( dirname -- "$( readlink -f -- "$0"; )"; )
input="$working_dir/input.txt"
verify="$working_dir/verify.sh"
icon="$working_dir/fg.jpg"
appname="FitGirl Repack Downloader"
download_dir="$HOME/Games/installers"

if [[ ! -f $input ]]; then
    nano "$input"
fi

html=$(cat input.txt)

echo "" > "$input"

usage() {
cat << EOF
Usage: ./$(basename -- "$0")

If input.txt does not exist, nano will open the file for you to paste in URLs.
URLs can be raw or contained in HTML tags as copied from fitgirl's site.
EOF
}

case $1 in
    -h|--help)
        usage
        exit 0
    ;;
esac

if [[ -z $html ]]; then
    echo "Missing input URLs"
    exit 1
fi

if [[ ! -d .venv ]]; then
    python -m venv .venv || exit 1
    source .venv/bin/activate || exit 1
    pip install -r requirements.txt || exit 1
else
    source .venv/bin/activate || exit 1
fi

echo "$html" | while IFS="" read -r p || [ -n "$p" ]; do
    if [[ ! "$p" =~ ^https ]]; then
        echo "$p" | awk -F'"' '{print $2}' >> "$input"
    else
        echo "$p" >> "$input"
    fi
done

echo "Downloading files from $input..."
if notify-send -v >/dev/null 2>&1; then
    python fuckingfast.py || notify-send -a "$appname" -i "$icon" -u critical "Error" "Something went wrong trying to download the links from $input"
    notify-send -a "$appname" -i "$icon" "Download Completed" "Downloaded all fuckingfast links from $input. Checking MD5 now."
else
    python fuckingfast.py || echo "ERROR: Something went wrong trying to download the links from $input"
    echo "Downloaded all fuckingfast links from $input. Checking MD5 now."
fi

if find "$download_dir" -type f -name "*.rar" >/dev/null 2>&1; then
    echo "Extracting and verifying rar files..."
    cd "$download_dir" || exit 1
    array=()
    msg="All files passed verification."
    failure=0
    failed="Failed:"
    for rar in *.rar; do
        tag=$(echo "$rar" | awk -F'-' '{print $1}')
        if [[ ! " ${array[*]} " =~ [[:space:]]${tag}[[:space:]] ]]; then
            array+=("$tag")
        fi
    done
    for game in "${array[@]}"; do
        IFS=$'\n' read -r -a part_one <<< "$(ls -1tr -- "$game"*)"
        mkdir -p "$game"
        echo "Found rar files for $game..."
        unrar x "${part_one[0]}" "$game/" || continue
        if ! $verify "$game"; then
            ((failed++))
            failed+=" $game"
        fi
    done
    if notify-send -v >/dev/null 2>&1; then
        if [[ $failure -gt 0 ]]; then
            notify-send -u critical -a "$appname" -i "$icon" "MD5 Verified" "$msg\n$failed"
        else
            notify-send -a "$appname" -i "$icon" "MD5 Verified" "$msg"
        fi
    fi
    echo "$msg"
    if [[ $failure -gt 0 ]]; then
        echo "$failed"
    fi
fi

rm "$input"
