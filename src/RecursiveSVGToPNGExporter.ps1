# SCRIPT 2019-12-23, Powershell 5.1.18362.145, Alexander Mattheis

Param(
  [Parameter(Mandatory=$true, position=0)][String]$inkscapeExePath,
  [Parameter(Mandatory=$true, position=1)][String]$svgPath,
  [Parameter(Mandatory=$true, position=2)][String]$targetPath
);

function Start-Script() {
	Set-Alias -Name inkscape -Value $inkscapeExePath;

	Get-ChildItem -Path $svgPath -Include *.svg -Recurse | 
		ForEach-Object {
			$sourcePath = $_.FullName
			$destinationFilepath = $sourcePath -replace $_.Extension, ".png";
			$destinationFilepath = $destinationFilepath.Replace($svgPath, $targetPath);

			$destinationDirPath = Split-Path -Path $destinationFilepath;  # returns parent-folder name
			 
			if (!(Test-Path -Path $destinationDirPath)) {  # checks whether the folder exists
				New-Item -Path $destinationDirPath -Type Directory | out-null;  # if not, create the directory
			}

			Write-Host "inkscape --file=$sourcePath --export-png=$destinationFilepath";
			Invoke-Expression 'inkscape --file="$sourcePath" --export-png="$destinationFilepath"';
		}

	Write-Host "DONE";
}

Start-Script;