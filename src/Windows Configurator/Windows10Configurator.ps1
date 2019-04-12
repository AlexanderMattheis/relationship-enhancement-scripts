# SCRIPT 2018-10-14, Powershell 5.1.17134.228, Alexander Mattheis
$workingDirectory = Split-Path -parent $MyInvocation.MyCommand.Definition;

. $workingDirectory/Defaults.ps1;

<#
.SYNOPSIS
    Starts the program.
#>
function Start-Script() {
	$currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent());
    $isAdministrator = $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator);

	if ($isAdministrator) {
		Activate-ClassicPhotoViewer;
		Activate-NameExtensions;
		Activate-TaskbarSmallIcons;
        Remove-ShortcutNameExtension;
		Set-TaskbarGlomLevel($GLOM_LEVEL_HIDING_IF_NECESSARY);
	    Stop-Process -Name explorer;  # restarts explorer
    } else {
		Write-Warning ([Messages]::ADMIN_RIGHTS);
		Start-Sleep 3;
	}
}


<#
.SYNOPSIS
    Activates the classic photo-viewer known from Windows 7.
.DESCRIPTION
    Adds the necessary keys into the file associations 
	of the classic Windows 7 photo-viewer contained in Windows 7.
#>
function Activate-ClassicPhotoViewer() {
	Set-ItemProperty ([Keys]::PHOTO_VIEWER_FILE_ASSOCIATIONS) .bmp -Value "PhotoViewer.FileAssoc.Tiff";
	Set-ItemProperty ([Keys]::PHOTO_VIEWER_FILE_ASSOCIATIONS) .gif -Value "PhotoViewer.FileAssoc.Tiff";
	Set-ItemProperty ([Keys]::PHOTO_VIEWER_FILE_ASSOCIATIONS) .jpeg -Value "PhotoViewer.FileAssoc.Tiff";
    Set-ItemProperty ([Keys]::PHOTO_VIEWER_FILE_ASSOCIATIONS) .jpg -Value "PhotoViewer.FileAssoc.Tiff";
	Set-ItemProperty ([Keys]::PHOTO_VIEWER_FILE_ASSOCIATIONS) .png -Value "PhotoViewer.FileAssoc.Tiff";
}


<#
.SYNOPSIS
    Activates the name extensions.
.DESCRIPTION
    Sets the HideFileExt registry-entry to false.
#>
function Activate-NameExtensions() {
	Set-ItemProperty ([Keys]::SETTINGS) HideFileExt 0;
}

<#
.SYNOPSIS
    Activates a small taskbar.
.DESCRIPTION
    Sets the TaskbarSmallIcons registry-entry to true.
#>
function Activate-TaskbarSmallIcons() {
	Set-ItemProperty ([Keys]::SETTINGS) TaskbarSmallIcons 1;
}


<#
.SYNOPSIS
    Removes the name extension of a shortcut e.g. "- Shortcut".
.DESCRIPTION
    Asks the system for the Windows Release ID and if this ID equals 1703 or higher,
	the name extension on shortcuts is removed.
#>
function Remove-ShortcutNameExtension() {
	$windowsReleaseID = (Get-ItemProperty ([Keys]::WINDOWS_RELEASE_ID) -Name ReleaseID).ReleaseId;

	if ($windowsReleaseID -ge $IDS_WINDOWS_MIN_RELEASE) {
        Set-ItemProperty ([Keys]::SHORTCUT_EXTENSION) link -Value ([byte[]](0x00, 0x00, 0x00, 0x00));
	} else {
		Write-Warning ([Messages]::SHORTCUT_NAME_EXTENSION);
	}
}


<#
.SYNOPSIS
    Sets the taskbar glom-level.
.DESCRIPTION
    Changes the taskbar behaviour such that taskbar buttons only combined if necessary.
.PARAMETER glomLevel [int]
	The glom-level at which the taskbar should be set;
#>
function Set-TaskbarGlomLevel([int]$glomLevel) {
	Set-ItemProperty ([Keys]::SETTINGS) TaskbarGlomLevel $glomLevel;
}


Start-Script;