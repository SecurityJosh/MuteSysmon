#Requires -RunAsAdministrator

$Manifest = @"
<instrumentationManifest xmlns="http://schemas.microsoft.com/win/2004/08/events">
	<instrumentation>
		<events>
			<provider name="Microsoft-Windows-Sysmon" guid="{5770385F-C22A-43E0-BF4C-06F5698FFBD9}" />
		</events>
	</instrumentation>
</instrumentationManifest>
"@;

$TempFilePath = (New-TemporaryFile).FullName

Write-Host "[*] Writing manifest to temporary file '$TempFilePath'"
$Manifest | Out-File $TempFilePath

Write-Host '[*] Uninstalling Sysmon event manifest'
. 'wevtutil' 'um' $TempFilePath

Write-Host "[*] Deleting temporary file '$TempFilePath'"
Remove-Item -Path $TempFilePath -Force