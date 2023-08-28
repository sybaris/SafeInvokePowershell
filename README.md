# SafeInvokePowershell

## Installation

```powershell
Install-Module SafeInvokePowershell
```

## Usage

```powershell
Invoke-SafeCommand -ScriptBlock {    Write-Host "ok" }

Invoke-SafeCommand -ScriptBlock {     }
  {
    cmd /c "exit 0"
    throw "MyError" #This line is the last line that will be executed of this block
    cmd /c "exit 0"

  }

Invoke-SafeCommand -ScriptBlock
  {
    cmd /c "exit 0"
    cmd /c "exit 5" #This line is the last line that will be executed of this block
    cmd /c "exit 0"

  }
```

The goal is when an error occurs, the scripts ends with exitcode not null and no 0