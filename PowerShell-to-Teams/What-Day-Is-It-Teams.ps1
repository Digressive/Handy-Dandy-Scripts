$TDay = (Get-Date).DayOfWeek

$uri = "https://outlook.office.com/webhook/put-your-webhook-here"

$ResultArr = @()

$ResultArr += New-Object PSObject -Property @{
    facts = @(
    @{
        name = 'Today is:'
        value = "$TDay"
    })
}

If ($Null -ne $ResultArr)
{
    $Body = ConvertTo-Json -Depth 8 @{
    text  = " "
    sections = $ResultArr
    title = "What day of the week is it?"
    }

    Invoke-RestMethod -Uri $Uri -Method Post -body $Body -ContentType 'application/json'
}
