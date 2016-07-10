unit frameToolOutput;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ComCtrls, Dialogs;

type

  { TframeToolOutput }

  TframeToolOutput = class(TFrame)
    btnClearLog: TToolButton;
    dlgSaveTool: TSaveDialog;
    ilToolOutput: TImageList;
    memLog: TMemo;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure btnClearLogClick(Sender: TObject);
    procedure memLogChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    FFilename : String;
    procedure LoadFromFile(const fname : String);
    procedure SaveToFile(const fname : String);
    procedure CopyToClipboard;
    procedure AddLine(const str : String);
  end;

implementation

{$R *.lfm}

{ TframeToolOutput }

procedure TframeToolOutput.btnClearLogClick(Sender: TObject);
begin
  memLog.lines.clear;
end;

procedure TframeToolOutput.AddLine(const str : String);
begin
  memLog.lines.add(str);
  memLogChange(self);
end;

procedure TframeToolOutput.memLogChange(Sender: TObject);
var
  pnt : TPoint;
begin
  pnt.x := 0;
  pnt.y := memLog.Lines.count-1;
  memLog.CaretPos := pnt;
  memLog.Repaint;
end;

procedure TframeToolOutput.LoadFromFile(const fname : String);
begin
     memLog.Lines.LoadFromFile(Fname);
     FFilename := Fname;
end;

procedure TframeToolOutput.SaveToFile(const fname : String);
begin
     memLog.Lines.SaveToFile(Fname);
     FFilename := Fname;
end;

procedure TframeToolOutput.CopyToClipboard;
begin
     memLog.CopyToClipboard;
end;




end.

