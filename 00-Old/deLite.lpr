program deLite;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uMain, bigini, uabout,
  uhttpdownloader, unetassets, uStrTools, uTools, versioninfo, utip,
  utipoftheday, uAsk, uSettings, uUserPass, uNewWithWizard, uSolution,
  uEncrypt, uGotoLine, uDEIncludes;

{$R *.res}

var
   frm : TfrmMain;
   fname, verb : String;

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  if ParamCount>1 then
  begin
    frm := TfrmMain.create(application);
    Fname := ParamStr(1);
    Verb := lowercase(ParamStr(2));
    frm.LoadFile(Fname);
    if verb = '/run' then
    begin
         frm.RunFile(Fname);
         application.terminate;
    end;
  end else
  begin
    Application.CreateForm(TfrmMain, frmMain);
    Application.CreateForm(TfrmNewWizard, frmNewWizard);
    Application.CreateForm(TfrmSolution, frmSolution);
    Application.CreateForm(TfrmGotoLine, frmGotoLine);
    Application.Run;
  end;
end.
