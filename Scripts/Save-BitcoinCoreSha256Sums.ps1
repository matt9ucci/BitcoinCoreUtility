param (
	[Parameter(Mandatory, HelpMessage = 'The version of Bitcoin Core (e.g. 0.17.1)')]
	[version]
	$Version
)

$param = @{
	Uri     = "https://bitcoincore.org/bin/bitcoin-core-$Version/SHA256SUMS.asc"
	OutFile = 'SHA256SUMS.asc'
	Verbose = $true
}
Invoke-WebRequest @param

Get-Content $param.OutFile
