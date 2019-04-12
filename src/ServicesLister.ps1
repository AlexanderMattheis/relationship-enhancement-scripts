# SCRIPT 2018-10-17, Powershell 5.1.17134.228, Alexander Mattheis

# constants
$OUTPUT_FILENAME = "ServicesLister.out";

function Start-Script() {
	(Get-Service).Name | Out-File $OUTPUT_FILENAME;
}

Start-Script;