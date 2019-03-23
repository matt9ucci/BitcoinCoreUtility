function Get-WalletInformation {
	bitcoin-cli getwalletinfo | ConvertFrom-Json
}

function Get-WalletName {
	bitcoin-cli listwallets | ConvertFrom-Json
}

function New-Wallet {
	param (
		[Parameter(Mandatory)]
		[string]
		$Name
	)

	bitcoin-cli createwallet $Name | ConvertFrom-Json
}
