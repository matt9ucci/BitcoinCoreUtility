function Get-Transaction {
	param (
		[Parameter(Mandatory, HelpMessage = 'The transaction ID')]
		[Alias('TxId')]
		[string]
		$Id,

		[switch]$AsHex
	)

	if ($AsHex) {
		bitcoin-cli getrawtransaction $Id
	} else {
		bitcoin-cli getrawtransaction $Id true | ConvertFrom-Json
	}
}

function Get-TransactionOutput {
	param (
		[Parameter(Mandatory, HelpMessage = 'The transaction ID')]
		[Alias('TxId')]
		[string]
		$OutputTransactionId,

		[Alias('Index')]
		[uint16]
		$OutputIndex = 0
	)

	bitcoin-cli gettxout $OutputTransactionId $OutputIndex | ConvertFrom-Json
}

function Get-TransactionStats {
	bitcoin-cli getchaintxstats | ConvertFrom-Json
}

function ConvertFrom-RawTransaction {
	param (
		[Parameter(Mandatory, ValueFromPipeline, HelpMessage = 'The transaction hex string')]
		[string[]]
		$InputObject
	)

	bitcoin-cli decoderawtransaction $InputObject | ConvertFrom-Json
}

function New-RawTransaction {
	param (
		[Parameter(Mandatory)]
		[string]
		$TransactionInput,

		[Parameter(Mandatory)]
		[string]
		$TransactionOutput
	)

	bitcoin-cli createrawtransaction $TransactionInput $TransactionOutput
}

function New-TransactionInput {
	param (
		[Parameter(Mandatory)]
		[Alias('TxId')]
		[string]
		$OutputTransactionId,

		[Parameter(Mandatory)]
		[Alias('Index')]
		[uint16]
		$OutputIndex
	)

	@{
		txid = $OutputTransactionId
		vout = $OutputIndex
	} | ConvertTo-Json -Compress
}

function New-TransactionOutput {
	param (
		[Parameter(Mandatory)]
		[string]
		$Address,

		[Parameter(Mandatory)]
		$Value
	)

	@{
		$Address = $Value
	} | ConvertTo-Json -Compress
}
