Set objShell = CreateObject("Shell.Application")
Set objFolder = objShell.BrowseForFolder(0, "Pilih direktori:", 0)
If objFolder Is Nothing Then
    WScript.Quit
End If
WScript.Echo objFolder.Self.Path
