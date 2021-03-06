unit uProperties;

{$mode objfpc}{$H+}

interface

uses
  Classes, windows, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Spin, uDesign, uMain;

type

  { TfrmProperties }

  TfrmProperties = class(TForm)
    cboAlign: TComboBox;
    GroupBox7: TGroupBox;
    txtName: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    lblSel: TLabel;
    seTop: TSpinEdit;
    seLeft: TSpinEdit;
    seWidth: TSpinEdit;
    seHeight: TSpinEdit;
    procedure cboAlignChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure seTopChange(Sender: TObject);
    procedure txtNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
  private
    { private declarations }
  public
    { public declarations }

    CanChange : Boolean;
  end;

var
  frmProperties: TfrmProperties;

implementation

{$R *.lfm}

{ TfrmProperties }

procedure TfrmProperties.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caNone;
end;

procedure TfrmProperties.cboAlignChange(Sender: TObject);
begin
  if CanChange then
  begin
     if frmDesign.Selected<>nil then
     begin
        with FrmDesign.selected as TWinControl do
        begin
          if cboAlign.ItemIndex = 0 then Align := alTop
          else if cboAlign.ItemIndex = 1 then Align := alBottom
          else if cboAlign.ItemIndex = 2 then Align := alLeft
          else if cboAlign.ItemIndex = 3 then Align := alRight
          else if cboAlign.ItemIndex = 4 then Align := alClient
          else Align := alNone;
        end;
     end;
  end;
end;

procedure TfrmProperties.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := false;
end;

procedure TfrmProperties.seTopChange(Sender: TObject);
begin
  if CanChange then
  begin
     if frmDesign.Selected<>nil then TWinControl(frmDesign.Selected).SetBounds(seTop.VAlue, seLeft.Value, seWidth.value, seHeight.value)
     else frmDesign.SetBounds(seTop.VAlue, seLeft.Value, seWidth.value, seHeight.value);
     frmMain.SetProperties(frmDesign.Selected);
  end;
end;

procedure TfrmProperties.txtNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if frmDesign.selected=nil then exit;
  if key=VK_RETURN then
  begin
     if CanChange then
     begin
        TWinControl(frmDesign.Selected).name := txtName.text;
        frmMain.SetProperties(frmDesign.Selected);
     end;
  end;
end;

end.

