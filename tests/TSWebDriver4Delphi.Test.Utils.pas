unit TSWebDriver4Delphi.Test.Utils;

interface

uses
  System.SysUtils, System.IOUtils;

function MakeUrlFile(AFileName: string): string;

implementation

function MakeUrlFile(
  AFileName: string): string;
begin
  Result := Format('file:///%s', [
    StringReplace(Tpath.GetFullPath('..\mocks\' + AFileName), '\', '/', [rfReplaceAll])
  ]);
end;

end.
