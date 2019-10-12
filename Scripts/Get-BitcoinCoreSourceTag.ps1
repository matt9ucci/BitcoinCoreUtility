param (
	[switch]$Name
)

$param = @{
	Uri = 'https://api.github.com/repos/bitcoin/bitcoin/tags'
	Method = 'Get'
	FollowRelLink = $true
}
$result = Invoke-RestMethod @param

if ($Name) {
	$result.name
} else {
	$result
}
