#define Publisher "Surge Synth Team"

#ifndef URL
#define URL "https://www.surge-synth-team.org/"
#endif

#ifndef Version
#define Version "0.0.0"
#endif

[Setup]
#if Arch == "arm64"
OutputBaseFilename={#NameCondensed}-{#Version}-Windows-ARM64-setup
#elif Arch == "x64compatible"
OutputBaseFilename={#NameCondensed}-{#Version}-Windows-64bit-setup
#elif Arch == "x86compatible"
OutputBaseFilename={#NameCondensed}-{#Version}-Windows-32bit-setup
#endif

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
LicenseFile={#SRC}\LICENSE
SetupIconFile={#Icon}
SolidCompression=yes
UninstallDisplayIcon={uninstallexe}
UninstallFilesDir={autoappdata}\{#Name}\uninstall
WizardImageAlphaFormat=defined
WizardImageFile=blank.png
WizardSizePercent=100
WizardSmallImageFile=blank.png
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom"; Flags: iscustom

#ifdef CLAP
[Types]
Name: "clap"; Description: "CLAP installation"
[Components]
Name: "CLAP"; Description: "{#Name} CLAP ({#Bits}-bit)"; Types: full clap custom
[Files]
Source: "{#BIN}\{#Name}.clap"; DestDir: "{autocf}\CLAP\{#Publisher}\"; Components: CLAP; Flags: ignoreversion
#endif

#ifdef VST3
[Types]
Name: "vst3"; Description: "VST3 installation"
[Components]
Name: "VST3"; Description: "{#Name} VST3 ({#Bits}-bit)"; Types: full vst3 custom
[Files]
Source: "{#BIN}\{#Name}.vst3\*"; DestDir: "{autocf}\VST3\{#Publisher}\{#Name}.vst3\"; Components: VST3; Flags: ignoreversion recursesubdirs
#endif

#ifdef STANDALONE
[Types]
Name: "standalone"; Description: "Standalone installation"
[Components]
Name: "SA"; Description: "{#Name} Standalone ({#Bits}-bit)"; Types: full standalone custom
[Files]
Source: "{#BIN}\{#Name}.exe"; DestDir: "{app}"; Components: SA; Flags: ignoreversion
#endif

[Icons]
Name: "{group}\{#Name}"; Filename: "{app}\{#Name}.exe"; Flags: createonlyiffileexists
