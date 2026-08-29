# LibreWolf — apply chrome + user.js to Profiles/main
$ErrorActionPreference = "Stop"
$repo = $PSScriptRoot
$ini = "$env:APPDATA\LibreWolf\profiles.ini"
if (-not (Test-Path $ini)) { Write-Error "profiles.ini not found at $ini"; exit 1 }
$profilePath = (Select-String -Path $ini -Pattern "^Path=Profiles/main" | Select-Object -First 1).Line.Split("=",2)[1]
$dest = Join-Path $env:APPDATA "LibreWolf\$profilePath"
if (-not (Test-Path $dest)) { $dest = "$env:APPDATA\LibreWolf\Profiles\main" }
Write-Host "→ $dest" -ForegroundColor Cyan
New-Item -ItemType Directory -Path "$dest\chrome" -Force | Out-Null
# backup
$stamp = Get-Date -Format yyyyMMdd-HHmmss
if (Test-Path "$dest\user.js") { Copy-Item "$dest\user.js" "$dest\user.js.bak-$stamp" -Force; Write-Host "  backup user.js.bak-$stamp" -ForegroundColor Gray }
if (Test-Path "$dest\chrome\userChrome.css") { Copy-Item "$dest\chrome\userChrome.css" "$dest\chrome\userChrome.css.bak-$stamp" -Force }
if (Test-Path "$dest\chrome\userContent.css") { Copy-Item "$dest\chrome\userContent.css" "$dest\chrome\userContent.css.bak-$stamp" -Force }
Copy-Item "$repo\chrome\userChrome.css" "$dest\chrome\userChrome.css" -Force
Copy-Item "$repo\chrome\userContent.css" "$dest\chrome\userContent.css" -Force
Copy-Item "$repo\user.js" "$dest\user.js" -Force
Write-Host "  applied user.js + chrome/*.css" -ForegroundColor Green
Write-Host "Restart LibreWolf to load." -ForegroundColor Yellow
