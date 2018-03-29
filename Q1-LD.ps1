param(
        [switch]$A,
        [switch]$U,
        [switch]$H,
        [switch]$V
)

if ( $H ) {
        Write-Host
        Write-Host "Usage:  " -NoNewline
        Write-Host "./Script.ps1  [ -A | -U ]  [ -V ]" -ForegroundColor White
    Write-Host
        Exit 1
}

$used = @( )
Get-PSDrive -PSProvider FileSystem | ForEach-Object { $used += $_.Name }

$available = @( )
[int][char]"A"..[int][char]"Z" | ForEach-Object {
        [string]$d = [string][char][int]$_
        if ( -not ( $used.Contains( "$d" ) ) ) {
                $available += $d
        }
}

if ( $U -or -not $A ) {
        if ( $V -or -not ( $A -xor $U ) ) {
                Write-Host "In Use:    " -NoNewline
        }
        $used | ForEach-Object { Write-Host "${_}: " -NoNewline }
        Write-Host
}

if ( $A -or -not $U ) {
        if ( $V -or -not ( $A -xor $U ) ) {
                Write-Host "Available: " -NoNewline
        }
        $available | ForEach-Object { Write-Host "${_}: " -NoNewline }
        Write-Host
}
