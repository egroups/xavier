{
  MIT License

  Copyright (c) 2017 Marcos Douglas B. Santos

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
}
unit Xavier.XML.Clss;

{$include xavier.inc}

interface

uses
  Classes, SysUtils,
  James.Data,
  James.Data.Clss,
  Xavier.XML,
  {$ifdef FPC}
    Xavier.XML.FPC
  {$else}
    Xavier.XML.Delphi
  {$endif}
  ;

type
  TXMLAttribute = TCAttribute;
  TXMLAttributeAlias = TXMLAttribute;

  TXMLAttributes = TCAttributes;
  TXMLAttributesAlias = TXMLAttributes;

  TXMLNode = TCNode;
  TXMLNodeAlias = TXMLNode;

  TXMLNodes = TCNodes;
  TXMLNodesAlias = TXMLNodes;

  TXMLChilds = TCChilds;
  TXMLChildsAlias = TXMLChilds;

  TXMLPack = class(TCPack)
  public
    class function New(AStream: IDataStream): IXMLPack; overload;
    class function New(const ARootName: TXMLString): IXMLPack; overload;
  end;
  TXMLPackAlias = TXMLPack;

implementation

{ TXMLPack }

class function TXMLPack.New(AStream: IDataStream): IXMLPack;
var
  Buf: TMemoryStream;
begin
  Buf := TMemoryStream.Create;
  try
    AStream.Save(Buf);
    Result := Create(Buf);
  finally
    Buf.Free;
  end;
end;

class function TXMLPack.New(const ARootName: TXMLString): IXMLPack;
begin
  Result := New(
    TDataStream.New(
      Format(
        '<?xml version="1.0" encoding="UTF-8"?><%s />', [ARootName]
      )
    )
  );
end;

end.
