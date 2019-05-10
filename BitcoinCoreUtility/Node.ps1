function Get-NodeUptime {
	# bitcoin-cli uptime
	Invoke-Rpc -Method uptime
}

function Start-Node {
	param (
		[ValidateSet('mainnet', 'regtest', 'testnet')]
		[string]
		$Chain = 'regtest',

		[ValidateSet('addrman', 'bench', 'cmpctblock', 'coindb', 'db', 'estimatefee', 'http', 'leveldb', 'libevent', 'mempool', 'mempoolrej', 'net', 'proxy', 'prune', 'qt', 'rand', 'reindex', 'rpc', 'selectcoins', 'tor', 'zmq')]
		[string[]]
		$DebugCategory
	)

	$options = New-Object System.Collections.ArrayList

	if ($Chain -ne 'mainnet') {
		$options.Add("-$Chain") > $null
	}

	foreach ($c in $DebugCategory) {
		$options.Add("-debug=$c")
	}

	$command = "bitcoind $($options -join ' ')"
	Write-Information ("Starting bitcoind: {0}" -f $command)
	Invoke-Expression $command
}

function Stop-Node {
	bitcoin-cli stop
}
