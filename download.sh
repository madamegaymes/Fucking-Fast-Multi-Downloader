#!/usr/bin/env bash

working_dir=$( dirname -- "$( readlink -f -- "$0"; )"; )
input="$working_dir/input.txt"
md5_results="$working_dir/md5.txt"
icon="$working_dir/fg.jpg"
appname="FitGirl Repack Downloader"
extract=0
download_dir="$HOME/Games/installers"

if [[ -f $input ]]; then
    html=$(cat input.txt)
fi

echo "" > "$md5_results"

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
        mapfile -t checksums < "$game/MD5/fitgirl-bins.md5" || continue
        checksums=("${checksums[@]:1}")
        echo "Verify MD5 checksums for $game..."
        for line in "${checksums[@]}"; do
            path=$(echo "$line" | awk -F"\\" '{print $NF}')
            path=${path/$'\r'}
            expected_sum=$(echo "$line" | awk '{print $1}')
            to_check="$game/$path"
            received_sum=""
            if [[ -f $to_check ]]; then
                received_sum=$(md5sum "$to_check" | awk '{print $1}')
            elif [[ $path == *"optional"* ]]; then
                echo -e "SKIPPED: $path does not exist and is optional." | tee -a "$md5_results"
                continue
            fi
            if [[ $expected_sum == "$received_sum" ]]; then
                echo -e "PASSED: $received_sum  $path" >> "$md5_results"
            else
                echo -e "FAILED: $path does not match MD5\nExpected: $expected_sum\nReceived: $received_sum" >> "$md5_results"
                msg="Some files failed verification."
                ((failure++))
                failed+=" $path"
            fi
        done
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
    cat "$md5_results"
fi