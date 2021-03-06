function Unlock-ADUser {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Server,
        [Parameter(Mandatory=$false, Position=1)]
        [string]$LogPath
    )
    
    begin {
        $TimeStamp = Get-Date -Format "MM/dd/yyyy - HH:mm:ss"
        $Credentials = Get-Credential -Message 'Enter AD admin credentials (User@Domain.com or Domain\Username)'
        if ($LogPath) {
            if (!(Test-Path $LogPath)) {
                New-Item -Path $LogPath -ItemType "File"
            }
        }
    }
    
    process {
        try {
            $LockedUserSearch = Search-ADAccount `
            -LockedOut `
            -Credential $Credentials `
            -Server $Server `
            | Select-Object SamAccountName, LockedOut, DistinguishedName -ErrorAction Stop
        }

        catch {
            if ($Credentials -eq $null -or $Credentials -eq '') {
                break
            }
            else {
                Write-Warning 'Please re-enter valid credentials.'
                Unlock-ADUser
            }
        }

        Write-Output "($TimeStamp) AD unlock utility has been started"

        while ($true) {
            $TimeStamp = Get-Date -Format "MM/dd/yyyy - HH:mm:ss"
            if ($LockedUserSearch -eq $null -or $LockedUserSearch -eq "") {
                if ($LogPath) {
                    Write-Output "($TimeStamp) No users are locked." | Tee-Object -FilePath $LogPath -Append
                }
                pause
            }

            else {
                $LockedUserSelection = @($LockedUserSearch.SamAccountName)
                foreach ($User in $LockedUserSelection) {
                    Unlock-ADAccount -Identity $User -Credential $Credentials -Server $ADServer
                    if ($LogPath) {
                        Write-Output "($TimeStamp) $User has been unlocked." | Tee-Object -FilePath $LogPath -Append
                    }
                    pause
                }
            }
        }
    }
}
