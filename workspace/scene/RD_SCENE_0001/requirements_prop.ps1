# 현재 스크립트가 실행되는 디렉터리를 가져옵니다.
$currentLocation = Get-Location

Write-Host "Current Location: $($currentLocation)"
Write-Host "-------------------------------------"
# 새 디렉터리의 전체 경로를 만듭니다.
$newDirectoryPath = Join-Path $currentLocation "\Content\ExternalAssets"

$requirementsPropTxtPath = Join-Path $currentLocation "\requirements_prop.txt"

# requirements_prop.txt 파일에서 폴더 경로를 읽어옵니다.
$foldersToLink = Get-Content -Path $requirementsPropTxtPath -Encoding UTF8

$prefixedPaths = @()

$prefix = "C:\rd_blog_unreal_asset_example\workspace\prop\"

$subPrefix = "\Content\ExternalAssets\"

# 각 경로에 프리픽스를 붙임
foreach ($path in $foldersToLink) {
    # 빈 줄이거나 공백만 있는 줄은 건너뛰기
    if ([string]::IsNullOrWhiteSpace($path)) {
        continue
    }
    $newPath = $prefix + $path + $subPrefix + $path
    $prefixedPaths += $newPath
    Write-Host "origin: '$path' -> new: '$newPath'"
}

foreach ($folderPath in $prefixedPaths) {

    # 폴더 이름만 추출하여 심볼릭 링크의 이름으로 사용합니다.
    $linkName = Split-Path $folderPath -Leaf
    $linkPath = Join-Path $currentLocation\Content\ExternalAssets $linkName

    Write-Host "connect folder : $($folderPath)"
    Write-Host "link name : $($linkName)"
    Write-Host "link path: $($linkPath)"


    try {
        # 새 디렉터리를 생성합니다.
        New-Item -ItemType Directory -Path $newDirectoryPath -Force | Out-Null
        Write-Host "ok: '$newDirectoryName' create folder." -ForegroundColor Green
    } catch {
        Write-Host "error: create folder $_" -ForegroundColor Red
    }

    try {
        # 심볼릭 링크를 생성합니다. (mklink /D 명령어와 동일)
        Write-Host "mklink /D $linkPath $folderPath "
        cmd /c "mklink /D $linkPath $folderPath " | Out-Null
        Write-Host "ok: '$linkName' link created" -ForegroundColor Green
    } catch {
        Write-Host "error: '$linkName' link error $_" -ForegroundColor Red
    }

    Write-Host "-------------------------------------"
}

Write-Host "complete: All links created successfully." -ForegroundColor Green
