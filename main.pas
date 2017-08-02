unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Menus, ComCtrls, StdCtrls,
  Buttons, Process, LCLType, ExtCtrls, LCLTranslator, DefaultTranslator;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    BitBtn14: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn32: TBitBtn;
    BitBtn33: TBitBtn;
    BitBtn34: TBitBtn;
    BitBtn35: TBitBtn;
    BitBtn41: TBitBtn;
    BitBtn42: TBitBtn;
    BitBtn43: TBitBtn;
    BitBtn44: TBitBtn;
    BitBtn51: TBitBtn;
    BitBtn52: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn53: TBitBtn;
    BitBtn55: TBitBtn;
    BitBtn61: TBitBtn;
    BitBtn62: TBitBtn;
    BitBtn71: TBitBtn;
    BitBtn72: TBitBtn;
    BitBtn23: TBitBtn;
    BitBtn24: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn31: TBitBtn;
    BitBtn73: TBitBtn;
    BitBtn74: TBitBtn;
    Image1: TImage;
    ImageList1: TImageList;
    Label14: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    Label15: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label21: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label55: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label22: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label50: TLabel;
    Label60: TLabel;
    Label70: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    lblAppTitle: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn32Click(Sender: TObject);
    procedure BitBtn33Click(Sender: TObject);
    procedure BitBtn34Click(Sender: TObject);
    procedure BitBtn35Click(Sender: TObject);
    procedure BitBtn41Click(Sender: TObject);
    procedure BitBtn42Click(Sender: TObject);
    procedure BitBtn43Click(Sender: TObject);
    procedure BitBtn44Click(Sender: TObject);
    procedure BitBtn51Click(Sender: TObject);
    procedure BitBtn52Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn53Click(Sender: TObject);
    procedure BitBtn55Click(Sender: TObject);
    procedure BitBtn54Click(Sender: TObject);
    procedure BitBtn61Click(Sender: TObject);
    procedure BitBtn62Click(Sender: TObject);
    procedure BitBtn71Click(Sender: TObject);
    procedure BitBtn72Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn23Click(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn31Click(Sender: TObject);
    procedure BitBtn73Click(Sender: TObject);
    procedure BitBtn74Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;
  PODirectory, Lang, FallbackLang: string;

const
  AppVersion: string = '1.4';

resourcestring
  rsBleachbitRoot = 'Do you want to clean root session?';
  rsWineDisableQ = 'Do you want to disable WINE?';
  rsWineEnableQ = 'Do you want to enable WINE?';
  rsWineAlready32bit = 'Your system is already 32 bit!, this option for 64 bit systems!';
  rsNotice = 'Notice';
  rsArchEnableQ = 'Do you want to enable i386 arch?';
  rsPackageNotFound = 'not installed, Do you want to install it?';
  rsWineNotInstalled = 'WINE not installed!, Do you want to install it now?';
  rsBiConDisableQ = 'Bidirectional Console already active, do you want to disable it?';
  rsBiConEnableNotice =
    'Bidirectional Console enabled, please make sure that your Terminal allows run a command during login.';
  rsBackportsDisableQ = 'Do you want to Disable backports upgrade?';
  rsBackportsEnableQ = 'Do you want to Enable backports upgrade?';
  rsAutoUpEnabledYWantDisableQ =
    'Auto-update is already enabled, do you' + ' want to disable it?';
  rsYouWantEnableAutoUpdateQ = 'Do you want to enable the automatic update?';
  rsIfYouUsingLimitedTrafficQ =
    'If you are using a limited traffic internet ' +
    'connection, you should think carefully before enabling this option.';
  rsYWantOpenLogsAsRoot = 'Do you want to open logs viewer as a root?';

implementation

uses About, BidiUtils;

{$R *.lfm}

function GetPackageName(software: string): string;
var
  p: string;
begin
  p := software;
  case software of
    'gpk-prefs': p := 'gnome-packagekit';
    'deja-dup-preferences': p := 'deja-dup';
    'gnome-disks': p := 'gnome-disk-utility';
    'synaptic-pkexec': p := 'synaptic';
  end;
  Result := p;
end;

function SoftwareExists(SoftwareName: string): boolean;
var
  Reply, BoxStyle: integer;
  aProcess: TProcess;
begin
  if FileExists('/usr/bin/' + SoftwareName) or FileExists('/bin/' + SoftwareName) then
    Result := True
  else
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(
      PChar(GetPackageName(SoftwareName) + ' ' + rsPackageNotFound),
      PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      aProcess := TProcess.Create(nil);
      aProcess.Options := [poUsePipes];
      aProcess.Executable := 'x-terminal-emulator';
      aProcess.Parameters.Add('-e');
      aProcess.Parameters.Add('sudo /usr/share/wahacc/scripts/installer ' +
        GetPackageName(SoftwareName));
      aProcess.Execute;
      aProcess.Free;
    end;
    Result := False;
  end;
end;

procedure exec_process(Software: string; RunAsRoot: boolean);
var
  aProcess: TProcess;
begin
  if SoftwareExists(Software) then           // Check if program exists
  begin
    aProcess := TProcess.Create(nil);        // Run program
    aProcess.Options := [poUsePipes];
    if RunAsRoot then
    begin
      aProcess.Executable := 'gksu';
      aProcess.Parameters.Add('-S');
      aProcess.Parameters.Add(Software);
    end
    else
      aProcess.Executable := Software;
    aProcess.Execute;
    aProcess.Free;
  end;
end;


{ TfrmMain }

procedure TfrmMain.MenuItem4Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.MenuItem5Click(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.BitBtn21Click(Sender: TObject);
begin
  exec_process('hardinfo', False);
end;

procedure TfrmMain.BitBtn53Click(Sender: TObject);
begin
  exec_process('baobab', False);
end;

procedure TfrmMain.BitBtn55Click(Sender: TObject);
begin
  exec_process('ntfs-config', True);
end;

procedure TfrmMain.BitBtn54Click(Sender: TObject);
begin
  exec_process('gnome-disks', False);
end;

procedure TfrmMain.BitBtn61Click(Sender: TObject);
var
  aProcess: TProcess;
begin
  if SoftwareExists('gnome-control-center') then
  begin
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poUsePipes];
    aProcess.Executable := 'gnome-control-center';
    aProcess.Parameters.Add('user-accounts');
    aProcess.Execute;
    aProcess.Free;
  end;
end;

procedure TfrmMain.BitBtn62Click(Sender: TObject);
begin
  exec_process('deja-dup-preferences', False);
end;

procedure TfrmMain.BitBtn71Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
  r: TStringList;
  RealPath, permission: string;
  aProcess: TProcess;
begin
  if SoftwareExists('wine') then           // Check wine is installed or no!
  begin
    // Get real path of wine
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poWaitOnExit, poUsePipes];
    aProcess.Executable := '/bin/readlink';
    aProcess.Parameters.Add('-f');
    aProcess.Parameters.Add('/usr/bin/wine');
    aProcess.Execute;
    r := TStringList.Create;
    r.LoadFromStream(aProcess.Output);
    RealPath := r.DelimitedText;
    aProcess.Free;
    r.Free;

    // Get current permission
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poWaitOnExit, poUsePipes];
    aProcess.Executable := '/usr/bin/stat';
    aProcess.Parameters.Add('-c');
    aProcess.Parameters.Add('%A');
    aProcess.Parameters.Add(RealPath);
    aProcess.Execute;
    r := TStringList.Create;
    r.LoadFromStream(aProcess.Output);
    permission := r.DelimitedText[4];
    aProcess.Free;
    r.Free;

    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    if permission = 'x' then             // Ask to disable wine
    begin
      Reply := Application.MessageBox(PChar(rsWineDisableQ), PChar(rsNotice), BoxStyle);
      if Reply = idYes then
      begin
        aProcess := TProcess.Create(nil);
        aProcess.Options := [poWaitOnExit, poUsePipes];
        aProcess.Executable := 'gksu';
        aProcess.Parameters.Add('-S');
        aProcess.Parameters.Add('chmod -x');
        aProcess.Parameters.Add('/usr/bin/wine');
        if FileExists('/usr/bin/wine64') then
          aProcess.Parameters.Add('/usr/bin/wine64');
        aProcess.Execute;
        aProcess.Free;
      end;
    end
    else              // Ask to enable wine
    begin
      Reply := Application.MessageBox(PChar(rsWineEnableQ), PChar(rsNotice), BoxStyle);
      if Reply = idYes then
      begin
        aProcess := TProcess.Create(nil);
        aProcess.Options := [poWaitOnExit, poUsePipes];
        aProcess.Executable := 'gksu';
        aProcess.Parameters.Add('-S');
        aProcess.Parameters.Add('chmod +x');
        aProcess.Parameters.Add('/usr/bin/wine');
        if FileExists('/usr/bin/wine64') then
          aProcess.Parameters.Add('/usr/bin/wine64');
        aProcess.Execute;
        aProcess.Free;
      end;
    end;
  end;
end;

procedure TfrmMain.BitBtn72Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
  r: TStringList;
  p: string;
  aProcess: TProcess;
begin
  if SoftwareExists('dpkg') then
  begin
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poUsePipes];
    aProcess.Executable := 'dpkg';
    aProcess.Parameters.Add('--print-architecture');
    aProcess.Execute;
    r := TStringList.Create;
    r.LoadFromStream(aProcess.Output);
    p := copy(r.Text, 1, 4);
    aProcess.Free;
    r.Free;
    if p = 'i386' then
    begin
      BoxStyle := MB_ICONASTERISK + MB_OK;
      Reply := Application.MessageBox(PChar(rsWineAlready32bit),
        PChar(rsNotice), BoxStyle);
    end
    else
    begin
      BoxStyle := MB_ICONQUESTION + MB_YESNO;
      Reply := Application.MessageBox(PChar(rsArchEnableQ), PChar(rsNotice), BoxStyle);
      if Reply = idYes then
      begin
        aProcess := TProcess.Create(nil);
        aProcess.Options := [poUsePipes];
        aProcess.Executable := 'x-terminal-emulator';
        aProcess.Parameters.Add('-e');
        aProcess.Parameters.Add('sudo /usr/share/wahacc/scripts/multiarch');
        aProcess.Execute;
        aProcess.Free;
      end;
    end;
  end;
end;

procedure TfrmMain.BitBtn32Click(Sender: TObject);
var
  aProcess: TProcess;
begin
  if SoftwareExists('gnome-control-center') then
  begin
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poUsePipes];
    aProcess.Executable := 'gnome-control-center';
    aProcess.Parameters.Add('sharing');
    aProcess.Execute;
    aProcess.Free;
  end;
end;

procedure TfrmMain.BitBtn14Click(Sender: TObject);
var
  aProcess: TProcess;
begin
  if SoftwareExists('synaptic-pkexec') then
  begin
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poUsePipes];
    aProcess.Executable := 'synaptic-pkexec';
    aProcess.Parameters.Add('--update-at-startup');
    aProcess.Parameters.Add('--dist-upgrade-mode');
    aProcess.Parameters.Add('--non-interactive');
    aProcess.Parameters.Add('--hide-main-window');
    aProcess.Parameters.Add('-o');
    aProcess.Parameters.Add('Synaptic::AskRelated=true');
    aProcess.Execute;
    aProcess.Free;
  end;
end;

procedure TfrmMain.BitBtn16Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
  r: TStringList;
  aProcess: TProcess;
begin
  aProcess := TProcess.Create(nil);
  aProcess.Options := [poUsePipes];
  aProcess.Executable := '/bin/bash';
  aProcess.Parameters.Add('-c');
  aProcess.Parameters.Add(
    'grep -r ''^APT::Periodic::Unattended-Upgrade "1"'' /etc/apt/apt.conf.d/* | wc -l');
  aProcess.Execute;
  r := TStringList.Create;
  r.LoadFromStream(aProcess.Output);
  aProcess.Free;
  if (r.Text[1] = '1') then
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(PChar(rsAutoUpEnabledYWantDisableQ),
      PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      aProcess := TProcess.Create(nil);
      aProcess.Options := [poUsePipes];
      aProcess.Executable := '/usr/bin/gksu';
      aProcess.Parameters.Add('-S');
      aProcess.Parameters.Add('/usr/share/wahacc/scripts/autoupdate disable');
      aProcess.Execute;
      aProcess.Free;
    end;
  end
  else
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(PChar(rsYouWantEnableAutoUpdateQ +
      LineEnding + rsIfYouUsingLimitedTrafficQ), PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      aProcess := TProcess.Create(nil);
      aProcess.Options := [poUsePipes];
      aProcess.Executable := '/usr/bin/gksu';
      aProcess.Parameters.Add('-S');
      aProcess.Parameters.Add('/usr/share/wahacc/scripts/autoupdate enable');
      aProcess.Execute;
      aProcess.Free;
    end;
  end;
  r.Free;
end;

procedure TfrmMain.BitBtn33Click(Sender: TObject);
begin
  exec_process('vinagre', False);
end;

procedure TfrmMain.BitBtn34Click(Sender: TObject);
var
  aProcess: TProcess;
begin
  if SoftwareExists('gnome-control-center') then
  begin
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poUsePipes];
    aProcess.Executable := 'gnome-control-center';
    aProcess.Parameters.Add('sharing');
    aProcess.Execute;
    aProcess.Free;
  end;
end;

procedure TfrmMain.BitBtn35Click(Sender: TObject);
begin
  exec_process('gufw', False);
end;

procedure TfrmMain.BitBtn41Click(Sender: TObject);
begin
  exec_process('gnome-tweak-tool', False);
end;

procedure TfrmMain.BitBtn42Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
begin
  BoxStyle := MB_ICONQUESTION + MB_YESNO;
  Reply := Application.MessageBox(PChar(rsYWantOpenLogsAsRoot), PChar(rsNotice
    ), BoxStyle);
  if Reply = idYes then
    exec_process('gnome-logs', True)
  else
    exec_process('gnome-logs', False);
end;

procedure TfrmMain.BitBtn43Click(Sender: TObject);
begin
  exec_process('font-manager', False);
end;

procedure TfrmMain.BitBtn44Click(Sender: TObject);
var
  aProcess: TProcess;
begin
  if SoftwareExists('gnome-control-center') then
  begin
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poUsePipes];
    aProcess.Executable := 'gnome-control-center';
    aProcess.Parameters.Add('region');
    aProcess.Execute;
    aProcess.Free;
  end;
end;

procedure TfrmMain.BitBtn51Click(Sender: TObject);
begin
  exec_process('gnome-disks', False);
end;

procedure TfrmMain.BitBtn52Click(Sender: TObject);
begin
  exec_process('gparted-pkexec', False);
end;

procedure TfrmMain.BitBtn22Click(Sender: TObject);
var
  aProcess: TProcess;
begin
  if SoftwareExists('ddm') then
  begin
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poUsePipes];
    aProcess.Executable := 'gksu';
    //aProcess.Parameters.Add('-S');   // ddm not execute correctly in sudo mode!
    aProcess.Parameters.Add('ddm');
    aProcess.Execute;
    aProcess.Free;
  end;
end;

procedure TfrmMain.BitBtn23Click(Sender: TObject);
begin
  exec_process('jstest-gtk', False);
end;

procedure TfrmMain.BitBtn24Click(Sender: TObject);
begin
  exec_process('system-config-printer', False);
end;

procedure TfrmMain.BitBtn11Click(Sender: TObject);
begin
  exec_process('gnome-software', False);
end;

procedure TfrmMain.BitBtn12Click(Sender: TObject);
var
  aProcess: TProcess;
begin
  if SoftwareExists('synaptic-pkexec') then
  begin
    aProcess := TProcess.Create(nil);
    aProcess.Options := [poUsePipes];
    aProcess.Executable := 'synaptic-pkexec';
    aProcess.Parameters.Add('--update-at-startup');
    aProcess.Parameters.Add('--upgrade-mode');
    aProcess.Parameters.Add('--non-interactive');
    aProcess.Parameters.Add('--hide-main-window');
    aProcess.Parameters.Add('-o');
    aProcess.Parameters.Add('Synaptic::AskRelated=true');
    aProcess.Execute;
    aProcess.Free;
  end;
end;

procedure TfrmMain.BitBtn13Click(Sender: TObject);
begin
  exec_process('software-properties-gtk', False);
end;

procedure TfrmMain.BitBtn15Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
begin
  BoxStyle := MB_ICONQUESTION + MB_YESNO;
  Reply := Application.MessageBox(PChar(rsBleachbitRoot), PChar(rsNotice), BoxStyle);
  if Reply = idYes then
    exec_process('bleachbit', True)
  else
    exec_process('bleachbit', False);
end;

procedure TfrmMain.BitBtn31Click(Sender: TObject);
begin
  exec_process('nm-connection-editor', False);
end;

procedure TfrmMain.BitBtn73Click(Sender: TObject);
var
  f: TextFile;
  Reply, BoxStyle: integer;
begin
  if SoftwareExists('bicon') then
  begin
    AssignFile(f, GetUserDir + '.bash_login');
    if FileExists(GetUserDir + '.bash_login') then
    begin
      BoxStyle := MB_ICONQUESTION + MB_YESNO;
      Reply := Application.MessageBox(PChar(rsBiConDisableQ), PChar(rsNotice), BoxStyle);
      if Reply = idYes then
      begin
        Filemode := 0;
        Reset(f);
        CopyFile(GetUserDir + '.bash_login', GetUserDir + '.bash_login.bak');
        DeleteFile(GetUserDir + '.bash_login');
      end;
    end
    else
    if not FileExists(GetUserDir + '.bash_login') then
    begin
      Rewrite(f);
      Writeln(f, '# include .profile if it exists');
      Writeln(f, 'if [ -f "$HOME/.profile" ]; then');
      Writeln(f, '   . "$HOME/.profile"');
      Writeln(f, 'fi');
      Writeln(f, '# run bicon terminal if exists');
      Writeln(f, 'if [ -x /usr/bin/bicon ]; then');
      Writeln(f, '   bicon');
      Writeln(f, 'fi');
      CloseFile(f);
      BoxStyle := MB_ICONASTERISK + MB_OK;
      Reply := Application.MessageBox(PChar(rsBiConEnableNotice),
        PChar(rsNotice), BoxStyle);
    end;
  end;
end;

procedure TfrmMain.BitBtn74Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
  aProcess: TProcess;
begin
  if FileExists('/etc/apt/preferences.d/jessie-backports') then
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(PChar(rsBackportsDisableQ),
      PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      aProcess := TProcess.Create(nil);
      aProcess.Options := [poUsePipes];
      aProcess.Executable := '/usr/bin/gksu';
      aProcess.Parameters.Add('-S');
      aProcess.Parameters.Add('rm /etc/apt/preferences.d/jessie-backports');
      aProcess.Execute;
      aProcess.Free;
    end;
  end
  else
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(PChar(rsBackportsEnableQ),
      PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      aProcess := TProcess.Create(nil);
      aProcess.Options := [poUsePipes];
      aProcess.Executable := 'x-terminal-emulator';
      aProcess.Parameters.Add('-e');
      aProcess.Parameters.Add('sudo /usr/share/wahacc/scripts/backports');
      aProcess.Execute;
      aProcess.Free;
    end;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  i, l, l2, plength: integer;
begin
  // Flip Compenents
  BiDiMode := GetBiDiMode;
  if BiDiMode = bdRightToLeft then
  begin
    FlipForm(Self);
    doFlipChildren;
    PageControl1.FlipChildren(True);
    Self.Font.Name := 'Noto Kufi Arabic';
    lblAppTitle.Font.Name := 'Noto Kufi Arabic';
    PageControl1.Font.Name := 'Noto Kufi Arabic';
    Label10.Font.Name := 'Noto Kufi Arabic';
    Label20.Font.Name := 'Noto Kufi Arabic';
    Label30.Font.Name := 'Noto Kufi Arabic';
    Label40.Font.Name := 'Noto Kufi Arabic';
    Label50.Font.Name := 'Noto Kufi Arabic';
    Label60.Font.Name := 'Noto Kufi Arabic';
    Label70.Font.Name := 'Noto Kufi Arabic';
  end;

  plength := 30;
  for i := 1 to 7 do
  begin
    l := Length(TTabSheet(FindComponent('TabSheet' + IntToStr(i))).Caption);
    if l < plength then
      repeat
        with TTabSheet(FindComponent('TabSheet' + IntToStr(i))) do
          Caption := ' ' + Caption;
        l2 := Length(TTabSheet(FindComponent('TabSheet' + IntToStr(i))).Caption);
      until l2 >= plength;
  end;
end;

end.
