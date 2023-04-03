Dim objPing, objStatus

Set objPing = GetObject("winmgmts:{impersonationLevel=impersonate}").ExecQuery _
    ("select * from Win32_PingStatus where address = '192.30.255.112'")

For Each objStatus in objPing
    If objStatus.Statuscode = 0 Then
        WScript.StdOut.Write "online"
    Else
        WScript.StdOut.Write "offline"
    End If
Next
