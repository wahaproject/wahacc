unit about;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, lclintf, Buttons;

type

  { TFoAbout }

  TFoAbout = class(TForm)
    Label1: TLabel;
    LaVersion: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    PageControl1: TPageControl;
    SpeedButton1: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FoAbout: TFoAbout;

implementation
uses Unit1;
{$R *.lfm}

{ TFoAbout }

procedure TFoAbout.PageControl1Change(Sender: TObject);
begin

end;

procedure TFoAbout.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TFoAbout.Label4Click(Sender: TObject);
begin
  OpenURL('http://ojuba.org/wiki/waqf/license');
end;

procedure TFoAbout.FormCreate(Sender: TObject);
begin
  if BiDiMode = bdRightToLeft then
  begin
     FlipChildren(True);
  end;
  LaVersion.Caption:= TabSheet1.Caption+' '+version;
end;

end.

