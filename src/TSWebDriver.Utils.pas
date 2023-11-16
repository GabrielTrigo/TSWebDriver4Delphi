unit TSWebDriver.Utils;

interface

uses
  Winapi.Windows, System.SysUtils, System.IOUtils, TSWebDriver.Consts,
  System.Classes;

function MakeURL(const ASessionID: string; const APath: TW3C_COMMAND_MAP): string;
function ProccessIsRunning(APartialTitle: string): Boolean;

implementation

function MakeURL(const ASessionID: string; const APath: TW3C_COMMAND_MAP): string;
begin
  Result := BASE_URL + CommandMap.Items[APath];
  if Result.Contains(':sessionId') then
    Result := Result.Replace(':sessionId', ASessionID, [rfIgnoreCase])
end;

function ProccessIsRunning(APartialTitle: string): Boolean;
var
  hWndTemp: HWND;
  iLenText: Integer;
  cTitletemp: array [0..254] of Char;
  sTitleTemp: string;
begin
  hWndTemp := FindWindow(nil, nil);
  while hWndTemp <> 0 do begin
    iLenText := GetWindowText(hWndTemp, cTitletemp, 255);
    sTitleTemp := cTitletemp;
    sTitleTemp := UpperCase(copy( sTitleTemp, 1, iLenText));
    APartialTitle := UpperCase(APartialTitle);
    if Pos(APartialTitle, sTitleTemp ) <> 0 then
      Break;
    hWndTemp := GetWindow(hWndTemp, GW_HWNDNEXT);
  end;
  result := hWndTemp <> 0;
end;

end.
