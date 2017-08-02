unit BidiUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, LCLTranslator, ExtCtrls, Forms;

function GetBidiMode: TBiDiMode;
procedure FlipAnchors(aControl: TControl);
procedure FlipForm(aForm: TForm);
procedure FlipPanelChilds(aPanel: TPanel);


implementation

function GetBidiMode: TBiDiMode;
begin
  case GetDefaultLang of
    // Arabic
    'ar': Result := bdRightToLeft;
    'fa': Result := bdRightToLeft;
    'he': Result := bdRightToLeft;
    else
      Result := bdLeftToRight;
  end;
end;

procedure FlipAnchors(aControl: TControl);
var
  asr, asl: TControl;
  bsr, bsl: TSpacingSize;
begin
  asl := aControl.AnchorSideLeft.Control;
  asr := aControl.AnchorSideRight.Control;
  bsl := aControl.BorderSpacing.Left;
  bsr := aControl.BorderSpacing.Right;
  aControl.AnchorSideLeft.Control := asr;
  aControl.AnchorSideRight.Control := asl;
  aControl.BorderSpacing.Left := bsr;
  aControl.BorderSpacing.Right := bsl;
end;

procedure FlipForm(aForm: TForm);
var
  i: word;
begin
  for i := 0 to aForm.ComponentCount - 1 do
  begin
    if aForm.Components[i] is TControl then
    begin
      TControl(aForm.Components[i]).ParentBiDiMode := False;
      FlipAnchors(TControl(aForm.Components[i]));
    end;
  end;
end;

procedure FlipPanelChilds(aPanel: TPanel);
var
  i, j, k, NoOfCtrls, CtrlsPerLine, NoOfColumns: word;
  CChilds: array of TControl;
begin
  NoOfCtrls := aPanel.ControlCount;
  CtrlsPerLine := aPanel.ChildSizing.ControlsPerLine;
  NoOfColumns := NoOfCtrls div aPanel.ChildSizing.ControlsPerLine;
  k := NoOfCtrls - 1;

  SetLength(CChilds, NoOfCtrls);

  for i := 0 to NoOfCtrls - 1 do
  begin
    CChilds[i] := aPanel.Controls[i];
  end;

  for i := 1 to NoOfColumns do
  begin
    k := k - CtrlsPerLine;
    for j := k + 1 to k + CtrlsPerLine do
    begin
      CChilds[j].Parent := nil;
      CChilds[j].Parent := aPanel;
    end;
  end;
end;

end.
