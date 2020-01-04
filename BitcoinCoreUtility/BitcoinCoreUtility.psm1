$DefaultSetting = @{}
$DefaultSetting.DataDirectory = Join-Path $env:APPDATA Bitcoin
$DefaultSetting.Cookie = Join-Path $DefaultSetting.DataDirectory .cookie
$DefaultSetting.RpcHost = '127.0.0.1'
$DefaultSetting.RpcPort = 8332

$DefaultSetting.Testnet = @{}
$DefaultSetting.Testnet.DataDirectory = Join-Path $DefaultSetting.DataDirectory testnet3
$DefaultSetting.Testnet.Cookie = Join-Path $DefaultSetting.Testnet.DataDirectory .cookie
$DefaultSetting.Testnet.RpcHost = '127.0.0.1'
$DefaultSetting.Testnet.RpcPort = 18332

$DefaultSetting.Regtest = @{}
$DefaultSetting.Regtest.DataDirectory = Join-Path $DefaultSetting.DataDirectory regtest
$DefaultSetting.Regtest.Cookie = Join-Path $DefaultSetting.Regtest.DataDirectory .cookie
$DefaultSetting.Regtest.RpcHost = '127.0.0.1'
$DefaultSetting.Regtest.RpcPort = 18443

. $PSScriptRoot\Address.ps1
. $PSScriptRoot\Balance.ps1
. $PSScriptRoot\Binary.ps1
. $PSScriptRoot\Block.ps1
. $PSScriptRoot\DataDirectory.ps1
. $PSScriptRoot\MemoryPool.ps1
. $PSScriptRoot\Network.ps1
. $PSScriptRoot\Node.ps1
. $PSScriptRoot\PublicKey.ps1
. $PSScriptRoot\Rpc.ps1
. $PSScriptRoot\Script.ps1
. $PSScriptRoot\Transaction.ps1
. $PSScriptRoot\Utxo.ps1
. $PSScriptRoot\Wallet.ps1
