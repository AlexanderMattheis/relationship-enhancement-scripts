# SCRIPT 2018-10-17, Powershell 5.1.17134.228, Alexander Mattheis

# constants
$OUTPUT_FILENAME = "ProcessesLister.out";

function Start-Script() {
	(Get-Process).ProcessName | Out-File $OUTPUT_FILENAME;
}

Start-Script;