param(
    [Parameter(Mandatory = $true)]
    [string]$PromptText,

    [string]$Session,

    [switch]$RawPassThrough,

    [switch]$Readonly,

    [switch]$AllowEdit,

    [int]$MaxMinutes = 20
)

[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
$env:LANG = "zh_CN.UTF-8"
$env:LC_ALL = "zh_CN.UTF-8"

$ErrorActionPreference = "Stop"

$ControlRoot = "F:\Unity6_AI"
$DefaultWorkspaceRoot = $ControlRoot
$WorktreesRoot = "F:\Unity6_AI.worktrees"
$ProjectRoot = $ControlRoot
$LogRoot = Join-Path $ControlRoot "Logs\ClaudeRelay"
$SummaryScript = Join-Path $ControlRoot "tools\claude-code-summary.ps1"
$TargetConfigPath = Join-Path $ControlRoot ".openclaw\cc-target.json"
$CurrentTaskPath = Join-Path $LogRoot "current-task.json"
$SectionDone = -join ([char[]]@(0x5B8C, 0x6210, 0x5185, 0x5BB9))
$SectionIssues = -join ([char[]]@(0x53D1, 0x73B0, 0x7684, 0x95EE, 0x9898))
$SectionNext = -join ([char[]]@(0x4E0B, 0x4E00, 0x6B65, 0x5EFA, 0x8BAE))
$FinalSummaryLabel = -join ([char[]]@(
    0x0043, 0x006C, 0x0061, 0x0075, 0x0064, 0x0065, 0x0020, 0x0043,
    0x006F, 0x0064, 0x0065, 0x0020, 0x6700, 0x7EC8, 0x6458, 0x8981,
    0x003A
))
$RunningTaskMessage = -join ([char[]]@(
    0x5F53, 0x524D, 0x5DF2, 0x6709, 0x0020, 0x0043, 0x006C, 0x0061, 0x0075,
    0x0064, 0x0065, 0x0020, 0x0043, 0x006F, 0x0064, 0x0065,
    0x0020, 0x0072, 0x0065, 0x006C, 0x0061, 0x0079, 0x0020,
    0x4EFB, 0x52A1, 0x6B63, 0x5728, 0x8FD0, 0x884C, 0xFF0C,
    0x8BF7, 0x5148, 0x67E5, 0x770B, 0x0020, 0x002F, 0x0063,
    0x0063, 0x002D, 0x0073, 0x0074, 0x0061, 0x0074, 0x0075,
    0x0073, 0x3002
))
$ChangeSummaryLabel = -join ([char[]]@(0x53D8, 0x66F4, 0x6587, 0x4EF6, 0x6458, 0x8981, 0xFF1A))
$AddedLabel = -join ([char[]]@(0x65B0, 0x589E, 0x6587, 0x4EF6))
$ModifiedLabel = -join ([char[]]@(0x4FEE, 0x6539, 0x6587, 0x4EF6))
$DeletedLabel = -join ([char[]]@(0x5220, 0x9664, 0x6587, 0x4EF6))
$NoneLabel = -join ([char[]]@(0x65E0))
$DeleteWarningLabel = -join ([char[]]@(
    0x8B66, 0x544A, 0xFF1A, 0x68C0, 0x6D4B, 0x5230, 0x5220,
    0x9664, 0x6587, 0x4EF6, 0xFF0C, 0x8BF7, 0x4EBA, 0x5DE5,
    0x786E, 0x8BA4, 0x3002
))
$WorkspaceLimitMessage = -join ([char[]]@(0x5B89,0x5168,0x9650,0x5236,0xFF1A,0x0077,0x006F,0x0072,0x006B,0x0073,0x0070,0x0061,0x0063,0x0065,0x0020,0x53EA,0x5141,0x8BB8,0x4F4D,0x4E8E,0x0020,0x0046,0x003A,0x005C,0x0055,0x006E,0x0069,0x0074,0x0079,0x0036,0x005F,0x0041,0x0049,0x0020,0x6216,0x0020,0x0046,0x003A,0x005C,0x0055,0x006E,0x0069,0x0074,0x0079,0x0036,0x005F,0x0041,0x0049,0x002E,0x0077,0x006F,0x0072,0x006B,0x0074,0x0072,0x0065,0x0065,0x0073,0x0020,0x4E0B,0x3002))

function Redact-Secrets {
    param([string]$Text)

    if ($null -eq $Text) {
        return ""
    }

    $patterns = @(
        'sk-ant-[A-Za-z0-9_\-]{12,}',
        'sk-[A-Za-z0-9_\-]{12,}',
        'ANTHROPIC_AUTH_TOKEN\s*=\s*["'']?[^"''\s]+',
        'ANTHROPIC_API_KEY\s*=\s*["'']?[^"''\s]+',
        'CLAUDE_TOKEN\s*=\s*["'']?[^"''\s]+',
        'OPENAI_API_KEY\s*=\s*["'']?[^"''\s]+',
        'DEEPSEEK_API_KEY\s*=\s*["'']?[^"''\s]+',
        'FEISHU_APP_SECRET\s*=\s*["'']?[^"''\s]+',
        'appSecret"\s*:\s*"[^"]+"',
        'App Secret\s*[:=]\s*[^,\s]+'
    )

    $safe = $Text
    foreach ($pattern in $patterns) {
        $safe = [regex]::Replace($safe, $pattern, '[REDACTED_SECRET]', 'IgnoreCase')
    }
    return $safe
}

function Ensure-TargetConfig {
    $configDir = Split-Path -Parent $TargetConfigPath
    New-Item -ItemType Directory -Force -Path $configDir | Out-Null

    if (-not (Test-Path -LiteralPath $TargetConfigPath)) {
        $defaultConfig = [ordered]@{
            defaultSessionName = ""
            defaultSession = ""
            workspace = $DefaultWorkspaceRoot
            gitBranch = ""
            mode = "readonly"
            updatedAt = ""
        }
        $defaultConfig | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $TargetConfigPath -Encoding UTF8
    }
}

function Read-TargetConfig {
    Ensure-TargetConfig
    try {
        return Get-Content -LiteralPath $TargetConfigPath -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        $fallback = [pscustomobject]@{
            defaultSessionName = ""
            defaultSession = ""
            workspace = $DefaultWorkspaceRoot
            gitBranch = ""
            mode = "readonly"
            updatedAt = ""
        }
        return $fallback
    }
}

function Get-FullPathSafe {
    param([string]$Path)
    return [System.IO.Path]::GetFullPath($Path).TrimEnd('\')
}

function Test-PathInsideRoot {
    param(
        [string]$Path,
        [string]$Root
    )

    $full = Get-FullPathSafe -Path $Path
    $rootFull = Get-FullPathSafe -Path $Root
    return ($full -eq $rootFull -or $full.StartsWith($rootFull + "\", [System.StringComparison]::OrdinalIgnoreCase))
}

function Resolve-RelayWorkspace {
    param([object]$TargetConfig)

    $candidate = $DefaultWorkspaceRoot
    if ($TargetConfig -and -not [string]::IsNullOrWhiteSpace($TargetConfig.workspace)) {
        $candidate = [string]$TargetConfig.workspace
    }

    if (-not (Test-Path -LiteralPath $candidate -PathType Container)) {
        throw "Workspace not found: $candidate"
    }

    $resolved = (Resolve-Path -LiteralPath $candidate).ProviderPath
    $allowed = (Test-PathInsideRoot -Path $resolved -Root $ControlRoot) -or (Test-PathInsideRoot -Path $resolved -Root $WorktreesRoot)
    if (-not $allowed) {
        throw $WorkspaceLimitMessage
    }

    return (Get-FullPathSafe -Path $resolved)
}

function Write-CurrentTask {
    param([hashtable]$Task)

    $ordered = [ordered]@{}
    foreach ($key in $Task.Keys) {
        $ordered[$key] = $Task[$key]
    }
    $ordered | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $CurrentTaskPath -Encoding UTF8
}

function Read-CurrentTask {
    if (-not (Test-Path -LiteralPath $CurrentTaskPath)) {
        return $null
    }

    try {
        return Get-Content -LiteralPath $CurrentTaskPath -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        return $null
    }
}

function Get-GitStatusSnapshot {
    $records = @{}
    $lines = @()

    try {
        $lines = git status --short 2>$null
    } catch {
        $lines = @()
    }

    foreach ($line in $lines) {
        if ([string]::IsNullOrWhiteSpace($line) -or $line.Length -lt 4) {
            continue
        }

        $status = $line.Substring(0, 2)
        $pathText = $line.Substring(3).Trim()
        if ($pathText.Contains(" -> ")) {
            $pathText = ($pathText -split " -> ")[-1].Trim()
        }

        $fullPath = Join-Path $ProjectRoot $pathText
        $hash = ""
        if (Test-Path -LiteralPath $fullPath -PathType Leaf) {
            try {
                $hash = (Get-FileHash -LiteralPath $fullPath -Algorithm SHA256).Hash
            } catch {
                $hash = ""
            }
        }

        $records[$pathText] = [pscustomobject]@{
            path = $pathText
            status = $status
            hash = $hash
            line = $line
        }
    }

    return $records
}

function Compare-GitStatusSnapshots {
    param(
        [hashtable]$Before,
        [hashtable]$After
    )

    $added = New-Object System.Collections.Generic.List[string]
    $modified = New-Object System.Collections.Generic.List[string]
    $deleted = New-Object System.Collections.Generic.List[string]

    foreach ($path in $After.Keys) {
        $afterRecord = $After[$path]
        if ($afterRecord.status.Contains("D")) {
            if (-not $Before.ContainsKey($path) -or -not $Before[$path].status.Contains("D")) {
                $deleted.Add($path)
            }
        } elseif (-not $Before.ContainsKey($path)) {
            $added.Add($path)
        } else {
            $beforeRecord = $Before[$path]
            if ($beforeRecord.hash -ne $afterRecord.hash -or $beforeRecord.status -ne $afterRecord.status) {
                $modified.Add($path)
            }
        }
    }

    return [ordered]@{
        added = @($added)
        modified = @($modified)
        deleted = @($deleted)
    }
}

function Format-FileList {
    param([string[]]$Items)

    if (-not $Items -or $Items.Count -eq 0) {
        return $NoneLabel
    }

    return ($Items | Sort-Object | ForEach-Object { "- $_" }) -join [Environment]::NewLine
}

function Format-ChangeSummary {
    param([hashtable]$ChangedFiles)

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("")
    $lines.Add($ChangeSummaryLabel)
    $lines.Add("${AddedLabel}:")
    $lines.Add((Format-FileList -Items $ChangedFiles["added"]))
    $lines.Add("${ModifiedLabel}:")
    $lines.Add((Format-FileList -Items $ChangedFiles["modified"]))
    $lines.Add("${DeletedLabel}:")
    $lines.Add((Format-FileList -Items $ChangedFiles["deleted"]))
    if ($ChangedFiles["deleted"] -and $ChangedFiles["deleted"].Count -gt 0) {
        $lines.Add($DeleteWarningLabel)
    }
    return ($lines -join [Environment]::NewLine)
}

if ([string]::IsNullOrWhiteSpace($PromptText)) {
    Write-Error "PromptText cannot be empty."
    exit 2
}

if ($AllowEdit -and $Readonly) {
    Write-Error "AllowEdit and Readonly cannot be used together."
    exit 2
}

if ($AllowEdit -and $RawPassThrough) {
    Write-Error "RawPassThrough is only allowed in readonly mode."
    exit 2
}

if ($MaxMinutes -lt 1) {
    Write-Error "MaxMinutes must be at least 1."
    exit 2
}

if (-not (Test-Path -LiteralPath $ControlRoot)) {
    Write-Error "Project root not found: $ControlRoot"
    exit 3
}

New-Item -ItemType Directory -Force -Path $LogRoot | Out-Null
Set-Location -LiteralPath $ControlRoot
Ensure-TargetConfig

$ExistingTask = Read-CurrentTask
if ($ExistingTask -and $ExistingTask.status -eq "running") {
    Write-Output $RunningTaskMessage
    exit 4
}

$RunId = Get-Date -Format "yyyyMMdd-HHmmss-fff"
$PromptPath = Join-Path $LogRoot "$RunId-prompt.txt"
$OutputPath = Join-Path $LogRoot "$RunId-output.txt"
$MetaPath = Join-Path $LogRoot "$RunId-meta.json"
$SummaryPath = Join-Path $LogRoot "$RunId-summary.txt"
$TargetConfig = Read-TargetConfig
$ProjectRoot = Resolve-RelayWorkspace -TargetConfig $TargetConfig
$EffectiveSessionName = if ($TargetConfig -and -not [string]::IsNullOrWhiteSpace($TargetConfig.defaultSessionName)) {
    [string]$TargetConfig.defaultSessionName
} else {
    ""
}
$EffectiveGitBranch = if ($TargetConfig -and -not [string]::IsNullOrWhiteSpace($TargetConfig.gitBranch)) {
    [string]$TargetConfig.gitBranch
} else {
    ""
}
$EffectiveSession = if (-not [string]::IsNullOrWhiteSpace($Session)) {
    $Session
} elseif ($TargetConfig -and -not [string]::IsNullOrWhiteSpace($TargetConfig.defaultSession)) {
    [string]$TargetConfig.defaultSession
} else {
    ""
}
$IsReadonly = -not $AllowEdit
$ModeName = if ($IsReadonly) { "readonly" } else { "allow-edit" }
Set-Location -LiteralPath $ProjectRoot

Set-Content -LiteralPath $PromptPath -Value $PromptText -Encoding UTF8

$WrappedTask = if ($AllowEdit) {
@"
You are executing a remote Feishu task inside $ProjectRoot.

User original task:
<USER_PROMPT>
$PromptText
</USER_PROMPT>

Work mode: editing project files is allowed, but only within strict safety boundaries.

Allowed:
- Modify normal source files, documentation, and configuration files inside $ProjectRoot.
- Run read-only inspection commands.
- Run necessary local test commands when they are safe.
- Modify Unity project files when directly relevant to the task.
- Update PROGRESS.md, TODO.md, and AI_DEV_LOG.md.
- Generate or modify files under Logs/ClaudeRelay.

Forbidden:
- Do not run git push.
- Do not delete the project directory.
- Do not run Remove-Item -Recurse, del /s, rmdir /s, rm -rf, or equivalent recursive delete commands.
- Do not modify, output, save, or expose any API Key, Token, App Secret, password, or credential.
- Do not modify OpenClaw, Claude Code, or DeepSeek secret configuration.
- Do not write secrets into README, blog posts, logs, Git, or documentation.
- Do not install unknown global tools.
- Do not change Windows system-level settings.
- Do not modify sensitive files under the user home directory unless the user explicitly requests it.
- Do not create git commits unless the user explicitly says commit is allowed.
- Do not run git push, even if the user asks; refuse and explain why.

Execution requirements:
1. Read the project status first.
2. Make a short plan.
3. Only change files directly related to the user's task.
4. After editing, list the files changed.
5. Run safe tests if possible; if not possible, explain why.
6. End with these sections:
   - Completed work
   - Modified files
   - Verification result
   - Remaining issues
   - Next steps
"@
} elseif ($RawPassThrough) {
    $PromptText
} else {
@"
User original instruction:
$PromptText

Current working directory:
$ProjectRoot

Mode and safety rules:
- Read-only mode.
- Do not modify, create, move, rename, or delete files.
- Do not commit code.
- Do not run git push.
- Only inspect files, check Git status/log, and run .\tools\mobile-status.ps1 if useful.
- Do not output DeepSeek keys, Feishu App Secret, Claude tokens, API keys, or other secrets. Redact any secret-looking value as [REDACTED_SECRET].
- Keep the answer concise and suitable for relay back to Feishu.

At the end, output these sections:
1. $SectionDone
2. $SectionIssues
3. $SectionNext
"@
}

$AllowedTools = if ($IsReadonly) {
    if ($RawPassThrough) {
        "Read,Glob,Grep,Bash(git status:*),Bash(git log:*)"
    } else {
        "Read,Glob,Grep,Bash(git status:*),Bash(git log:*),Bash(powershell -ExecutionPolicy Bypass -File .\tools\mobile-status.ps1:*)"
    }
} else {
    "Read,Glob,Grep,Edit,MultiEdit,Write,Bash(git status:*),Bash(git diff:*),Bash(git log:*),Bash(powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\*:*)"
}
$DisallowedTools = if ($AllowEdit) {
    "Bash(git push:*),Bash(Remove-Item:*),Bash(del:*),Bash(rmdir:*),Bash(rm:*),Bash(cmd /c del:*),Bash(cmd /c rmdir:*)"
} else {
    ""
}
$StartedAt = Get-Date
$ExitCode = 0
$RawOutput = ""
$GitStatusBefore = Get-GitStatusSnapshot
$TaskBase = @{
    status = "running"
    mode = $ModeName
    runId = $RunId
    sessionName = $EffectiveSessionName
    session = $EffectiveSession
    workspace = $ProjectRoot
    gitBranch = $EffectiveGitBranch
    prompt = (Redact-Secrets -Text $PromptText)
    startedAt = $StartedAt.ToString("o")
    outputLog = $OutputPath
    summaryLog = ""
}
Write-CurrentTask -Task $TaskBase

try {
    $ClaudeCommand = Get-Command "claude" -ErrorAction Stop
    if ([string]::IsNullOrWhiteSpace($EffectiveSession)) {
        $ClaudeArgs = @(
            "-p",
            $WrappedTask,
            "--output-format",
            "text",
            "--allowedTools",
            $AllowedTools
        )
    } else {
        $ClaudeArgs = @(
            "-p",
            "--resume",
            $EffectiveSession,
            $WrappedTask,
            "--output-format",
            "text",
            "--allowedTools",
            $AllowedTools
        )
    }
    if (-not [string]::IsNullOrWhiteSpace($DisallowedTools)) {
        $ClaudeArgs += @("--disallowedTools", $DisallowedTools)
    }

    $TimeoutSeconds = $MaxMinutes * 60
    $ClaudeJob = Start-Job -ScriptBlock {
        param(
            [string]$CommandPath,
            [string[]]$CommandArgs,
            [string]$WorkingDirectory
        )

        [Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
        [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
        $OutputEncoding = [System.Text.UTF8Encoding]::new()
        $env:LANG = "zh_CN.UTF-8"
        $env:LC_ALL = "zh_CN.UTF-8"
        Set-Location -LiteralPath $WorkingDirectory

        $jobOutput = & $CommandPath @CommandArgs 2>&1
        $jobExitCode = $LASTEXITCODE
        if ($null -eq $jobExitCode) {
            $jobExitCode = 0
        }

        [pscustomobject]@{
            exitCode = $jobExitCode
            output = (($jobOutput | ForEach-Object { $_.ToString() }) -join [Environment]::NewLine)
        }
    } -ArgumentList $ClaudeCommand.Source, $ClaudeArgs, $ProjectRoot

    $CompletedJob = Wait-Job -Job $ClaudeJob -Timeout $TimeoutSeconds
    if ($CompletedJob) {
        $JobResult = Receive-Job -Job $ClaudeJob
        $ExitCode = [int]$JobResult.exitCode
        $RawOutput = [string]$JobResult.output
    } else {
        Stop-Job -Job $ClaudeJob | Out-Null
        $ExitCode = 124
        $RawOutput = "Claude Code invocation timed out after $MaxMinutes minute(s)."
    }
    Remove-Job -Job $ClaudeJob -Force | Out-Null
} catch {
    $ExitCode = 127
    $RawOutput = "Claude Code invocation failed: $($_.Exception.Message)"
}

$GitStatusAfter = Get-GitStatusSnapshot
$ChangedFiles = Compare-GitStatusSnapshots -Before $GitStatusBefore -After $GitStatusAfter

$SafeOutput = Redact-Secrets -Text $RawOutput
Set-Content -LiteralPath $OutputPath -Value $SafeOutput -Encoding UTF8

$EndedAt = Get-Date
$Meta = [ordered]@{
    runId = $RunId
    projectRoot = $ProjectRoot
    controlRoot = $ControlRoot
    promptPath = $PromptPath
    outputPath = $OutputPath
    summaryPath = $SummaryPath
    startedAt = $StartedAt.ToString("o")
    endedAt = $EndedAt.ToString("o")
    exitCode = $ExitCode
    mode = $ModeName
    requestedSession = $Session
    sessionName = $EffectiveSessionName
    session = $EffectiveSession
    workspace = $ProjectRoot
    gitBranch = $EffectiveGitBranch
    rawPassThrough = [bool]$RawPassThrough
    allowedTools = $AllowedTools
    disallowedTools = $DisallowedTools
    maxMinutes = $MaxMinutes
    changedFiles = $ChangedFiles
}
$Meta | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $MetaPath -Encoding UTF8

if (Test-Path -LiteralPath $SummaryScript) {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $SummaryScript -OutputPath $OutputPath -MetaPath $MetaPath -SummaryPath $SummaryPath | Out-Null
} else {
    Set-Content -LiteralPath $SummaryPath -Value "Claude Code summary script not found: $SummaryScript" -Encoding UTF8
}

$FinalSummary = Get-Content -LiteralPath $SummaryPath -Raw -Encoding UTF8
if ($AllowEdit) {
    $ChangeSummary = Format-ChangeSummary -ChangedFiles $ChangedFiles
    $FinalSummary = ($FinalSummary.Trim() + [Environment]::NewLine + $ChangeSummary).Trim()
    Set-Content -LiteralPath $SummaryPath -Value $FinalSummary -Encoding UTF8
}

$TaskCompleted = @{
    status = if ($ExitCode -eq 0) { "completed" } else { "failed" }
    mode = $ModeName
    runId = $RunId
    sessionName = $EffectiveSessionName
    session = $EffectiveSession
    workspace = $ProjectRoot
    gitBranch = $EffectiveGitBranch
    prompt = (Redact-Secrets -Text $PromptText)
    startedAt = $StartedAt.ToString("o")
    outputLog = $OutputPath
    summaryLog = $SummaryPath
    exitCode = $ExitCode
    completedAt = $EndedAt.ToString("o")
    changedFiles = $ChangedFiles
}
if ($ExitCode -ne 0) {
    $ErrorText = if ([string]::IsNullOrWhiteSpace($SafeOutput)) { "Claude Code failed." } else { $SafeOutput.Trim() }
    $TaskCompleted["error"] = (Redact-Secrets -Text $ErrorText)
}
Write-CurrentTask -Task $TaskCompleted

Write-Output "Claude Code Relay Run: $RunId"
Write-Output "Prompt Log: $PromptPath"
Write-Output "Output Log: $OutputPath"
Write-Output "Meta Log: $MetaPath"
Write-Output "Summary Log: $SummaryPath"
Write-Output ""
Write-Output $FinalSummaryLabel
Write-Output $FinalSummary

exit $ExitCode
