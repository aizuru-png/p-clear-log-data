$ErrorActionPreference = "Stop"

$songsPath = Join-Path $PSScriptRoot "songs.json"
$manifestPath = Join-Path $PSScriptRoot "manifest.json"

if (-not (Test-Path $songsPath)) {
    throw "songs.json が見つかりません。"
}

$songsText = [System.IO.File]::ReadAllText($songsPath)
$songs = $songsText | ConvertFrom-Json
$hash = (Get-FileHash -Path $songsPath -Algorithm SHA256).Hash.ToLowerInvariant()

$currentVersion = 0
if (Test-Path $manifestPath) {
    $current = [System.IO.File]::ReadAllText($manifestPath) | ConvertFrom-Json
    $currentVersion = [int]$current.dataVersion
}

$manifest = [ordered]@{
    schemaVersion = 1
    dataVersion = $currentVersion + 1
    updatedAt = (Get-Date -Format "yyyy-MM-dd")
    songCount = @($songs).Count
    songsUrl = "https://raw.githubusercontent.com/aizuru-png/p-clear-log-data/main/songs.json"
    sha256 = $hash
}

$json = $manifest | ConvertTo-Json
$utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($manifestPath, $json + [Environment]::NewLine, $utf8WithoutBom)

Write-Host "manifest.jsonを更新しました。"
Write-Host "データ版: $($manifest.dataVersion)"
Write-Host "楽曲件数: $($manifest.songCount)"
Write-Host "SHA-256: $hash"
