function Invoke-SafeCommand {
    param (
        [ScriptBlock]$ScriptBlock
    )

    try {
        & $ScriptBlock
    }
    catch {
        Write-Host "Script exit : An exception occurred : $_"
        exit 1  
    }

    if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne $null) {
        Write-Host "Script exit : The command returned an error code : $LASTEXITCODE"
        exit $LASTEXITCODE
    }
}