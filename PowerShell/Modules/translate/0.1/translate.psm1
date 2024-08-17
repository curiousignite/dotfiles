function global:translate()
{
    if ($null -eq $args[0] )
    {

        $Text = Read-Host -Prompt 'Text to translate'
    } else
    {
        $Text = $args[0]
    }
    if ($null -eq $args[1] )
    {

        $TargetLanguage = Read-Host -Prompt 'Target Language'
    } else
    {
        $TargetLanguage = $args[1]
    }
    $Uri = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$($TargetLanguage)&dt=t&q=$Text"
    $Response = Invoke-RestMethod -Uri $Uri -Method Get

    $Translation = $Response[0].SyncRoot| foreach { $_[0] }
    write-host $Translation
}
Export-ModuleMember -Function translate
