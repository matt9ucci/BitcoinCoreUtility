[scriptblock]$BinaryVersion = & {
	$cache = $null
	{
		param ([switch]$Force)

		if (!$cache -or $Force) {
			$response = Invoke-WebRequest https://bitcoincore.org/bin/
			$script:cache = ($response).Links.href -like 'bitcoin-core-*/' -replace 'bitcoin-core-(.*)/', '$1'
		}
		$cache
	}.GetNewClosure()
}

function Get-BitcoinCoreBinaryVersion {
	param (
		[switch]
		$Force,
		[switch]
		$Lts,
		[switch]
		$Security,
		[switch]
		$Latest
	)

	$result = & $BinaryVersion -Force:$Force
	if ($Latest) {
		$result | Sort-Object { [version]$_ } -Bottom 1
	} else {
		$result | Sort-Object { [version]$_ }
	}
}
