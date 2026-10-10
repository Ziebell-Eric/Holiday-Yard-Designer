$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
if (-not (Get-Command node -ErrorAction SilentlyContinue) -or -not (Get-Command npm -ErrorAction SilentlyContinue)) {
  Write-Host 'Node.js not detected. Trying winget installation of Node.js LTS...'
  if (-not (Get-Command winget -ErrorAction SilentlyContinue)) { throw 'Install Node.js LTS from https://nodejs.org/ and rerun this script.' }
  winget install --id OpenJS.NodeJS.LTS -e --accept-package-agreements --accept-source-agreements
  $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')
  if (-not (Get-Command npm -ErrorAction SilentlyContinue)) { throw 'Node.js installed. Reopen PowerShell and run setup-windows.ps1 again.' }
}
Write-Host 'Installing project dependencies...'
npm install
if ($LASTEXITCODE -ne 0) { throw 'npm install failed' }
Write-Host 'Building Windows installer and portable EXE...'
npm run build:win
if ($LASTEXITCODE -ne 0) { throw 'Build failed' }
Write-Host 'Done. Check the dist folder.'
