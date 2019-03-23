function Get-Balance {
	param (
		[uint32]$MinimumConfirmation = 0
	)

	bitcoin-cli getbalance * $MinimumConfirmation
}

function Get-UnconfirmedBalance {
	bitcoin-cli getunconfirmedbalance
}
