# Subdomain Reconnaissance Tool

## Overview
This shell script is a simple yet effective tool for harvesting and filtering subdomains for a given domain using the assetfinder utility. It automates the process of subdomain enumeration, which is a crucial step in security assessments and penetration testing.

## Features
- **Automated Subdomain Discovery**: Leverages assetfinder to discover subdomains related to a target domain
- **Intelligent Filtering**: Automatically filters results to include only relevant subdomains
- **Organized Output**: Creates a structured directory for each target and stores results in an easy-to-access format
- **Command-line Options**: Supports customizable output locations and temporary file retention
- **Dependency Checking**: Verifies that required tools are installed before execution

## Usage
```bash
./assetFinDir.sh [options] <domain>
```

Options

    -o, --output DIR: Specify custom output directory (default: domain name)
    -k, --keep: Keep temporary files after execution
    -h, --help: Display help information

Example
```bash
./assetFinDir.sh example.com
```

This will:
1. Create a directory structure example.com/recon/
2. Harvest subdomains using assetfinder
3. Filter the results to include only relevant subdomains
4. Save the final results to example.com/recon/final.txt

Requirements
- Bash shell environment
- assetfinder tool installed and available in PATH
