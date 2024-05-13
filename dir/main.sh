#!/bin/bash

# Asking for the URL
read -p "Enter the URL to download: " url

# Displaying a notification that the download has started
termux-notification --title "Download Started" --content "Downloading from $url"

# Change the directory to /sdcard/ and start downloading the file
cd /storage/0088-A210/Termux-Downloader
if wget "$url"; then
    # Notification for successful download
    termux-notification --title "Download Success" --content "Download completed successfully!"
    exit 0  # Exiting with success status
else
    # Notification for failed download
    termux-notification --title "Download Failed" --content "The download failed. Check the URL and try again."
    exit 1  # Exiting with failure status
fi
