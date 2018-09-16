$packages = @(
  "windows-sdk-10.0";
  "vscode";
  "docker-for-windows";
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
  "github-desktop";
  "sourcecodepro";
)

$WindowsFeatures = @(
    'Microsoft-Windows-Subsystem-Linux';
    'Microsoft-Hyper-V';
    'Containers';
)

# chocolateyがインストールされていなければインストール
if (-not $Env:Path.Contains("chocolatey\bin")) {
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
    $Env:Path += ";${Env:AllUsersProfile}\chocolatey\bin"
}

# chocolateyのパッケージをインストール
cinst $packages -y

# DisabledなFeatureを抽出してEnableに設定し
$EnableResults = $WindowsFeatures |
  % { Get-WindowsOptionalFeature -Online -FeatureName $_ } |
  ? { $_.State -eq 'Disabled'} |
  % { Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName $_.FeatureName -All }

# 再起動が必要であれば再起動する
if ($EnableResults.ForEach({$_.RestartNeeded}) -contains $True) {
    Write-Host "インストールが終了しました。再起動します。"
    pause

    Restart-Computer
}
