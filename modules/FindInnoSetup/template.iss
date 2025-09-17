#define Publisher "Surge Synth Team"

#ifndef URL
#define URL "https://www.surge-synth-team.org/"
#endif

#ifndef Version
#define Version "0.0.0"
#endif

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Setup]
OutputBaseFilename={#NameCondensed}-{#Version}-Windows-{#Arch}-setup
AppId={#ID}
AppName={#Name}
AppPublisher={#Publisher}
AppPublisherURL={#URL}
AppSupportURL={#URL}
AppUpdatesURL={#URL}
AppVerName={#Name}
AppVersion={#Version}
ArchitecturesAllowed={#Arch}
ArchitecturesInstallIn64BitMode={#Arch}
CloseApplicationsFilter=*.exe,*.vst3
DefaultDirName={autopf}\{#Publisher}\{#Name}\
DefaultGroupName={#Name}
DisableDirPage=yes
DisableProgramGroupPage=yes
#ifdef License
LicenseFile={#License}
#endif
SetupIconFile={#Icon}
SolidCompression=yes
UninstallDisplayIcon={uninstallexe}
UninstallFilesDir={autoappdata}\{#Name}\uninstall
WizardImageAlphaFormat=defined
WizardImageFile=blank.png
WizardSizePercent=100
WizardSmallImageFile=blank.png
WizardStyle=modern
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom"; Flags: iscustom
Name: "clap"; Description: "CLAP installation"
Name: "vst3"; Description: "VST3 installation"
Name: "standalone"; Description: "Standalone installation"

[Components]
Name: "CLAP"; Description: "{#Name} CLAP"; Types: full custom clap; Flags: checkablealone
Name: "VST3"; Description: "{#Name} VST3"; Types: full custom vst3; Flags: checkablealone
Name: "SA"; Description: "{#Name} Standalone"; Types: full custom standalone; Flags: checkablealone

[Files]
Source: "{#StagedAssets}\{#Name}.clap"; DestDir: "{autocf}\CLAP\{#Publisher}\"; Components: CLAP; Flags: ignoreversion
Source: "{#StagedAssets}\{#Name}.vst3\*"; DestDir: "{autocf}\VST3\{#Publisher}\{#Name}.vst3\"; Components: VST3; Flags: ignoreversion recursesubdirs
Source: "{#StagedAssets}\{#Name}.exe"; DestDir: "{app}"; Components: SA; Flags: ignoreversion

#ifdef Data
[Components]
Name: "Data"; Description: "Data files"; Types: full custom clap vst3 standalone; Flags: fixed disablenouninstallwarning
[Files]
Source: "{#Data}\*"; DestDir: "{code:get_data_path}"; Flags: ignoreversion recursesubdirs
#endif

[Icons]
Name: "{group}\{#Name}"; Filename: "{app}\{#Name}.exe"; Flags: createonlyiffileexists

[Code]
function get_data_path(Param: string): string;
begin
  if IsAdminInstallMode then
    // System-wide → ProgramData
    Result := ExpandConstant('{commonappdata}')
  else
    // Per-user → LocalAppData
    Result := ExpandConstant('{localappdata}');
end;
