function Get-NetworkInformation {
	bitcoin-cli getnetworkinfo | ConvertFrom-Json
}