[scriptblock]$BinaryVersion = & {
	$cache = $null
	{
		param ([switch]$Force)

		if (!$cache -or $Force) {
			$response = Invoke-WebRequest https://bitcoincore.org/bin/
			$script:cache = ($response).Links.href -like 'bitcoin-core-*/' -replace 'bitcoin-core-(.*)/', '$1'
		}
		$cache
	}.GetNewClosure()
}

function Get-BitcoinCoreBinaryVersion {
	param (
		[switch]
		$Force,
		[switch]
		$Lts,
		[switch]
		$Security,
		[switch]
		$Latest
	)

	$result = & $BinaryVersion -Force:$Force
	if ($Latest) {
		$result | Sort-Object { [version]$_ } -Bottom 1
	} else {
		$result | Sort-Object { [version]$_ }
	}
}

function Expand-BitcoinCoreBinary {
	param (
		[Parameter(Mandatory)]
		[string]
		$Path,

		[string]
		$DestinationPath = '.',

		[string]
		$Version
	)

	if (!$Version) {
		$Version = ((Split-Path $Path -Leaf) -split '-')[1]
	}

	$expanded = Expand-Archive -Path $Path -DestinationPath $DestinationPath -PassThru
	$expandedRoot =  ($expanded | ? FullName -Like '*bin').Parent
	Rename-Item -Path $expandedRoot.FullName -NewName $Version -Verbose
}

function Save-BitcoinCoreBinary {
	param (
		[Parameter(HelpMessage = 'The version of Bitcoin Core (e.g. 0.17.1)')]
		[version]
		$Version,

		[ValidateSet('aarch64-linux-gnu', 'arm-linux-gnueabihf', 'i686-pc-linux-gnu', 'osx64', 'win32', 'win64', 'x86_64-linux-gnu')]
		[string]
		$Os = 'win64'
	)

	if (!$Version) {
		$tagName = (Invoke-RestMethod 'https://api.github.com/repos/bitcoin/bitcoin/releases/latest').tag_name
		if ($tagName -match '(\d{1,2}\.\d{1,2}\.\d{1,2})') {
			$Version = $Matches[0]
		} else {
			throw "Unknown tag_name=$tagName"
		}
	}

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

	Get-FileHash $param.OutFile -Algorithm SHA256 | Format-List *
}

Register-ArgumentCompleter -ParameterName Version -CommandName Save-BitcoinCoreBinary -ScriptBlock {
	param ($commandName, $parameterName, $wordToComplete)
	(& $BinaryVersion) -like "$wordToComplete*"
}
