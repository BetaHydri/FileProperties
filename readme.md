# FileProperties PowerShell Module

## Overview

The **FileProperties** PowerShell module provides a convenient way to enumerate and retrieve extended properties of files in a specified directory. It supports filtering by file type and includes options for recursive searches.

## Features

- Retrieve extended file properties such as:
  - OriginalFilename
  - FileName
  - FileDescription
  - ProductName
  - Comments
  - CompanyName
  - FileVersion
  - FileVersionUpdated
  - ProductVersion
  - Language
  - CreationTime
  - File Size
- Filter files by type (e.g., `*.exe`, `*.dll`).
- Perform recursive searches in directories.

## Requirements

- PowerShell version 3.0 or higher.

## Installation

1. Copy the `FileProperties.psm1` and `FileProperties.psd1` files to a directory.
2. Import the module into your PowerShell session using the following command:

   ```powershell
   Import-Module -Name "Path\To\FileProperties.psm1"