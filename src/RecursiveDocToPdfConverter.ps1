# SCRIPT 2019-04-12, Powershell 5.1.17134.228, Alexander Mattheis

# constants
$PDF_FORMAT = 17;

function Start-Script() {
    $wordApplication = New-Object -ComObject Word.Application;

    Get-ChildItem -Path $PSScriptRoot -Include *.doc, *.docx, *.rtf -Recurse |
	    ForEach-Object {
		    $docFile = $wordApplication.Documents.Open($_.Fullname);
		    $pdfFileName = $_.FullName -replace $_.Extension, '.pdf';
		    $docFile.ExportAsFixedFormat($pdfFileName, $PDF_FORMAT);
		    $docFile.Close();

            Write-Host $pdfFileName;
	    }

    $wordApplication.Quit();
    Write-Host "DONE";
}

Start-Script;
