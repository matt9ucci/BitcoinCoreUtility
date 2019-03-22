param (
	[Parameter(Mandatory, HelpMessage = 'The version of Bitcoin Core (e.g. 0.17.1)')]
	[version]
	$Version,

	[ValidateSet('aarch64-linux-gnu', 'arm-linux-gnueabihf', 'i686-pc-linux-gnu', 'osx64', 'win32', 'win64', 'x86_64-linux-gnu')]
	[string]
	$Os = 'win64'
)

$fileName = "bitcoin-$Version-{0}" -f $(
	switch ($Os) {
		aarch64-linux-gnu { 'aarch64-linux-gnu.tar.gz' }
		arm-linux-gnueabihf { 'arm-linux-gnueabihf.tar.gz' }
		i686-pc-linux-gnu { 'i686-pc-linux-gnu.tar.gz' }
		osx64 { 'osx64.tar.gz' }
		win32 { 'win32.zip' }
		win64 { 'win64.zip' }
		x86_64-linux-gnu { 'x86_64-linux-gnu.tar.gz' }
	}
)

$param = @{
	Uri     = "https://bitcoincore.org/bin/bitcoin-core-$Version/$fileName"
	OutFile = $fileName
	Verbose = $true
}
Invoke-WebRequest @param

Get-FileHash $param.OutFile -Algorithm SHA256
