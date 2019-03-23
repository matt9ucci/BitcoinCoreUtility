function Import-PublicKey {
	param (
		[string]
		$PublicKey,

		[string]
		$Label
	)

	bitcoin-cli importpubkey $PublicKey ('"{0}"' -f $Label)
}
