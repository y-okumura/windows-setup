@powershell -NoProfile -ExecutionPolicy RemoteSigned "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof

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
  "git";
  "github-desktop";
  "gitextensions";
  "sourcecodepro";
  "noto";
  "fonts-ricty-diminished";
)

$WindowsFeatures = @(
    'Microsoft-Windows-Subsystem-Linux';
    'Microsoft-Hyper-V';
    'Containers';
)

# chocolatey���C���X�g�[������Ă��Ȃ���΃C���X�g�[��
if (-not $Env:Path.Contains("chocolatey\bin")) {
    Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
    $Env:Path += ";${Env:AllUsersProfile}\chocolatey\bin"
}

# chocolatey�̃p�b�P�[�W���C���X�g�[��
cinst $packages -y

# Disabled��Feature�𒊏o����Enable�ɐݒ肵
$EnableResults = $WindowsFeatures.ForEach({
    Get-WindowsOptionalFeature -Online -FeatureName $_
}).Where({
    $_.State -eq 'Disabled'
}).ForEach({
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName $_.FeatureName -All
})

# �ċN�����K�v�ł���΍ċN������
if ($EnableResults.ForEach({$_.RestartNeeded}) -contains $True) {
    Write-Host "�C���X�g�[�����I�����܂����B�ċN�����܂��B"
    pause

    Restart-Computer
} else {
    Write-Host "�C���X�g�[�����I�����܂����B"
    pause
}
