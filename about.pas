unit About;

{$mode objfpc}{$H+}

interface

uses
  Classes, Forms, Graphics, ComCtrls, StdCtrls, lclintf, ExtCtrls, LCLTranslator,
  DefaultTranslator;

type

  { TfrmAbout }

  TfrmAbout = class(TForm)
    Image1: TImage;
    Image2: TImage;
    lblSoftName: TLabel;
    lblSoftName2: TLabel;
    lblSoftVersion: TLabel;
    lblBasmala: TLabel;
    lblSoftDiscription: TLabel;
    lblAuthorCopyright: TLabel;
    lblNoWarranty: TLabel;
    lblLicense1: TLabel;
    lblLicense2: TLabel;
    lblLicense3: TLabel;
    meCredits: TMemo;
    meLicense: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure lblLicense2Click(Sender: TObject);
    procedure lblLicense2MouseEnter(Sender: TObject);
    procedure lblLicense2MouseLeave(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses Main, BidiUtils;

{$R *.lfm}

{ TfrmAbout }

procedure TfrmAbout.lblLicense2Click(Sender: TObject);
begin
  OpenURL('http://ojuba.org/waqf-2.0/رخصة_وقف_العامة');
end;

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  lblSoftVersion.Caption := AppVersion;
  BiDiMode := GetBiDiMode;
  if BiDiMode = bdRightToLeft then
  begin
    FlipForm(Self);
    doFlipChildren;
    PageControl1.FlipChildren(True);
    Self.Font.Name := 'Noto Kufi Arabic';
  end;
end;

procedure TfrmAbout.lblLicense2MouseEnter(Sender: TObject);
begin
  lblLicense2.Font.Color := TColor($D87639);
end;

procedure TfrmAbout.lblLicense2MouseLeave(Sender: TObject);
begin
  lblLicense2.Font.Color := TColor($F39621);
end;

end.
