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
; This is how we enable a non-elevated install, disabled until we resolve issues with DAWs
; PrivilegesRequired=lowest
; PrivilegesRequiredOverridesAllowed=dialog

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom"; Flags: iscustom
#ifdef CLAP
Name: "clap"; Description: "CLAP installation"
#endif
#ifdef VST3
Name: "vst3"; Description: "VST3 installation"
#endif
#ifdef SA
Name: "standalone"; Description: "Standalone installation"
#endif

[Components]
#ifdef CLAP
Name: "CLAP"; Description: "{#Name} CLAP"; Types: full custom clap; Flags: checkablealone
#endif

#ifdef VST3
Name: "VST3"; Description: "{#Name} VST3"; Types: full custom vst3; Flags: checkablealone
#endif

#ifdef SA
Name: "SA"; Description: "{#Name} Standalone"; Types: full custom standalone; Flags: checkablealone
#endif

[Files]
#ifdef CLAP
Source: "{#StagedAssets}\{#Name}.clap"; DestDir: "{autocf}\CLAP\{#Publisher}\"; Components: CLAP; Flags: ignoreversion
#endif

#ifdef VST3
Source: "{#StagedAssets}\{#Name}.vst3\*"; DestDir: "{autocf}\VST3\{#Publisher}\{#Name}.vst3\"; Components: VST3; Flags: ignoreversion recursesubdirs
#endif

#ifdef SA
Source: "{#StagedAssets}\{#Name}.exe"; DestDir: "{app}"; Components: SA; Flags: ignoreversion
#endif

#ifdef Data
[Components]
#ifdef CLAP
#define FORMATS " clap"
#endif
#ifdef VST3
#define FORMATS FORMATS + " vst3"
#endif
#ifdef SA
#define FORMATS FORMATS + " standalone"
#endif

Name: "Data"; Description: "Data files"; Types: full custom{#FORMATS}; Flags: fixed disablenouninstallwarning
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
