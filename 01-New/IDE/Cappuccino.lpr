{
        Cappuccino IDE for deLite
        Made to be as professional quality as possible.
        There might not be a lot to the language yet, but there will be in time
        So the idea here is to make this modular, and somewhat future proof.
}

program Cappuccino;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uIDE, frameBrowser, frameEditor, frameSolution,
  frameSolutionProperties, frameSnip, frameRTOutput, frameScriptOutput,
frameToolOutput
  { you can add units after this };

{$R *.res}


begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TfrmIDE, frmIDE);
  Application.Run;
end.

