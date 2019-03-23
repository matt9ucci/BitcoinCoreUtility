function Get-MemoryPoolInformation {
	bitcoin-cli getmempoolinfo | ConvertFrom-Json
}
