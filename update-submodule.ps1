# PowerShell script to set all submodules to the main branch
param (
    [string]$submodulePath = "."
)

Write-Host "Setting all submodules to the main branch at path: $submodulePath"
Set-Location $submodulePath

# Get all submodule paths
$submodules = git submodule foreach --quiet 'echo $sm_path'

foreach ($submodule in $submodules) {
    Write-Host "Updating submodule at path: $submodule"
    Set-Location $submodule
    git checkout main
    git pull origin main
    Set-Location ..
}

Write-Host "All submodules have been set to the main branch."
