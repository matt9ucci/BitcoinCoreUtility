param (
	[switch]$Name
)

$result = Invoke-RestMethod -Uri https://api.github.com/repos/bitcoin/bitcoin/tags -Method Get -FollowRelLink
if ($Name) {
	$result.name
} else {
	$result
}
