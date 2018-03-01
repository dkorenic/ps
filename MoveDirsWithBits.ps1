Import-Module BitsTransfer 
$source = "\\10.8.0.1\zroot\extra\HR Crtici Filmovi" 
$dest = "C:\Kablovska\extra\HR Crtici Filmovi" 
xcopy.exe /T /E $source $dest /Y 
Get-ChildItem -Path $source -Recurse | ?{$_.PSisContainer} | % {
    $path = $_.FullName.Remove(0,$source.Length+1); 
    Start-BitsTransfer -Source $source\$spath\*.* -Destination $dest\$spath -Asynchronous
} 
Start-BitsTransfer $source\*.* $dest -Asynchronous

Get-BitsTransfer | Select-Object -ExpandProperty FileList | Format-Table RemoteName, BytesTotal, BytesTransferred

Get-BitsTransfer | Suspend-BitsTransfer
Get-BitsTransfer | Resume-BitsTransfer -Asynchronous
Get-BitsTransfer | fl *