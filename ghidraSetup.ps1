# REQUIRES ADMIN ELEVATION

if (Test-Path("$home\ghidra.zip")) {
    Write-Host 'Skipping file, already downloaded' -ForegroundColor Yellow
}
else {
    Write-Host 'Downloading and unpacking ghidra'
    # Download ghidra release
    $source = 'https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.1.2_build/ghidra_10.1.2_PUBLIC_20220125.zip'
    $destination = "$home\ghidra.zip"
    Invoke-WebRequest -Uri $source -OutFile $destination
    # Unzip ghidra release
    $output = "$home\ghidra\"
    Expand-Archive -Path $destination -DestinationPath $output
}

if (Test-Path("$home\ghidra-dark-theme.zip")) {
    Write-Host 'Skipping file, already downloaded' -ForegroundColor Yellow
}
else {
    Write-Host 'Downloading and unpacking ghidra-dark-theme'
    # Download ghidra-dark-theme
    $source = 'https://github.com/zackelia/ghidra-dark/archive/refs/heads/main.zip'
    $destination = "$home\ghidra-dark-theme.zip"
    Invoke-WebRequest -Uri $source -OutFile $destination
    # Unzip ghidra-dark-theme
    $output = "$home\ghidra-dark-theme\"
    Expand-Archive -Path $destination -DestinationPath $output
}

if($env:Path -like "*ghidra*"){
    Write-Host 'Skipping path, already added' -ForegroundColor Yellow
}
else{
    Write-Host 'Adding ghidra path to environment variables'
    # Add ghidra filepath to environment variables
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$home\ghidra\ghidra_10.1.2_PUBLIC", "User")
}

Write-Host 'Executing ghidra-dark-theme installer'
Invoke-Expression "python $home\ghidra-dark-theme\ghidra-dark-main\install.py --path $home\ghidra\ghidra_10.1.2_PUBLIC"
