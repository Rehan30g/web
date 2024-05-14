#!/bin/bash
# hello :3
# Uhh, this is a simple bash code to download web/img/any file using wget for termux
# You can sample this code without include credits btw

## Package Required:
# - termux-api --> pkg install termux-api
# - wget --> pkg install wget
# - figlet --> pkg install figlet
# don't worry if Pkg is missing, Bash will detect and auto install pkg

# Termux Only

# Code by Rehan30g

# Download location (change this to your desired location)
DOWNLOAD_LOCATION="/storage/0088-A210/Termux-Downloader"

# Function to print large text with random colors
print_random_colors() {
    local text="$1"
    figlet "$text" | while IFS= read -r line; do
        local color=$((31 + RANDOM % 7))  # Random color code (31-37)
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
missing_packages=()

# Check for missing packages
for pkg in "${required_packages[@]}"; do
    if ! check_package "$pkg"; then
        missing_packages+=("$pkg")
    fi
done

# Display required and missing packages
if [ ${#missing_packages[@]} -ne 0 ]; then
    echo -e "Package Required"
    for pkg in "${required_packages[@]}"; do
        if [[ " ${missing_packages[@]} " =~ " $pkg " ]]; then
            echo -e " 🟥 $pkg"
        else
            echo -e " 🟩 $pkg"
        fi
    done

    # Install missing packages
    echo -e "\n"
    if [ ${#missing_packages[@]} -eq 1 ]; then
        read -p "${missing_packages[0]} is not installed. Install package? (y/n): " answer
    else
        read -p "${missing_packages[*]} are not installed. Install packages? (y/n): " answer
    fi

    if [[ "$answer" == [Yy]* ]]; then
        for pkg in "${missing_packages[@]}"; do
            pkg install "$pkg" -y
        done
    else
        echo "Required packages not installed. Exiting."
        exit 1
    fi
fi

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
cd "$DOWNLOAD_LOCATION" # Adjust your download location

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
