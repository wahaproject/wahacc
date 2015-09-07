{%BuildCommand $(CompPath) $(EdFile) OPT=-dGTK2 OPT=-dGTK_2_8}
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, StdCtrls, Buttons, Process, LCLType, ExtCtrls, dateutils,
  LResources, gettext, Translations, DefaultTranslator, about;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn14: TBitBtn;
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
    BitBtn54: TBitBtn;
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
    ImageList1: TImageList;
    Label14: TLabel;
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
    Label54: TLabel;
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
    Label83: TLabel;
    Label81: TLabel;
    Label82: TLabel;
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
    Process1: TProcess;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    procedure BitBtn14Click(Sender: TObject);
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
    procedure FormCreate(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }
  end;

var
  Form1: TForm1;
  ccexec: TProcess;
  PODirectory, Lang, FallbackLang: string;

const
  version: string = '1.3';

resourcestring
  rsBleachbitRoot = 'Do you want to clean root session?';
  rsWineDisableQ = 'Do you want to disable WINE?';
  rsWineEnableQ = 'Do you want to enable WINE?';
  rsWineAlready32bit = 'Your system is already 32 bit!, this option for 64 bit systems!';
  rsNotice = 'Notice';
  rsArchEnableQ = 'Do you want to enable i386 arch?';
  rsPackageNotFound = ' Not installed, Do you want to install it?';
  rsWineNotInstalled = 'WINE not installed!, Do you want to install it now?';
  rsBiConDisableQ = 'Bidirectional Console already active, do you want to disable it?';
  rsBiConEnableNotice =
    'Bidirectional Console enabled, please make sure that your Terminal allows run a command during login.';
  rsBiConNotInstalled = 'BiCon package is not installed!, Do you want to install it now?';
  rsBackportsDisableQ = 'Do you want to Disable backports upgrade?';
  rsBackportsEnableQ = 'Do you want to Enable backports upgrade?';

implementation

{$R *.lfm}

function GetPackageName(x: string): string;
var
  p: string;
begin
  p := x;
  case x of
    'gpk-application': p := 'gnome-packagekit';
    'gpk-prefs': p := 'gnome-packagekit';
    'deja-dup-preferences': p := 'deja-dup';
    'gnome-disks': p := 'gnome-disk-utility';
    'synaptic-pkexec': p := 'synaptic';
  end;
  Result := p;
end;

function GetRealName(x: string): string;
var
  r: string;
begin
  r := x;
  case x of
    'gksu gnome-system-log': r := 'gnome-system-log';
    'gksu ntfs-config': r := 'ntfs-config';
    'gksu bleachbit': r := 'bleachbit';
    'gksu gparted': r := 'gparted';
    'gksu pysdm': r := 'pysdm';
    'gksu ddm': r := 'ddm';
    'gnome-control-center region': r := 'gnome-control-center';
    'gnome-control-center sharing': r := 'gnome-control-center';
    'gnome-control-center user-accounts': r := 'gnome-control-center';
    'gksu "chmod -x /usr/bin/wine32"': r := 'wine32';
    'gksu "chmod +x /usr/bin/wine32"': r := 'wine32';
    'synaptic-pkexec --update-at-startup --upgrade-mode --non-interactive --hide-main-window -o Synaptic::AskRelated=true'
      : r := 'synaptic-pkexec';
    'synaptic-pkexec --update-at-startup --dist-upgrade-mode --non-interactive --hide-main-window -o Synaptic::AskRelated=true'
      : r := 'synaptic-pkexec';
  end;
  Result := r;
end;

procedure exec_process(x: string);
var
  Reply, BoxStyle: integer;
begin
  if FileExists('/usr/bin/' + GetRealName(x)) or FileExists('/bin/' +
    GetRealName(x)) then
  begin
    //Form1.Hide;
    ccexec := TProcess.Create(nil);
    ccexec.CommandLine := x;
    ccexec.Execute;
    ccexec.Options := ccexec.Options + [poWaitOnExit, poUsePipes];
    //Form1.Show;
  end
  else
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(PChar(GetRealName(x) + rsPackageNotFound),
      PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      ccexec := TProcess.Create(nil);
      ccexec.CommandLine := 'x-terminal-emulator -e /usr/share/wahacc/scripts/installer '
        + GetPackageName(GetRealName(x));
      ccexec.Execute;
    end;
  end;
end;


{ TForm1 }

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  FoAbout.Show;
end;

procedure TForm1.BitBtn21Click(Sender: TObject);
begin
  exec_process('hardinfo');
end;

procedure TForm1.BitBtn53Click(Sender: TObject);
begin
  exec_process('baobab');
end;

procedure TForm1.BitBtn55Click(Sender: TObject);
begin
  exec_process('gksu ntfs-config');
end;

procedure TForm1.BitBtn54Click(Sender: TObject);
begin
  exec_process('gnome-disks');
end;

procedure TForm1.BitBtn61Click(Sender: TObject);
begin
  exec_process('gnome-control-center user-accounts');
end;

procedure TForm1.BitBtn62Click(Sender: TObject);
begin
  exec_process('deja-dup-preferences');
end;

procedure TForm1.BitBtn71Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
  r: TStringList;
  p: string;
begin
  if FileExists('/usr/bin/wine32') then
  begin
    Process1.CommandLine := 'stat -c %A /usr/lib/i386-linux-gnu/wine/bin/wine';
    Process1.Execute;
    r := TStringList.Create;
    r.LoadFromStream(Process1.Output);
    p := r.Text[4];
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    if p = 'x' then
    begin
      Reply := Application.MessageBox(PChar(rsWineDisableQ), PChar(rsNotice), BoxStyle);
      if Reply = idYes then
        exec_process('gksu "chmod -x /usr/bin/wine32"');
    end
    else
    begin
      Reply := Application.MessageBox(PChar(rsWineEnableQ), PChar(rsNotice), BoxStyle);
      if Reply = idYes then
        exec_process('gksu "chmod +x /usr/bin/wine32"');
    end;
    r.Free;
  end
  else
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(PChar(rsWineNotinstalled),
      PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      ccexec := TProcess.Create(nil);
      ccexec.CommandLine := 'x-terminal-emulator -e /usr/share/wahacc/scripts/installer '
        + GetPackageName('wine32');
      ccexec.Execute;
    end;
  end;
end;

procedure TForm1.BitBtn72Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
  r: TStringList;
  p: string;
begin
  Process1.CommandLine := 'dpkg --print-architecture';
  Process1.Execute;
  r := TStringList.Create;
  r.LoadFromStream(Process1.Output);
  p := copy(r.Text, 1, 4);
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
      ccexec := TProcess.Create(nil);
      ccexec.CommandLine := 'x-terminal-emulator -e /usr/share/wahacc/scripts/multiarch';
      ccexec.Execute;
    end;
  end;
  r.Free;
end;

procedure TForm1.BitBtn32Click(Sender: TObject);
begin
  exec_process('gnome-control-center sharing');
end;

procedure TForm1.BitBtn14Click(Sender: TObject);
begin
  exec_process(
    'synaptic-pkexec --update-at-startup --dist-upgrade-mode --non-interactive --hide-main-window -o Synaptic::AskRelated=true');
end;

procedure TForm1.BitBtn33Click(Sender: TObject);
begin
  exec_process('vinagre');
end;

procedure TForm1.BitBtn34Click(Sender: TObject);
begin
  exec_process('gnome-control-center sharing');
end;

procedure TForm1.BitBtn35Click(Sender: TObject);
begin
  exec_process('gufw');
end;

procedure TForm1.BitBtn41Click(Sender: TObject);
begin
  exec_process('gnome-tweak-tool');
end;

procedure TForm1.BitBtn42Click(Sender: TObject);
begin
  exec_process('gksu gnome-system-log');
end;

procedure TForm1.BitBtn43Click(Sender: TObject);
begin
  exec_process('font-manager');
end;

procedure TForm1.BitBtn44Click(Sender: TObject);
begin
  exec_process('gnome-control-center region');
end;

procedure TForm1.BitBtn51Click(Sender: TObject);
begin
  exec_process('gnome-disks');
end;

procedure TForm1.BitBtn52Click(Sender: TObject);
begin
  exec_process('gparted-pkexec');
end;

procedure TForm1.BitBtn22Click(Sender: TObject);
begin
  exec_process('gksu ddm');
end;

procedure TForm1.BitBtn23Click(Sender: TObject);
begin
  exec_process('jstest-gtk');
end;

procedure TForm1.BitBtn24Click(Sender: TObject);
begin
  exec_process('system-config-printer');
end;

procedure TForm1.BitBtn11Click(Sender: TObject);
begin
  exec_process('gpk-application');
end;

procedure TForm1.BitBtn12Click(Sender: TObject);
begin
  exec_process(
    'synaptic-pkexec --update-at-startup --upgrade-mode --non-interactive --hide-main-window -o Synaptic::AskRelated=true');
end;

procedure TForm1.BitBtn13Click(Sender: TObject);
begin
  exec_process('gpk-prefs');
end;

procedure TForm1.BitBtn15Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
begin
  BoxStyle := MB_ICONQUESTION + MB_YESNO;
  Reply := Application.MessageBox(PChar(rsBleachbitRoot), PChar(rsNotice), BoxStyle);
  if Reply = idYes then
    exec_process('gksu bleachbit')
  else
    exec_process('bleachbit');
end;

procedure TForm1.BitBtn31Click(Sender: TObject);
begin
  exec_process('nm-connection-editor');
end;

procedure TForm1.BitBtn73Click(Sender: TObject);
var
  f: TextFile;
  Reply, BoxStyle: integer;
begin
  if FileExists('/usr/bin/bicon') then
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
  end
  else
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(PChar(rsBiConNotInstalled),
      PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      ccexec := TProcess.Create(nil);
      ccexec.CommandLine := 'x-terminal-emulator -e /usr/share/wahacc/scripts/installer '
        + GetPackageName('bicon');
      ccexec.Execute;
    end;
  end;
end;

procedure TForm1.BitBtn74Click(Sender: TObject);
var
  Reply, BoxStyle: integer;
begin
  if FileExists('/etc/apt/preferences.d/jessie-backports') then
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(PChar(rsBackportsDisableQ),
      PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      ccexec := TProcess.Create(nil);
      ccexec.CommandLine :=
        'gksu "rm /etc/apt/preferences.d/jessie-backports"';
      ccexec.Execute;
    end;
  end
  else
  begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox(PChar(rsBackportsEnableQ),
      PChar(rsNotice), BoxStyle);
    if Reply = idYes then
    begin
      ccexec := TProcess.Create(nil);
      ccexec.CommandLine :=
        'gksu "x-terminal-emulator -e /usr/share/wahacc/scripts/backports"';
      ccexec.Execute;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i, l, l2, plength: integer;
begin
  // Flip Compenents
  plength := 20;
  if BiDiMode = bdRightToLeft then
  begin
    FlipChildren(True);
    // MainMenu1.ParentBidiMode:=False;
    MainMenu1.BidiMode := bdRightToLeft;
    PageControl1.BiDiMode := bdRightToLeft;
    plength := 40;
  end;
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
  // Translating at start of program
  PODirectory := './languages/';
  GetLanguageIDs(Lang, FallbackLang);
  Translations.TranslateUnitResourceStrings('Unit1', PODirectory +
    'wahacc.%s.po', Lang, FallbackLang);
end;

end.
