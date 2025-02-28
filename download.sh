#!/usr/bin/env bash

input="input.txt"
icon="$PWD/fg.jpg"
appname="FitGirl Repack Downloader"
html="fitgirl.html"
down=0
append=0

case $1 in
    -a|--append)
        append=1
        curl -s "$2" > $html
    ;;
    -d|--download)
        down=1
    ;;
    *)
        curl -s "$1" > $html
    ;;
esac

data="$(cat $html)"

if [[ -z $data ]] && [[ $down -eq 0 ]]; then
    echo "Missing html data"
    exit 1
fi

if [[ ! -d .venv ]]; then
    python -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
else
    source .venv/bin/activate
fi

if [[ $down -eq 0 ]]; then
    echo "Scraping links from URL..."
    if [[ $append == 0 ]]; then
        echo "$data" | grep 'https://fuckingfast.co/' | awk '{print $2}' | cut -c 6- - | sed 's/"//g' > $input
    else
        echo "$data" | grep 'https://fuckingfast.co/' | awk '{print $2}' | cut -c 6- - | sed 's/"//g' >> $input
    fi
fi

if nano -V >/dev/null 2>&1; then
    echo "Searching for selective and optional files..."
    grep -E "(selective)|(optional)" $input
    read -rp "Need to remove any selective or optional files before downloading? (y/N): " CONTINUE
    case $CONTINUE in
        Y|y|Yes|yes|YES) nano $input;;
    esac
fi

if [[ $append -eq 0 ]] || [[ $down -eq 1 ]]; then
    echo "Downloading files from $input..."
    if notify-send -v >/dev/null 2>&1; then
        python fuckingfast.py || notify-send -a "$appname" -i "$icon" -u critical "Error" "Something went wrong trying to download the links from $input"
        notify-send -a "$appname" -i "$icon" "Completed" "Downloaded all fuckingfast links from $input"
    else
        python fuckingfast.py || echo "ERROR: Something went wrong trying to download the links from $input"
        echo "Downloaded all fuckingfast links from $input"
    fi
    rm $input
else
    echo "Appended download links to existing $input"
fi

rm $html
