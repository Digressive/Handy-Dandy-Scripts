$PCList = "PC1,PC2"
$PCs = $PCList.split(",")

ForEach ($PC in $PCs)
{	
	$UsrList = Get-ChildItem "\\$PC\C$\Users" -Name -Directory -Exclude 'Administrator','Public','sysadmin'

    ForEach ($User in $UsrList)
    {
		$UsrExist = Get-ADUser -Filter 'Name -like "$User"'

        If ($UsrExist -eq $null)
        {
            Write-host "User:$User not found in AD"
			Get-CimInstance -ComputerName "$PC" -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -eq $User } | Remove-CimInstance
        }
		
		else{
			Write-host "Goodbye"
		}
		
    }
}