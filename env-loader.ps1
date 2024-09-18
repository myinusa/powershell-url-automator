$scriptPath = Get-Location

# Define the path to the .env file
$envFilePath = "$scriptPath\.env"

# Check if the .env file exists
if (-Not (Test-Path $envFilePath)) {
    Write-Host "Error: .env file not found at $envFilePath."
    return $false
}

# Load environmental variables
Get-Content $envFilePath | ForEach-Object {
    $name, $value = $_.split('=')
    if ([string]::IsNullOrWhiteSpace($name) || $name.Contains('#')) {
        continue
    }
    if (-not [string]::IsNullOrWhiteSpace($value)) {
        # Trim quotes from the value
        $value = $value.Trim().Trim('"', "'")
        Set-Content env:\$name $value
    }
}

# Check if required environmental variables are set
if (-Not $env:BROWSER_PATH -or -Not $env:LIST_OF_URLS_FILE) {
    Write-Host "Error: One or more required environmental variables are not set."
    return $false
}

# Helper function to validate paths
function Validate-Path {
    param (
        [string]$varName,
        [string]$path
    )
    if (-Not (Test-Path $path)) {
        Write-Host "Error: $varName is not valid." -ForegroundColor Red -NoNewline
        Write-Host " Path does not exist: $path."
        return $false
    }
    Write-Host "$varName" -BackgroundColor Black -ForegroundColor Yellow -NoNewline
    Write-Host " is valid. Path exists: $path."
    return $true
}

# Validate environment variable paths
function Validate-AllPaths {
    $valid = $true
    $valid = $valid -and (Validate-Path -varName "BROWSER_PATH" -path $env:BROWSER_PATH)
    $valid = $valid -and (Validate-Path -varName "LIST_OF_URLS_FILE" -path $env:LIST_OF_URLS_FILE)
    # $valid = $valid -and (Validate-Path -varName "CSV_PATH" -path $env:CSV_PATH)
    return $valid
}

# Call the function to validate all paths
if (-Not (Validate-AllPaths)) {
    return $false
}

Write-Host "Environmental variables loaded successfully and validated."
Start-Sleep -Seconds 1
return $true