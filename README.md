# Fucking-Fast-Multi-Downloader

This Tool Helps To Download Multiple Files Easily From fuckingfast.co

It Can Be Used To Get Multiple Parts Easily For Games In fitgirl-repacks.site

## Requirements

* Python v3.8+
* bash
* nano (optional, to remove optional/selective download links while running the script)
* notify-send (optional, sends a desktop notification when downloads are finished)

## Usage

The script will automatically create a python venv and install needed modules for you.

To simply download all fuckingfast links from a fitgirl page:

```bash
./download.sh https://fitgirl-repacks.site/avowed
```

You can also run the script multiple times to create a larger list of download links from multiple different game links, and then get them all at the same time.

```bash
./download.sh --append https://fitgirl-repacks.site/avowed
./download.sh --append https://fitgirl-repacks.site/kingdom-come-deliverance-2
# if you don't have nano and want to remove any optional or selective links,
# remove them from input.txt before moving on
./download.sh --download
```

# Disclaimer

This tool is created for educational purposes and ethical use only. Any misuse of this tool for malicious purposes is not condoned. The developers of this tool are not responsible for any illegal or unethical activities carried out using this tool.

[![Star History Chart](https://api.star-history.com/svg?repos=JOY6IX9INE/Fucking-Fast-Multi-Downloader&type=Date)](https://star-history.t9t.io/#JOY6IX9INE/Fucking-Fast-Multi-Downloader&Date)
