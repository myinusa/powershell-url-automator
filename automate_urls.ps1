$scriptPath = Get-Location

# Import the environment loader script and check the return status
$envLoaded = . "$scriptPath\env-loader.ps1"
if (-Not $envLoaded) {
    Write-Host "Failed to load and validate environment. Exiting script."
    exit
}

function Get-URLs {
    param (
        [string]$filePath
    )
    return Get-Content -Path $filePath
}

function Get-BrowserPath {
    return $env:BROWSER_PATH
}

function Open-URLInBrowser {
    param (
        [string]$url,
        [string]$browserPath
    )
    try {
        Start-Process -FilePath $browserPath -ArgumentList "--auto-open-devtools-for-tabs `"$url`"" -ErrorAction Stop
        Write-Host "Successfully opened URL: $url"
    }
    catch {
        Write-Host "Failed to open URL: $url. Error: $_"
    }
}

function Add-ToCSV {
    param (
        [string]$url
    )
    $csvPath = $env:CSV_PATH
    $data = [PSCustomObject]@{
        URL       = $url
        Processed = 1
    }
    $data | Export-Csv -Path $csvPath -NoTypeInformation -Append
}

function Main {
    # $scriptPath = Get-Location
    $csvPath = $env:CSV_PATH
    if (-Not (Test-Path $csvPath)) {
        New-Item -Path $csvPath -ItemType File
        @("URL", "Processed") -join ',' | Out-File $csvPath
    }
    $processedUrls = Import-Csv -Path $csvPath

    $urls = Get-URLs -filePath $env:LIST_OF_URLS_FILE
    $browserPath = Get-BrowserPath

    if ($urls.Count -eq 0) {
        Write-Host "No URLs found. Exiting script."
        exit
    }

    Write-Host "Total number of URLs: $($urls.Count)"
    Write-Host "Starting to open URLs..."
    Start-Sleep -Seconds 5

    $totalUrls = $urls.Count

    foreach ($url in $urls) {
        if ($processedUrls.URL -contains $url) {
            Write-Host "URL already processed: $url"
            continue
        }
        Open-URLInBrowser -url $url -browserPath $browserPath
        Add-ToCSV -url $url
        Write-Host "Sleeping for 15 seconds..."
        Start-Sleep -Seconds 15
        $totalUrls--
        Write-Host "$totalUrls URLs remaining."
    }
}

# Execute the main function
Main