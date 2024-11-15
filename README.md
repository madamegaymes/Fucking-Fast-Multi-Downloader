# Fucking-Fast-Multi-Downloader
This Tool Helps To Download Multiple Files Easily From fuckingfast.co


## Features
- **Link Processing**: Reads links from an `input.txt` file for sequential processing.
- **File Downloading**: Extracts downloadable URLs from webpage scripts and downloads files to a `downloads` folder.
- **Progress Tracking**: Displays real-time progress bars for downloads.
- **Logging**: Provides detailed console logs with timestamps and color-coded messages for success, errors, warnings, and general information.
- **Error Handling**: Skips and logs links if any issues occur during processing.
- **Link Removal**: Removes successfully processed links from the `input.txt` file to avoid duplicate processing.



## Prerequisites
Ensure you have the following installed before running the script:
- Python 3.8+
- Required Python packages (install with `pip install -r requirements.txt`):
  - `requests`
  - `beautifulsoup4`
  - `tqdm`
  - `colorama`



## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/web-scraper-downloader.git
   cd web-scraper-downloader
   ```
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```



## Usage
1. **Prepare Input Links**: Add your URLs to `input.txt`, one per line.
2. **Run the Script**:
   ```bash
   python downloader.py
   ```
3. The script will:
   - Process each link in `input.txt`.
   - Extract and download files to the `downloads` folder.
   - Remove processed links from `input.txt`.


## Folder Structure
```
web-scraper-downloader/
├── downloader.py       # Main script
├── input.txt           # Input file containing links
├── downloads/          # Folder to save downloaded files
├── requirements.txt    # Python dependencies
```

---

## Customization
You can modify the script to:
- Use a different log format or colors (edit the `console` class).
- Customize headers for HTTP requests (`headers` dictionary).
- Change the download directory (`downloads_folder` variable).


## License
This project is licensed under the MIT License. See the `LICENSE` file for details.


## Contributions
Feel free to fork, improve, and submit pull requests. For any issues or feature requests, create a ticket in the [issues section](https://github.com/yourusername/web-scraper-downloader/issues).


## Disclaimer
This script is intended for educational purposes. Ensure you have proper permissions before scraping or downloading from any website.
