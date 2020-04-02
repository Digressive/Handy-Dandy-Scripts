$HomeFolder = "F:\foo"

$flds = Get-ChildItem $HomeFolder -dir

ForEach ($fld in $flds)
{
    $fldfixed = [regex]::escape($fld)
    $Files = Get-ChildItem -Path $HomeFolder\$fld\*.* -Recurse | Where-Object {$_.Name -notmatch "($fldfixed)-\d{4}.[A-Z]"}
    Write-Host "Current folder: $fld"

    ForEach ($File in $Files)
    {
        $i = 1
        $NewNameBe = ("$fld-{0:D4}" -f $i++ + $File.Extension)
        $TP = Test-Path -Path $HomeFolder\$fld\$NewNameBe

        If ($TP)
        {
            do {
                $NewNameBe = ("$fld-{0:D4}" -f $i++ + $File.Extension)
                $TP = Test-Path -Path $HomeFolder\$fld\$NewNameBe

            } until ($TP -eq $false)
            
            $FMove = Split-Path $File

            If ("$HomeFolder\$fld" -ne $FMove)
            {
                Move-Item -Path $File -Destination $HomeFolder\$fld\$NewNameBe
            }
            else {
                Rename-Item -Path $File -NewName $NewNameBe
            }

        }
        else {
            
            $FMove = Split-Path $File

            If ("$HomeFolder\$fld" -ne $FMove)
            {
                Move-Item -Path $File -Destination $HomeFolder\$fld\$NewNameBe
            }
            else {
                Rename-Item -Path $File -NewName $NewNameBe
            }
        }
    }
}
