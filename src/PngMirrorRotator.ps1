# SCRIPT 2019-12-23, Powershell 5.1.18362.145, Alexander Mattheis

Param(
  [Parameter(Mandatory=$true, position=0)][String]$sourcePath,
  [Parameter(Mandatory=$true, position=1)][String]$nameExtension,
  [Parameter(Mandatory=$true, position=2)][String]$operation  # RotateNoneFlipNone, Rotate90FlipX, ...
);

# constants
$FILE_EXTENSION = "png";

 # imports
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing"); 

function Start-Script() {
    Get-ChildItem -Path $sourcePath -Include "*.$FILE_EXTENSION" -Recurse -Depth 1 | 
        ForEach-Object {
            $newFullName = $_.FullName.Replace(".$FILE_EXTENSION", "$nameExtension.$FILE_EXTENSION");
            Copy-Item $_.FullName $newFullName
            $image = [System.Drawing.image]::FromFile($newFullName);
            $image.rotateflip($operation);
            $image.save($newFullName);  # hint for *.jpg use $image.save($newFullName, "jpeg"); or your files will grow in size
        }
}

Start-Script;