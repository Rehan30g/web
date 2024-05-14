#!/bin/bash

# Simple bash script to download files using wget in Termux
# By Rehan30g

# Function to print large text with random colors
print_random_colors() {
    local text="$1"
    figlet "$text" | while IFS= read -r line; do
        local color=$((31 + RANDOM % 7))  # Generate a random color code (31-37 for standard colors)
        echo -e "\e[1;${color}m${line}\e[0m"
    done
}

# Function to check if a package is installed
check_package() {
    dpkg -s "$1" &> /dev/null
    return $?
}

# Required packages
required_packages=("termux-api" "wget" "figlet")

# Check and install missing packages
for pkg in "${required_packages[@]}"; do
    if ! check_package "$pkg"; then
        read -p "$pkg is not installed. Install $pkg? (y/n): " answer
        if [[ "$answer" == [Yy]* ]]; then
            pkg install "$pkg" -y
        else
            echo "$pkg is required. Exiting."
            exit 1
        fi
    fi
done

# Clear the screen
clear

# Header
print_random_colors "TDL"
echo -e "\n\e[1;34mTermux Downloader\e[0m\n"
echo -e "\n\e[0;32mBy rehan30g\e[0m\n"

# Spacer
echo -e "\n\n"

# URL input
read -p "Enter the URL to download: " url

# Spacer
echo -e "\n\n"

# Notification start
termux-notification --title "Download Started" --content "Downloading from $url"

# Change directory
cd /storage/0088-A210/Termux-Downloader # Adjust your download location

# Spacer
echo -e "\n\n"

# Download
if wget "$url"; then
    termux-notification --title "Download Success" --content "Download completed successfully!"
    exit 0  # Success
else
    # Failed
    termux-notification --title "Download Failed" --content "The download failed. Check the URL and try again."
    exit 1  # Failure
fi
