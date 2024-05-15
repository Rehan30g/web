#!/bin/bash
print_random_colors() {
    local text="$1"
    figlet "$text" | while IFS= read -r line; do
        local color=$((31 + RANDOM % 7))  # Random color code (31-37)
        echo -e "\e[1;${color}m${line}\e[0m"
    done
}
check_package() {
    dpkg -s "$1" &> /dev/null
    return $?
}
required_packages=("figlet")
missing_packages=()
for pkg in "${required_packages[@]}"; do
    if ! check_package "$pkg"; then
        missing_packages+=("$pkg")
    fi
done
if [ ${#missing_packages[@]} -ne 0 ]; then
    echo -e "Package Required"
    for pkg in "${required_packages[@]}"; do
        if [[ " ${missing_packages[@]} " =~ " $pkg " ]]; then
            echo -e " 🟥 $pkg"
        else
            echo -e " 🟩 $pkg"
        fi
    done
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
clear
# Header
print_random_colors "PKG Uninstaller"
echo -e "\n\e[1;33mDelete Any Package Using this App\e[0m\n"
echo -e "\n\e[0;32mBy: Rehan30g\e[0m\n"

# Spacer
echo -e "\n-------------------------------------------\n"

# Package input
read -p "Choose Package: " packages

echo -e "-------------------------------------------\n"

# Uninstall packages
for pkg in $packages; do
    pkg uninstall "$pkg" -y
done

echo -e "\n\e[1;32mUninstallation complete.\e[0m\n"

# Exit
exit 0
