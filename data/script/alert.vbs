Dim value(3)
Set objArgs = WScript.Arguments
value(0) = objArgs(0)
value(1) = objArgs(1)
value(2) = objArgs(2)
value(3) = objArgs(3)

intMessage = MsgBox(value(1), vbYesNo, value(0))

' Check the number of arguments sent
If objArgs.Count > 0 Then

    ' ' Display the selected directory
    ' WScript.Echo "Value:" & value(0) & value(1) & value(2)

    Select Case intMessage
        Case vbYes
            ' Code to be executed if the Yes option is chosen
            Set objShell = CreateObject("WScript.Shell")
                objShell.Run value(3), 1, True
        Case vbNo
            ' Code to be executed if the No option is chosen
            MsgBox value(2), vbInformation, value(0)
    End Select
Else
    WScript.Echo "Tidak Ada Data Yang Diterima"
End If