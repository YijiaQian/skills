<#
.SYNOPSIS
把本仓库某个分支上的技能或工具装到本地目录。

.EXAMPLE
.\install.ps1 plain-language-zh

.EXAMPLE
.\install.ps1 plain-language-zh -Target "D:\some\skills"
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Name,

    [Parameter(Position = 1)]
    [string]$Target = (Join-Path $env:USERPROFILE ".codex\skills"),

    [string]$Remote = "https://github.com/YijiaQian/skills.git",

    [ValidateSet("skill", "tool")]
    [string]$Kind = "skill"
)

$ErrorActionPreference = "Stop"
$branch = "$Kind/$Name"
$staging = Join-Path ([System.IO.Path]::GetTempPath()) ("skills-" + [guid]::NewGuid().ToString("N").Substring(0, 8))

try {
    Write-Host "克隆 $branch ..."
    $previous = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    git clone --depth 1 --branch $branch $Remote $staging 2>&1 | Out-Null
    $code = $LASTEXITCODE
    $ErrorActionPreference = $previous
    if ($code -ne 0) { throw "克隆失败：分支 $branch 可能不存在" }

    $marker = if ($Kind -eq "skill") { "SKILL.md" } else { "README.md" }
    if (-not (Test-Path (Join-Path $staging $marker))) {
        throw "$branch 的根目录缺少 $marker，分支结构不符合约定"
    }

    New-Item -ItemType Directory -Path $Target -Force | Out-Null
    $dest = Join-Path $Target $Name
    if (Test-Path $dest) {
        $backup = "$dest.bak-" + (Get-Date -Format "yyyyMMddHHmmss")
        Move-Item -LiteralPath $dest -Destination $backup
        Write-Host "已存在同名目录，备份为 $backup"
    }

    Move-Item -LiteralPath $staging -Destination $dest
    Write-Host "已安装到 $dest"
}
finally {
    if (Test-Path $staging) { Remove-Item -LiteralPath $staging -Recurse -Force }
}
