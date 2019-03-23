function ConvertFrom-HexScript {
	param (
		[Parameter(ValueFromPipeline)]
		[string[]]$InputObject
	)

	foreach ($in in $InputObject) {
		bitcoin-cli decodescript $in | ConvertFrom-Json
	}
}
