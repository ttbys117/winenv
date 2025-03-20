Install-Module -Name PSWindowsUpdate -Force
Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll
Install-WindowsUpdate -AcceptAll
choco upgrade all -y --exit-when-reboot-detected
