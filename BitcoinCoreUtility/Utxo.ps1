function Get-Utxo {
	param (
		[alias('MinConfirm')]
		[uint32]
		$MinimumConfirmation = 1,

		[alias('MaxConfirm')]
		[uint32]
		$MaximumConfirmation = 9999999
	)

	bitcoin-cli listunspent $MinimumConfirmation $MaximumConfirmation | ConvertFrom-Json
}
