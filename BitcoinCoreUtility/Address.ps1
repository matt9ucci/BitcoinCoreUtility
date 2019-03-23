function Get-Address {
	param (
		[string]
		$Label
	)

	if ($PSBoundParameters.ContainsKey('Label')) {
		(bitcoin-cli getaddressesbylabel ('"{0}"' -f $Label) | ConvertFrom-Json).psobject.Properties.Name
	} else {
		(bitcoin-cli listreceivedbyaddress 0 true | ConvertFrom-Json) | ForEach-Object address
	}
}

function Get-AddressLabel {
	param (
		[ValidateSet('receive', 'send')]
		[string]
		$Purpose
	)

	if ($PSBoundParameters.ContainsKey('Purpose')) {
		bitcoin-cli listlabels $Purpose | ConvertFrom-Json
	} else {
		bitcoin-cli listlabels | ConvertFrom-Json
	}
}

function Get-AddressInformation {
	param (
		[Parameter(Mandatory)]
		[string]
		$Address
	)

	bitcoin-cli getaddressinfo $Address | ConvertFrom-Json
}

function New-Address {
	param (
		[string]
		$Label,

		[ValidateSet('bech32', 'legacy', 'p2sh-segwit')]
		[string]
		$AddressType
	)

	bitcoin-cli getnewaddress ('"{0}"' -f $Label) $AddressType
}

function Test-Address {
	param (
		[Parameter(Mandatory)]
		[string]
		$Address
	)

	bitcoin-cli validateaddress $Address | ConvertFrom-Json
}