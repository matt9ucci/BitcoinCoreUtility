<#
See https://bitcoin.org/en/developer-examples#transaction-tutorial

Prerequisite: regtest mode `bitcoind -regtest`
#>

Import-Module $PSScriptRoot\..\BitcoinCoreUtility -Force

# Add-Block 101
# $address = New-Address

# bitcoin-cli -regtest sendtoaddress $address 10.00

$vin = @(
	(New-TransactionInput 7880212b54f05a5fdeb09a09594564fdbd5c459cb85eacfc20ae55938f21fe1c 0)
	(New-TransactionInput 381357e93146e1b00e4bb0cabc924273283b48c480a69b3477d80bbf31e6b145 0)
) | ConvertTo-Json -Compress

$vout = New-TransactionOutput 2Msyx8MFzPEBJFNLY3zWgBbpiDp7F65BWvr 10.9999 | ConvertTo-Json -Compress

New-RawTransaction $vin $vout
