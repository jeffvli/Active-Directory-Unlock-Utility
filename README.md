# Active Directory Unlock Utility
A very basic PowerShell-based AD user unlocker. A log entry will be written whenever a user is unlocked manually with this utility.
Best used in small environments, as this will blanket unlock all locked users.

## Example Usage
```
Unlock-ADUser -Server 'AD-SRV01' -LogPath 'C:\ADUnlock\log.txt'
```
