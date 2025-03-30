# Fucking-Fast-Multi-Downloader for Steam Deck

This tool helps to download multiple files easily from fuckingfast.co.

This modified fork is focused on Steam Deck users that want to try out games from fitgirl-repacks.site before they make a purchase.

## Requirements

* Python v3.8+
* bash
* unrar
* md5sum
* nano (optional, to remove optional/selective download links while running the script)
* notify-send (optional, sends a desktop notification when downloads are finished)

These should all already be installed in SteamOS. You can run the following set of commands in Konsole to make sure they are installed:

```shell
sudo steamos-readonly disable # only necessary for Steam Deck users
sudo pacman -Syy --noconfirm python3 unrar md5sum nano
```

If you're on Steam Deck, and the pacman command above gives errors regarding keys or signatures, run these commands first and then re-try the above:

```shell
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --populate holo
```

## Usage

_NOTE: FitGirl recently implemented DDoS protection, which defeats the ability to use HTML requests modules without a lot of extra effort. You need to follow a few steps, but the process is still fairly convenient compared to individually downloading each link from the game page._

1. Go to the game page
2. Find the FuckingFast section and click the `+` to expand it
3. Right-click the white-space just to the right of the links and choose `Inspect`
4. Right-click the DIV element and choose `Copy` > `Inner HTML`
    - The HTML tag for the section should look like: `<div class="su-spoiler-content su-u-clearfix su-u-trim">`
5. In the repo's directory, create the file `input.txt` and paste in the HTML you just copied
6. Repeat steps 1-5 and paste in as many fuckingfast links as you want to `input.txt` (including game update links)
7. Save `input.txt`
8. Run the script: `./download.sh --extract-urls`

The script will:

1. Activate or create the python venv and make sure dependencies are installed
2. Extract the URLs from the HTML and download each one
3. Once all files in `input.txt` are downloaded, for each game:
    1. `unrar` the game files
    2. Verify file integrity against fitgirl's checksums

You can also paste in a regular list of fuckingfast links (with no HTML tags, only raw URLs) into `input.txt`. You would then run the script without the extract argument: `./download.sh`.

# Disclaimer

This tool is created for educational purposes and ethical use only. Any misuse of this tool for malicious purposes is not condoned. The developers of this tool are not responsible for any illegal or unethical activities carried out using this tool.
