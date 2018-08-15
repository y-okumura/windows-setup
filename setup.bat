cd %~dp0

@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
cinst -y packages.config

DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Windows-Subsystem-Linux /NoRestart
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V /NoRestart
