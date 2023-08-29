#!/bin/sh

# -----------------------------------------------------------------------------
# Zero-Clause BSD
#
# Permission to use, copy, modify, and/or distribute this software for
# any purpose with or without fee is hereby granted.
# 
# THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL
# WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE
# FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY
# DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
# AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
# OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# -----------------------------------------------------------------------------

usage() {
        name=$(basename "$0")

        echo "Usage:"
        echo "  $name <apk_name> <output_dir> [args...]"
        echo "  $name <apk_name> <output_dir> -s XXXXXXXXXX"
        echo "Automatically pull an apk using adb tool."
        echo ""
        echo "Options:"
        echo "  -h, --help              Display this help message"
        echo "  -s <serial_number>      Specify the device serial number"
}

if [ "$#" -lt 2 ]; then
        usage
        exit 1
fi

# Variables
adb_args=""
pkg_name=""
output_dir=""
pkg_path=""

# Check if adb is installed
if ! command -v adb > /dev/null 2>&1; then
        echo "ADB is not installed. Please install Android SDK Platform Tools." >&2
        exit 1
fi

# Check if there are any connected devices
if [ -z "$(adb devices | grep -w 'device')" ]; then
        echo "No devices found. Connect a device and try again." >&2
        exit 1
fi

# Parse arguments
pkg_name=$1
output_dir=$2
shift 2

while [ $# -gt 0 ]; do
        case $1 in
                "--help" | "-h")
                        usage
                        exit 0
                ;;
                "-s")
                        if [ $# -lt 2 ]; then
                                echo "Error: Missing argument for -s option." >&2
                                exit 1
                        fi

                        adb_args="$adb_args -s $2"
                        shift 2
                ;;
                *)
                        echo "Unknown argument: $1" >&2
                        exit 1
                ;;
        esac
done

# Set a default value for adb_args if it is unset or empty
adb_args="${adb_args:-}"

pkg_name=$(adb $adb_args shell pm list packages | grep "$pkg_name")
if [ -z "$pkg_name" ]; then
        echo "Package not found or invalid. Please provide a valid package name." >&2
        exit 1
fi

# If multiple packages are found, prompt the user to select one
if [ "$(echo "$pkg_name" | wc -l)" -gt 1 ]; then
        echo "Multiple packages found:"
        packages=$(echo "$pkg_name" | nl)
        echo "$packages"

        while true; do
                printf "Select a package number from the list above: "
                read -r selection

                selected_package=$(echo "$packages" | awk -v sel="$selection" '$1 == sel {print $2}')
                if [ -n "$selected_package" ]; then
                        pkg_name="$selected_package"
                        break
                else
                        echo "Invalid selection. Please choose a number from the list." >&2
                fi
        done
fi

# Remove the "package:" prefix using parameter expansion
pkg_name="${pkg_name#package:}"
pkg_path=$(adb $adb_args shell pm path "$pkg_name")

# If multiple path are found, prompt the user to select one
if [ "$(echo "$pkg_path" | wc -l)" -gt 1 ]; then
        echo "Multiple packages path found:"
        packages=$(echo "$pkg_path" | nl)
        echo "$packages"

        while true; do
                printf "Select a package path number from the list above: "
                read -r selection

                selected_package=$(echo "$packages" | awk -v sel="$selection" '$1 == sel {print $2}')
                if [ -n "$selected_package" ]; then
                        pkg_path="$selected_package"
                        break
                else
                        echo "Invalid selection. Please choose a number from the list." >&2
                fi
        done
fi

# Remove the "package:" prefix using parameter expansion
pkg_path="${pkg_path#package:}"
adb $adb_args pull "$pkg_path" "$output_dir"
