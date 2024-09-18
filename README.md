 # PowerShell URL Automator Script

## Description
This repository contains a PowerShell script designed to automate the opening of URLs in Google Chrome. The script reads a list of URLs from a specified file, opens each URL in Chrome, and logs their processing status in a CSV file. It also includes support for loading environment variables from a `.env` file.

## Usage
1. **Clone the Repository**: Clone this repository to your local machine using `git clone`.
2. **Set Up Environment Variables**: Create a `.env` file in the root directory of the project with the following format:
    ```
    BROWSER_PATH=C:\Path\To\Chrome.exe
    LIST_OF_URLS_FILE=path\to\your\urls.txt
    CSV_PATH=path\to\output.csv
    ```
3. **Run the Script**: Execute `automate_urls.ps1` by navigating to the project directory and running:
    ```powershell
    .\powerShell-url-automator\automate_urls.ps1
    ```

## FAQ
**Q: What happens if a URL fails to open?**  
A: If a URL fails to open, an error message will be displayed in the console. The script will continue processing the remaining URLs.

**Q: Can I modify the delay between opening URLs?**  
A: Yes, you can change the sleep duration (in seconds) by modifying the `Start-Sleep -Seconds 15` lines within the `automate_urls.ps1` script to a different value as needed.

**Q: How do I add new URLs to the list?**  
A: Add new URLs to the file specified in the `.env` file under `LIST_OF_URLS_FILE`. Each URL should be on a new line.

## Resources
- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [Google Chrome Developer Tools](https://developer.chrome.com/devtools)

## Configuration
The script relies on the following environment variables:
- `BROWSER_PATH`: Path to the Google Chrome executable.
- `LIST_OF_URLS_FILE`: Path to the file containing the list of URLs to be opened.
- `CSV_PATH`: Path to the CSV file where processed URL status will be logged.

## Features
- Automates opening multiple URLs in Google Chrome.
- Logs each URL's processing status into a CSV file.
- Loads environment variables from a `.env` file for configuration.

## Considerations
- Ensure that the paths specified in the `.env` file are correct and valid.
- The script assumes that the browser path provided opens Chrome with the necessary permissions to open multiple tabs.

---

Feel free to modify this README according to your specific requirements or add additional sections as needed!