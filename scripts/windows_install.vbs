'Set your settings
Set wshShell = WScript.CreateObject("WScript.Shell")
prof = wshShell.ExpandEnvironmentStrings("%USERPROFILE%")

strFileURL = "https://opscode-omnibus-packages.s3.amazonaws.com/windows/2008r2/x86_64/chef-windows-11.12.8-2.windows.msi"
strHDLocation = prof & "\Downloads\chef-windows.msi"

Function DownloadFile(url, localPath)
  ' Fetch the file
  Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP")

  objXMLHTTP.open "GET", url, false
  objXMLHTTP.send()

  If objXMLHTTP.Status = 200 Then
    Set objADOStream = CreateObject("ADODB.Stream")
    objADOStream.Open
    objADOStream.Type = 1 'adTypeBinary

    objADOStream.Write objXMLHTTP.ResponseBody
    objADOStream.Position = 0    'Set the stream position to the start

    Set objFSO = Createobject("Scripting.FileSystemObject")
      If objFSO.Fileexists(localPath) Then objFSO.DeleteFile localPath
    Set objFSO = Nothing

    objADOStream.SaveToFile localPath
    objADOStream.Close
    Set objADOStream = Nothing
  End if

  Set objXMLHTTP = Nothing
end Function

DownloadFile strFileUrl, strHDLocation

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run "msiexec.exe /qb /i " & strHDLocation & "ADDLOCAL=ChefClientFeature"

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.run "knife cookbook site download windows"
WshShell.run "tar zxf windows*.tar.gz -C la_cookbooks"

Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run "chef-solo -c la_cookbooks\fueled-windows-apps\config.rb -j la_cookbooks\fueled-windows-apps\roles\default.json"
