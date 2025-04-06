#!/usr/bin/env bash

working_dir="$HOME/Games/installers"

if [[ -z $1 ]]; then
    echo -e "ERROR: Missing game name argument\n\nFOUND GAMES:"
    find "$working_dir" -maxdepth 1 -type d | sed "s,$working_dir/,,g" | sed 1d
    exit 1
fi

game="$1"
failures=0
failed="Failed Checksums:"
msg="All files verified for $game."
cd "$working_dir" || exit 1

if [[ ! -d $game ]]; then
    echo "ERROR: Game directory not found"
    exit 1
fi

md5_results="$working_dir/${game}_md5.txt"
echo "" > "$md5_results"
mapfile -t checksums < "$game/MD5/fitgirl-bins.md5" || exit 1

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
    else
        echo -e "FAILED: $path does not exist and is not optional." | tee -a "$md5_results"
        continue
    fi
    if [[ $expected_sum == "$received_sum" ]]; then
        echo -e "PASSED: $received_sum  $path" | tee -a "$md5_results"
    else
        echo -e "FAILED: $path does not match MD5\nExpected: $expected_sum\nReceived: $received_sum" | tee -a "$md5_results"
        msg="Some files for $game failed verification."
        ((failures++))
        failed+=" $path"
    fi
done

echo -e "\n$msg\n"
if [[ $failures -gt 0 ]]; then
    echo -e "Total: $failures\n$failed\n"
    exit 1
else
    exit 0
fi
