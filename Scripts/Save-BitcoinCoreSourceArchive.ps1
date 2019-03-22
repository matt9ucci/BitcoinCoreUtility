[CmdletBinding(DefaultParameterSetName = 'GitHub')]
param (
	[Parameter(ParameterSetName = 'GitHub', Mandatory, HelpMessage = 'The version of Bitcoin Core (e.g. 0.17.1)')]
	[version]
	$Version,

	[Parameter(ParameterSetName = 'GitHub')]
	[ValidateSet('zip', 'tar.gz')]
	[string]
	$Extension = 'zip',

	[Parameter(ParameterSetName = 'SatoshiNakamotoInstitute', Mandatory, HelpMessage = "The Satoshi Nakamoto Institute's archive")]
	[ValidateSet('nov08.tgz', '0.1.0.rar', '0.1.0.tgz', '0.1.3.rar')]
	[string]
	$SatoshiNakamotoInstitute
)

switch ($PSCmdlet.ParameterSetName) {
	GitHub {
		# v0.1.5+ on https://github.com/bitcoin/bitcoin/releases
		$uri = "https://github.com/bitcoin/bitcoin/archive/v$Version.zip"
	}
	SatoshiNakamotoInstitute {
		# See: https://satoshi.nakamotoinstitute.org/code/
		$uri = "https://s3.amazonaws.com/nakamotoinstitute/code/bitcoin-$SatoshiNakamotoInstitute"
		$md5 = switch ($SatoshiNakamotoInstitute) {
			nov08.tgz { '6884e5046285913c1a93ae071bcc763a' }
			0.1.0.rar { '91e2dfa2af043eabbb38964cbf368500' }
			0.1.0.tgz { 'dca1095f053a0c2dc90b19c92bd1ec00' }
			0.1.3.rar { '9a73e0826d5c069091600ca295c6d224' }
		}
	}
}
$outFile = Split-Path $uri -Leaf

$param = @{
	Uri     = $uri
	OutFile = $outFile
	Verbose = $true
}
Invoke-WebRequest @param

switch ($PSCmdlet.ParameterSetName) {
	GitHub {
		Get-FileHash $param.OutFile -Algorithm SHA256
	}
	SatoshiNakamotoInstitute {
		$result = (Get-FileHash $param.OutFile -Algorithm MD5).Hash
		if ($md5 -eq $result) {
			Write-Information "Passed the MD5 test: $result"
		} else {
			Write-Error "Failed the MD5 test: Expected = $md5, Result = $result"
		}
	}
}
