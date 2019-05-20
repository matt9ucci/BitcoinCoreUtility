function Backup-DataDirectory {
	$backupName = '{0}-{1}' -f $DefaultSetting.DataDirectory, (Get-Date -Format yyMMddHHmmss)
	Rename-Item $DefaultSetting.DataDirectory $backupName
}

function New-DataDirectory {
	param (
		[string]
		$Path = $DefaultSetting.DataDirectory,

		[switch]
		$Regtest
	)

	if (Test-Path $Path) {
		Write-Warning "The data directory already exists: $Path"
		return
	}

	New-Item $Path -ItemType Directory

	if ($Regtest) {
		Copy-Item $PSScriptRoot\..\ConfigurationFiles\regtest.conf $Path\bitcoin.conf
	}
}

function Remove-RegtestDataDirectory {
	Remove-Item $DefaultSetting.Regtest.DataDirectory -Recurse -Force -Confirm
}

function Show-DataDirectory {
	param (
		[ValidateSet('mainnet', 'regtest', 'testnet')]
		[string]
		$Chain = 'regtest'
	)

	switch ($Chain) {
		mainnet { Invoke-Item $DefaultSetting.DataDirectory }
		regtest { Invoke-Item $DefaultSetting.Regtest.DataDirectory }
		testnet { Invoke-Item $DefaultSetting.Testnet.DataDirectory }
	}
}
