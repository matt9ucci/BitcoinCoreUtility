function Get-RpcCredential {
	param (
		[ValidateSet('mainnet', 'regtest', 'testnet')]
		[string]
		$Chain = 'regtest'
	)

	$cookiePath = switch ($Chain) {
		mainnet { $DefaultSetting.Cookie }
		regtest { $DefaultSetting.Regtest.Cookie }
		testnet { $DefaultSetting.Testnet.Cookie }
	}

	$cookie = (Get-Content $cookiePath) -split ':'
	$user = $cookie[0]
	$password = ConvertTo-SecureString $cookie[1] -AsPlainText -Force

	[pscredential]::new($user, $password)
}

function Invoke-Rpc {
	param (
		[Parameter(Mandatory)]
		[string]
		$Method,

		[ValidateSet('mainnet', 'regtest', 'testnet')]
		[string]
		$Chain = 'regtest'
	)

	$body = @{
		jsonrpc = '1.0'
		id = Get-Date -Format yyyyMMddHHmmssfff
		method = $Method
		params = @()
	} | ConvertTo-Json

	switch ($Chain) {
		mainnet {
			$rpcHost = $DefaultSetting.RpcHost
			$rpcPort = $DefaultSetting.RpcPort
		}
		regtest {
			$rpcHost = $DefaultSetting.Regtest.RpcHost
			$rpcPort = $DefaultSetting.Regtest.RpcPort
		 }
		testnet {
			$rpcHost = $DefaultSetting.Testnet.RpcHost
			$rpcPort = $DefaultSetting.Testnet.RpcPort
		}
	}

	$param = @{
		Uri = "http://${rpcHost}:${rpcPort}/"
		Body = $body
		ContentType = 'text/plain'
		Credential = Get-RpcCredential $Chain
		Method = 'Post'
		Authentication = 'Basic'
		AllowUnencryptedAuthentication = $true
	}

	$content = (Invoke-WebRequest @param).Content | ConvertFrom-Json
	$content.result
}