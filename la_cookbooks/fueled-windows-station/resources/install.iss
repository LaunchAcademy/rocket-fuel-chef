[Setup]
AppName=RocketFuel Installer
AppVersion=0.1
AppCopyright=2014
AppId={{6723C757-AC03-4EE0-BDA8-9EA21B3220E5}
AppPublisher=Launch Academy, Inc.
AppPublisherURL=http://www.launchacademy.com
AppSupportURL=http://www.launchacademy.com/ground-control/rocket-fuel
VersionInfoVersion=0.1
VersionInfoCompany=Launch Academy
VersionInfoCopyright=2014
VersionInfoProductName=RocketFuel Installer
VersionInfoProductVersion=0.1
DefaultDirName={pf}\Rocket Fuel

[Files]
Source: "vendor\chef-windows-11.16.0-1.windows.msi"; DestDir: "{tmp}"

[Run]
Filename: "msiexec.exe"; Parameters: "/qb /i ""{tmp}\chef-windows-11.16.0-1.windows.msi""";

[Code]
procedure InitializeWizard();
begin;
  
end;

procedure DownloadRocketFuel();
begin;
end;