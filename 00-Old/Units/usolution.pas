unit uSolution;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ComCtrls, StdCtrls, EditBtn;

type

  { TfrmSolution }

  TfrmSolution = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cboMain: TComboBox;
    chkLoadMain: TCheckBox;
    chkCompress: TCheckBox;
    chkIntRes: TCheckBox;
    feEXEFilename: TFileNameEdit;
    feEXEFilename1: TFileNameEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    ilSolution: TImageList;
    Label1: TLabel;
    nbSolution: TNotebook;
    NetGradient1: TPanel;
    NetGradient2: TPanel;
    NetGradient3: TPanel;
    Page1: TPage;
    Page2: TPage;
    Page3: TPage;
    Panel1: TPanel;
    tvSolutionProperties: TTreeView;
    procedure tvSolutionPropertiesClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSolution: TfrmSolution;

implementation

{$R *.lfm}

{ TfrmSolution }

procedure TfrmSolution.tvSolutionPropertiesClick(Sender: TObject);
begin
  if tvSolutionProperties.selected<> nil then nbSolution.PageIndex := tvSolutionProperties.Selected.StateIndex;
end;

end.

