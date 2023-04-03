intMessage = MsgBox("Do you want to run Repair Phase 2?", vbYesNo, "Confirmation")

' Take the arguments sent from the command prompt
Dim arguments
Set arguments = WScript.Arguments

' Check the number of arguments sent
If arguments.Count > 0 Then
    ' Get the value of the source variable
    Dim source
    source = arguments.Item(0)

    ' Display the selected directory
    WScript.Echo "Selected directory: " & source

    Select Case intMessage
        Case vbYes
            ' Code to be executed if the Yes option is chosen
            Set objShell = CreateObject("WScript.Shell")
            WScript.Echo "Executing the DataForge.bat file..."
            objShell.Run "data\DataForge.bat " & source, 1, True
        Case vbNo
            ' Code to be executed if the No option is chosen
            MsgBox "Repair Phase 2 Canceled", vbInformation, "Confirmation"
    End Select
Else
    WScript.Echo "No Directory Detected"
End If
