# SCRIPT 2018-10-16, Powershell 5.1.17134.228, Alexander Mattheis
$scriptName = $MyInvocation.MyCommand.Name;

# constants
$OUTPUT_FILENAME = "FilesLister.out";
$MESSAGE_WRONG_INPUT = "You have to use booleans! Write 'true' or 'false' (Default value 'false' will be used).";

class Prompts {
    static [String] $FILE_ENDINGS = "Print Fileendings (Default 'false')?"; 
	static [String] $ONLY_FILES = "List only files (Default 'false')?";
}


function Start-Script() {
	$onlyFilenames = Check-OnlyFilenames;
	$showFilendings = Check-Fileendings;
	Store-Filenames $onlyFilenames $showFilendings;
}


function Check-OnlyFilenames() {
	return Read-Boolean([Prompts]::ONLY_FILES);
}


function Read-Boolean([String]$Prompt) {
	$userInput = Read-Host -Prompt $Prompt;
	$booleanInput = $false;

	try {
		$booleanInput = [System.Convert]::ToBoolean($userInput);
	} catch {
		Write-Warning $MESSAGE_WRONG_INPUT;
	}

	return $booleanInput;
}


function Check-Fileendings() {
	return Read-Boolean(([Prompts]::FILE_ENDINGS));
}


function Store-Filenames([bool]$onlyFiles, [bool]$showFilendings) {
	$files = Read-Files($onlyFiles);
	$filteredFiles = Filter-Files($files);

	if ($showFilendings) {
		$filteredFiles.PSChildName | Sort-Object | Out-File $OUTPUT_FILENAME;  # accessed PSChildName of all elements
	} else {
		$filteredFiles.BaseName | Sort-Object | Out-File $OUTPUT_FILENAME;
	}
}


function Read-Files([bool]$onlyFiles) {
	if ($onlyFiles) {
		$files = Get-ChildItem -Attributes !Directory+!System;  # should not list script
	} else {
		$files = Get-ChildItem;  # should not list script
	}

	return $files;
}


function Filter-Files($files) {
	$filteredFiles = New-Object System.Collections.ArrayList;

	foreach($file in $files) {
		if ($file.PSChildName -ne $scriptName) {
			$filteredFiles.Add($file);
		}
	}
	
	return $filteredFiles;
}

Start-Script;