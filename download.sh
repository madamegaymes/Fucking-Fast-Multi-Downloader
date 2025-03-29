#!/usr/bin/env bash

input="input.txt"
icon="$PWD/fg.jpg"
appname="FitGirl Repack Downloader"
extract=0

if [[ -f $input ]]; then
    html=$(cat input.txt)
fi

usage() {
cat << EOF
Usage: ./$(basename -- "$0") [options]

Options:
                        | By default, assume input.txt is just a list of URLs
    -e, --extract-urls  | Assume input.txt is HTML and extract the links from it
    -h, --help          | Print this help message
EOF
}

case $1 in
    -e|--extract-urls)
        extract=1
    ;;
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

if [[ $extract -eq 1 ]]; then
    echo "Cleaning HTML URLs..."
    echo "$html" | grep 'https://fuckingfast.co/' | awk '{print $2}' | cut -c 6- - | sed 's/"//g' > $input
fi

echo "Downloading files from $input..."
if notify-send -v >/dev/null 2>&1; then
    python fuckingfast.py || notify-send -a "$appname" -i "$icon" -u critical "Error" "Something went wrong trying to download the links from $input"
    notify-send -a "$appname" -i "$icon" "Completed" "Downloaded all fuckingfast links from $input"
else
    python fuckingfast.py || echo "ERROR: Something went wrong trying to download the links from $input"
    echo "Downloaded all fuckingfast links from $input"
fi
