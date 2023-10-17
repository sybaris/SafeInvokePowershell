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

function Invoke-CommandWithTimeout {
    param (
        [scriptblock]$ScriptBlock,
        [int]$TimeoutSeconds
    )

    # Start the job
    Start-Job -ScriptBlock $ScriptBlock

    # Wait until the job is done or the timeout is reached
    $job = Get-Job | Wait-Job -Timeout $TimeoutSeconds

    # Check if the job has finished
    if ($job.JobStateInfo.State -eq "Completed") {
        # The job has finished
        Receive-Job $job
    } else {
        # The timeout has been reached, you can kill it if needed
        Stop-Job $job
        throw "The job has timed out"
    }
}