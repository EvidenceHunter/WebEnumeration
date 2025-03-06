#!/bin/bash

# Function to display help
show_help() {
    echo "Usage: $0 [options] <domain>"
    echo "Options:"
    echo "  -o, --output DIR    Output directory (default: domain name)"
    echo "  -k, --keep          Keep temporary files"
    echo "  -h, --help          Show this help message"
    exit 0
}

# Function to check dependencies
check_dependencies() {
    if ! command -v assetfinder &> /dev/null; then
        echo "Error: assetfinder is not installed"
        exit 1
    fi
}

# Function to set up directories
setup_directories() {
    local dir="$1"
    mkdir -p "$dir/recon"
    echo "[+] Directories created: $dir/recon"
}

# Function to harvest subdomains
harvest_subdomains() {
    local domain="$1"
    local output="$2"
    echo "[+] Harvesting subdomains for $domain..."
    assetfinder "$domain" > "$output"
    echo "[+] Found $(wc -l < $output) subdomains"
}

# Function to filter results
filter_results() {
    local domain="$1"
    local input="$2"
    local output="$3"
    echo "[+] Filtering relevant domains..."
    grep "$domain" "$input" > "$output"
    echo "[+] Found $(wc -l < $output) relevant domains"
}

# Default values
output_dir=""
keep_temp=false

# Process parameters
while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--output)
            output_dir="$2"
            shift 2
            ;;
        -k|--keep)
            keep_temp=true
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            url="$1"
            shift
            ;;
    esac
done

# Error handling for missing URL
if [ -z "${url:-}" ]; then
    echo "Error: URL parameter is missing"
    show_help
fi

# Check dependencies
check_dependencies

# Set up directories
base_dir="${output_dir:-$url}"
recon_dir="$base_dir/recon"
assets_file="$recon_dir/assets.txt"
final_file="$recon_dir/final.txt"

setup_directories "$base_dir"

# Harvest subdomains
harvest_subdomains "$url" "$assets_file"

# Filter results
filter_results "$url" "$assets_file" "$final_file"

# Clean up
if [ "$keep_temp" = false ]; then
    rm "$assets_file"
    echo "[+] Temporary files removed"
else
    echo "[+] Temporary files kept: $assets_file"
fi

echo "[+] Done! Results saved to: $final_file"