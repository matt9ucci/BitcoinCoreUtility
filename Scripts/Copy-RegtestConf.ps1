Copy-Item -Path $PSScriptRoot\..\ConfigurationFiles\regtest.conf -Destination (Join-Path $env:APPDATA Bitcoin bitcoin.conf)
