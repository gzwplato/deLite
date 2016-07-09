unit uArchiveFormat;


{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, laz2_XMLRead,
  laz2_DOM, laz2_XMLWrite, base64, zstream, UStrTools;



type
         TXMLArchive = class(TObject)
         private
         protected
                  // Protected HERE
            XMLDoc : TXMLDocument;
            DocNode : TDOMNode;
            FFilename : String;
         Public
             // Published HERE
            procedure Create;
            function LoadArchive(Const Filename : String) : Boolean;
            function SaveArchive(Const Filename : String) : Boolean;
            function AddFile(Const Filename : String) : Boolean;
            function DeleteFile(Const Filename : String) : Boolean;
            function ExtractFile(Const Filename, OutputDir : String) : Boolean;
            procedure Free;
         end;


implementation


function MemoryStreamAsString(vms: TMemoryStream): string;
begin { MemoryStreamAsString }
        SetString(Result, vms.Memory, vms.Size);
end; { MemoryStreamAsString }


PROCEDURE LF_DecodeNode(vDOMNode: tDOMNode; lMemoryStream : TMemoryStream);
  VAR
    lFileName            : tFileName;
    lEncBuff,
    lBuff                : String;

BEGIN { LF_DecodeNode }
  if vDOMNode.HasChildNodes then
  begin
       lEncBuff := vDOMNode.ChildNodes.Item[0].NodeValue;
       if lEncBuff<>'' then  lBuff := DecodeStringBase64(lEncBuff);
       lMemoryStream.Clear;
       lMemoryStream.Write(Pointer(lBuff)^, Length(lBuff));
       lMemoryStream.Position := 0;
  end;
END; { LF_DecodeNode }


procedure TXMLArchive.Create;
begin
  XMLDoc := TXMLDocument.create;
  DocNode := XMLDoc.CreateElement('Archive');
  XMLDoc.appendChild(DocNode);
  DocNode := XMLDoc.DocumentElement;
end;

procedure TXMLArchive.Free;
begin
     XMLDoc := nil;
     DocNode := nil;
end;

function TXMLArchive.LoadArchive(Const Filename : String) : Boolean;
var
  strm : TFileSTream;
  strm2 : TMemoryStream;
  Outs: TStringList;
  comp: Tdecompressionstream;
  mem: TMemoryStream;
begin
  FFilename := '';
  XMLDoc := TXMLDocument.Create;
  DocNode := XMLDoc.CreateElement('Archive');
  XMLDoc.AppendChild(DocNode);
  DocNode := XMLDoc.DocumentElement;

  // Load into stream
  // Decompress and then Load Into XML
  FFilename := Filename;
  strm := TFileStream.Create(FFilename, fmOpenRead);
  strm.position := 0;
  try
    comp := Tdecompressionstream.Create(Strm);
    try
      Outs := TStringList.Create;
      try
        outS.LoadFromStream(comp);
        mem := TMemoryStream.Create;
        try
          outS.SaveToStream(mem);
          mem.position := 0;
          ReadXMLFile(XMLDoc, mem);
        finally
          mem.Free;
        end;
      finally
        outs.Free;
      end;
    finally
      comp.Free;
    end;
  finally
    strm.Free;
  end;
  //     ReadXMLFile(FXMLDoc, FFilename);
  DocNode := XMLDoc.DocumentElement;

end;

function TXMLArchive.SaveArchive(Const Filename : String) : Boolean;
var
  strm : TMemoryStream;
  strm2 : TMemoryStream;
  Outs: TFileStream;
  comp: Tcompressionstream;
  mem: TMemoryStream;
begin
  strm := TMemoryStream.Create;
  try
    WriteXML(XMLDoc, strm);
    strm.position := 0;
    if FileExists(Filename) then
      DeleteFile(Filename);
    outs := TFileStream.Create(Filename, fmCreate);
    try
      comp := Tcompressionstream.Create(clmax, outs, False);
      try
        comp.CopyFrom(strm, strm.Size);
        comp.flush;
      finally
        comp.Free;
      end;
    finally
      outs.Free;
    end;
  finally
    strm.Free;
  end;
end;

function TXMLArchive.AddFile(Const Filename : String) : Boolean;
var
  FileCount : Integer;
  hNode, ohNode : TDomNode;
  fle, fltCTD : TDomNode;
  fleStrm : TFileStream;
  mem : TMemoryStream;
  str : String;
begin
     ohNode := DocNode.FindNode('Header');
     if ohNode<>nil then
     begin
          FileCount := StrToInt(ohNode.Attributes.GetNamedItem('FileHigh').NodeValue) + 1;
     end else FileCount := 1;
     fle := XMLDoc.CreateElement('File' + IntToStr(FileCount));
     fleStrm := TFileStream.create(Filename, fmOpenRead);
     try
        fleStrm.position := 0;
        mem := TMemoryStream.create;
        try
           mem.CopyFrom(FleStrm, sizeOf(FleStrm));
           mem.Position:=0;
           str := MemoryStreamAsString(mem);
           str := EncodeStringBase64(str);
           fltCTD := XMLDoc.CreateCDATASection(str);
           TDomElement(hNode).SetAttribute('Filename', URLEncode(ExtractFilename(Filename), true));
           TDomElement(hNode).SetAttribute('Path', URLEncode(ExtractFilePath(Filename), true));
           fle.AppendChild(fltCTD);
           DocNode.AppendChild(fle);
        finally
          mem.free;
        end;
     finally
       fleStrm.free;
     end;
     hNode := XMLDoc.CreateElement('Header');
     TDomElement(hNode).SetAttribute('FileHigh', IntToStr(FileCount));
     if ohNode<>nil then DocNode.ReplaceChild(hNode, ohNode)
     else DocNode.AppendChild(hNode);
end;

function TXMLArchive.DeleteFile(Const Filename : String) : Boolean;
begin

end;

function TXMLArchive.ExtractFile(Const Filename, OutputDir : String) : Boolean;
begin

end;



end.

