## Important!
## This script assumes that the permissions for the Homes Root are all in order!
## Thanks

## Vars to set
$HomesRoot = "X:\User-Homes"

## Get the users home dir and assume the name is also the sam account name of the account that owns it
$UsersH = Get-ChildItem -Path $HomesRoot -Directory

## For each user home take ownership and set permissions
ForEach ($UserH in $UsersH)
{
    ## Getting just the name
    $Usern = $UserH.name

    ## Take Ownership of the files so you can set perms
    takeown.exe /f $UserH.FullName /R /D Y /SKIPSL

    ## Setting perms
    icacls.exe $UserH.FullName /inheritance:e #                   Enabling inheritance of permissions from the Homes Root
    icacls.exe $UserH.FullName /reset #                           Reset the folders permisions from the Homes Root
    icacls.exe $UserH.FullName /grant:r $Usern':(OI)(CI)(F)' #    Grant the user full access to their folder
}

## End