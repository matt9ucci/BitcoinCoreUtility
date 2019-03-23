function Add-Block {
	param (
		[uint32]
		$Count = 1
	)

	bitcoin-cli -regtest generate $Count | ConvertFrom-Json
}

function Get-BlockHash {
	param (
		[Parameter(Mandatory)]
		[uint32]
		$Height
	)

	bitcoin-cli getblockhash $Height
}

function Get-BestBlockHash {
	bitcoin-cli getbestblockhash
}

function Get-Block {
	param (
		[Parameter(Mandatory, Position = 0, HelpMessage = 'The block hash')]
		[string]
		$Hash,

		[Parameter(ParameterSetName = 'PSCustomObject')]
		[switch]
		$WithTransaction,

		[Parameter(ParameterSetName = 'Hex', Mandatory)]
		[switch]
		$AsHex
	)

	switch ($PSCmdlet.ParameterSetName) {
		PSCustomObject {
			if ($WithTransaction) {
				bitcoin-cli getblock $Hash 2 | ConvertFrom-Json
			} else {
				bitcoin-cli getblock $Hash 1 | ConvertFrom-Json
			}
		}
		Hex {
			bitcoin-cli getblock $Hash 0
		}
	}
}

function Get-BlockHeader {
	param (
		[Parameter(Mandatory, HelpMessage = 'The block hash')]
		[string]
		$Hash,

		[switch]
		$AsHex
	)

	if ($AsHex) {
		bitcoin-cli getblockheader $Hash false
	} else {
		bitcoin-cli getblockheader $Hash true | ConvertFrom-Json
	}
}

function Get-BlockStats {
	param (
		[Parameter(Mandatory)]
		[uint32]
		$Height
	)

	bitcoin-cli getblockstats $Height | ConvertFrom-Json
}

function Get-BlockCount {
	bitcoin-cli getblockcount
}
