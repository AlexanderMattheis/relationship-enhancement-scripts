# SCRIPT 2018-10-14, Powershell 5.1.17134.228, Alexander Mattheis

# constants
$DEFAULT_NUMBER_OF_FOLDERS = 3;
$USER_PROMPT = "Number of folders to create (Default 3)?";
$ZERO_PADDING = "0";


<#
.SYNOPSIS
    Starts the program.
#>
function Start-Script() {
    Create-FolderWithDates(Read-PositiveNumber);
}


<#
.SYNOPSIS
    Reads in a number from the user.
.DESCRIPTION
    Asks the user for a number and if
    the user types in something else
    it returns DEFAULT_NUMBER_OF_FOLDERS.
.RETURN [int]
    User specified number.
#>
function Read-PositiveNumber() {
	$userInput = Read-UserInput $USER_PROMPT $DEFAULT_NUMBER_OF_FOLDERS;
	$userNumber = $userInput -as [int]; # can fail

	if ($userNumber -is [int] -and $userNumber -ge 0) {  # if positive number or zero
		return $userNumber;
	}

	return $DEFAULT_NUMBER_OF_FOLDERS;
}


<#
.SYNOPSIS
    Reads in an input from the user.
.DESCRIPTION
    Questioning the user for an input string and if the user doesn't
	type in something, it returns the default value.
.PARAMETER userPrompt [String]
    The string which is shown to the user.
.PARAMETER defaultValue [any]
    The default value which is returned when no value is specified.
.RETURN [any]
    User specified value.
#>
function Read-UserInput([String]$userPrompt, $defaultValue) {
	# read in from user
    $prompt = Read-Host -Prompt $userPrompt;
	$isReadIn = [bool]$prompt;  # check succesfully read in

	return ($defaultValue, $prompt)[$isReadIn];  # user value if successfully read in, else default value
}


<#
.SYNOPSIS
    Creates folders with a given date and number at the end.
.DESCRIPTION
    Given the variable numberOfFolders, it creates folders with the date 
    in format yyyy-MM-dd and a count at the end.
.EXAMPLE
    Create three folders with names "2018-10-14-1", "2018-10-14-2" 
    and "2018-10-14-3".

    CreateFoldersWithDates(3);
.PARAMETER numberOfFolder [int] 
    The number of folders that should be created (Default: $NUMBER_OF_FOLDERS).
#>
function Create-FolderWithDates([int]$numberOfFolders) {
    $date = Get-Date;
    $date = $date.ToString("yyyy-MM-dd");

	$numberOfDigits = $numberOfFolders.ToString().Length;

    for($i = 1; $i -le $numberOfFolders; $i++) {
		$count = $i.ToString().PadLeft($numberOfDigits, $ZERO_PADDING);  # create padding left with zeros
        New-Item -Name $date-$count -Force -ItemType Directory;
    }
}

Start-Script;