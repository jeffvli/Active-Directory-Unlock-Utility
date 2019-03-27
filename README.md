# Active-Directory-Unlock-Utility
A very basic PowerShell-based AD user unlocker. A log entry will be written whenever a user is unlocked manually with this utility. This is a proof of concept, and I do not recommend using it in a production environment.

## Example Usage
```
Unlock-ADUser -Server 'AD-SRV01' -LogPath 'C:\ADUnlock\log.txt'
```
