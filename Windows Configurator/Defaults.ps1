# SCRIPT 2018-10-16, Powershell 5.1.17134.228, Alexander Mattheis

$IDS_WINDOWS_MIN_RELEASE = 1703;

<#
	Stores all messages used in the program.
#>
class Messages {
    static [String] $ADMIN_RIGHTS = "You need Administrator rights to execute the script!";
    static [String] $SHORTCUT_NAME_EXTENSION = "You need Windows 1703 or higher to remove the name extension on shortcuts!"; 
}

<#
	Stores all keys used in the program.
#>
class Keys {
	static [String] $PHOTO_VIEWER_FILE_ASSOCIATIONS = "HKLM:\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations";
	static [String] $SETTINGS = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced";
	static [String] $SHORTCUT_EXTENSION = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer";
	static [String] $WINDOWS_RELEASE_ID = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\";
}