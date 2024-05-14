#!/bin/bash
# hello :3
# Uhh, this is a simple bash code to download web/img/any file using wget for termux
# You can sample this code without include credits btw

## Package Required:
# - termux-api --> pkg install termux-api
# - wget --> pkg install wget
# Termux Only

# Code by Rehan30g

# Asking
read -p "Enter the URL to download: " url

# notification download started
termux-notification --title "Download Started" --content "Downloading from $url"


cd /storage/0088-A210/Termux-Downloader # Set this to your download location
if wget "$url"; then
    termux-notification --title "Download Success" --content "Download completed successfully!"
    exit 0  # success
else
    # failed download
    termux-notification --title "Download Failed" --content "The download failed. Check the URL and try again."
    exit 1  # failure 
fi
