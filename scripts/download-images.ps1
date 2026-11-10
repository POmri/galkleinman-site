# Downloads every image from the current WordPress site into .\images
# Run this BEFORE you shut down your WordPress hosting.
#
#   Windows:  powershell -ExecutionPolicy Bypass -File scripts\download-images.ps1
#
# Safe to run more than once: files that already exist are skipped.
Set-Location (Join-Path $PSScriptRoot "..")
$ProgressPreference = "SilentlyContinue"
$ok = 0
$failed = 0

foreach ($line in Get-Content "scripts\images.txt") {
  $line = $line.Trim()
  if ($line -eq "" -or $line.StartsWith("#")) { continue }
  $parts = $line -split "\s+"
  $path = $parts[0]
  $url = $parts[1]

  if ((Test-Path $path) -and ((Get-Item $path).Length -gt 0)) { $ok++; continue }
  New-Item -ItemType Directory -Force -Path (Split-Path $path) | Out-Null

  try {
    Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing
    Write-Host "OK    $path"
    $ok++
  } catch {
    Write-Host "FAIL  $url"
    if (Test-Path $path) { Remove-Item $path }
    $failed++
  }
}

Write-Host ""
Write-Host "Done: $ok images in place, $failed failed."
if ($failed -gt 0) { Write-Host "Run the script again to retry the failed ones." }
