param(
    [Parameter(Mandatory = $true)]
    [string]$File,

    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[A-Fa-f0-9]{64}$')]
    [string]$ExpectedSha256
)

$resolved = Resolve-Path -LiteralPath $File -ErrorAction Stop
$actual = (Get-FileHash -LiteralPath $resolved -Algorithm SHA256).Hash.ToLowerInvariant()
$expected = $ExpectedSha256.ToLowerInvariant()

Write-Host "File:     $resolved"
Write-Host "Expected: $expected"
Write-Host "Actual:   $actual"

if ($actual -ne $expected) {
    Write-Error "SHA256 mismatch. Do not extract or run this download."
    exit 1
}

Write-Host "SHA256 verified successfully." -ForegroundColor Green

