'Set your settings

strFileURL = "https://opscode-omnibus-packages.s3.amazonaws.com/windows/2008r2/x86_64/chef-windows-11.12.8-2.windows.msi"
strHDLocation = "C:\chef-windows.msi"

' Fetch the file

Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP")

objXMLHTTP.open "GET", strFileURL, false
objXMLHTTP.send()

If objXMLHTTP.Status = 200 Then
  Set objADOStream = CreateObject("ADODB.Stream")
  objADOStream.Open
  objADOStream.Type = 1 'adTypeBinary

  objADOStream.Write objXMLHTTP.ResponseBody
  objADOStream.Position = 0    'Set the stream position to the start

  Set objFSO = Createobject("Scripting.FileSystemObject")
    If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation
  Set objFSO = Nothing

  objADOStream.SaveToFile strHDLocation
  objADOStream.Close
  Set objADOStream = Nothing
End if

Set objXMLHTTP = Nothing

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run "msiexec.exe /qn /i C:\chef-windows.msi"
