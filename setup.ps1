$packages = @(
  "windows-sdk-10.0";
  "vscode";
  "docker-for-windows";
  "docker-kitematic";
  "vagrant";
  "jdk8";
  "jdk10";
  "groovy";
  "maven";
  "NetBeans";
  "atom";
  "SublimeText3";
  "SublimeText3.PackageControl";
  "GoogleChrome";
  "git";
  "github-desktop";
  "gitextensions";
  "kdiff3";
  "sourcecodepro";
  "noto";
  "fonts-ricty-diminished";
)

$WindowsFeatures = @(
    'Microsoft-Windows-Subsystem-Linux';
    'Microsoft-Hyper-V';
    'Containers';
)

# chocolateyがインストールされていなければインストール
if (-not $Env:Path.Contains("chocolatey\bin")) {
    Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
    $Env:Path += ";${Env:AllUsersProfile}\chocolatey\bin"
}

# chocolateyのパッケージをインストール
cinst $packages -y

# DisabledなFeatureを抽出してEnableに設定し
$EnableResults = $WindowsFeatures.ForEach({
    Get-WindowsOptionalFeature -Online -FeatureName $_
}).Where({
    $_.State -eq 'Disabled'
}).ForEach({
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName $_.FeatureName -All
})

# 再起動が必要であれば再起動する
if ($EnableResults.ForEach({$_.RestartNeeded}) -contains $True) {
    Write-Host "インストールが終了しました。再起動します。"
    pause

    Restart-Computer
}
