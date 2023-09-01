unit TSWebDriver.Browser;
interface

uses
  System.SysUtils, System.JSON, System.IOUtils, System.StrUtils, System.Classes,
  Winapi.Windows, TSWebDriver.Request, TSWebDriver.Consts,
  TSWebDriver.Interfaces, TSWebDriver.Utils, TSWebDriver.Element,
  TSWebDriver.IElement, System.Generics.Collections, TSWebDriver.By,
  TSWebDriver.IBrowser;

type
  TTSWebDriverBrowserBase = class(TInterfacedObject, ITSWebDriverBrowser)
  private
    FSessionID: string;
    FDriverArguments: TStrings;
    function HandleCustomArgs: string;
  public
    class function New(): ITSWebDriverBrowser;
    constructor Create();
    destructor Destroy(); override;
    function Execute(): ITSWebDriverRequest;
    function NewSession(): ITSWebDriverBrowser;
    function CloseSession(): ITSWebDriverBrowser;
    function NavigateTo(AUrl: string): ITSWebDriverBrowser;
    function ExecuteSyncScript(AScript: string; AParameters: string = '{}'; AArgs: string = '[]'): string;
    function ExecuteAsyncScript(AScript: string; AParameters: string = '{}'; AArgs: string = '[]'): string;
    function SessionID(): string; overload;
    function SessionID(AValue: string): ITSWebDriverBrowser; overload;
    function FindElement(AValue: TSBy; AElementId: string = ''): ITSWebDriverElement;
    function FindElements(AValue: TSBy; AElementId: string = ''): TTSWebDriverElementList;
    function TakeScreenshot(): string;
    function Status(): Boolean;
    function AddArgument(AValue: string): ITSWebDriverBrowser;
    function WaitForSelector(AValue: string; ATimeout: Integer = 15000): ITSWebDriverBrowser;
    procedure WaitForPageReady(ATimeout: Integer = 15000);
    function GetPageSource(): String;

    procedure Refresh();
    procedure &Forward();
    procedure Back();
    function PrintPage(): string;
    function GetTitle(): string;
    function GetCurrentUrl(): string;
  end;

implementation

{ TTSWebDriverBrowserBase }

class function TTSWebDriverBrowserBase.New(): ITSWebDriverBrowser;
begin
  Result := Self.Create();
end;

constructor TTSWebDriverBrowserBase.Create();
begin
  FDriverArguments := TStringList.Create('"', ',');
end;

destructor TTSWebDriverBrowserBase.Destroy();
begin
  Self.CloseSession();

  if Assigned(FDriverArguments) then
    FreeAndNil(FDriverArguments);

  inherited;
end;

function TTSWebDriverBrowserBase.AddArgument(AValue: string): ITSWebDriverBrowser;
begin
  FDriverArguments.Add(AValue);
  Result := Self;
end;

procedure TTSWebDriverBrowserBase.Back();
begin
  Execute.Post(MakeURL(FSessionID, GO_BACK));
end;

function TTSWebDriverBrowserBase.CloseSession(): ITSWebDriverBrowser;
begin
  Result := Self;
  if FSessionID.IsEmpty then Exit;
  Execute.Delete(MakeURL(FSessionID, QUIT));
  FSessionID := EmptyStr;
end;

function TTSWebDriverBrowserBase.ExecuteSyncScript(AScript: string; AParameters: string = '{}'; AArgs: string = '[]'): string;
begin
  Result := EmptyStr;

  Result := Execute.Post(MakeURL(FSessionID, EXECUTE_SCRIPT),
    Format('{"script":"%s","parameters":%s,"args":%s}', [AScript, AParameters, AArgs]));
end;

function TTSWebDriverBrowserBase.Execute: ITSWebDriverRequest;
begin
  Result := TTSWebDriverRequest.New();
end;

function TTSWebDriverBrowserBase.ExecuteAsyncScript(AScript: string; AParameters: string = '{}'; AArgs: string = '[]'): string;
begin
  Result := EmptyStr;

  Result := Execute.Post(MakeURL(FSessionID, EXECUTE_ASYNC_SCRIPT),
    Format('{"script":"%s","parameters":%s,"args":%s}', [AScript, AParameters, AArgs]));
end;

function TTSWebDriverBrowserBase.TakeScreenshot: string;
begin
  Result := Execute.Get(MakeURL(FSessionID, SCREENSHOT));
end;

function TTSWebDriverBrowserBase.FindElement(AValue: TSBy; AElementId: string = ''): ITSWebDriverElement;
var
  lResponseData: string;
  lUrl: string;
begin
  Result := TTSWebDriverElement.New(Self);

  if AElementId.IsEmpty then
    lUrl := MakeURL(FSessionID, FIND_ELEMENT)
  else
    lUrl := MakeURL(FSessionID, FIND_CHILD_ELEMENT).Replace(':id', AElementId);

  lResponseData := Execute.Post(lUrl,
    Format('{"using":"%s","value":"%s"}', [AValue.UsingName, AValue.KeyName]));

  if lResponseData <> EmptyStr then
    Result.LoadFromJson(lResponseData);
end;

function TTSWebDriverBrowserBase.FindElements(AValue: TSBy; AElementId: string = ''): TTSWebDriverElementList;
var
  lResponseData: string;
  lUrl: string;
  lJsonValue: TJSONValue;
  lJsonArray: TJSONArray;
  lTSWebDriverElement: ITSWebDriverElement;
begin
  Result := TTSWebDriverElementList.Create([]);
  try
    if AElementId.IsEmpty then
      lUrl := MakeURL(FSessionID, FIND_ELEMENTS)
    else
      lUrl := MakeURL(FSessionID, FIND_CHILD_ELEMENTS).Replace(':id', AElementId);

    lResponseData := Execute.Post(lUrl,
      Format('{"using":"%s","value":"%s"}', [AValue.UsingName, AValue.KeyName]));

    if lResponseData = EmptyStr then Exit;

    lJsonArray := TJSONObject.ParseJSONValue(lResponseData).AsType<TJSONArray>;

    for lJsonValue in lJsonArray do
    begin
      lTSWebDriverElement := TTSWebDriverElement.New(Self);
      lTSWebDriverElement.LoadFromJson(lJsonValue.ToJSON());
      Result.Add(lTSWebDriverElement);
    end;

  finally
    FreeAndNil(lJsonArray);
  end;
end;

procedure TTSWebDriverBrowserBase.&Forward();
begin
  Execute.Post(MakeURL(FSessionID, GO_FORWARD));
end;

function TTSWebDriverBrowserBase.GetCurrentUrl: string;
begin
  Result := Execute.Get(MakeURL(FSessionID, GET_CURRENT_URL));
end;

function TTSWebDriverBrowserBase.GetPageSource(): String;
begin
  Result := Execute.Get(MakeURL(FSessionID, GET_PAGE_SOURCE));
end;

function TTSWebDriverBrowserBase.GetTitle(): string;
begin
  Result := Execute.Get(MakeURL(FSessionID, GET_TITLE));
end;

function TTSWebDriverBrowserBase.NavigateTo(AUrl: string): ITSWebDriverBrowser;
begin
  Execute.Post(MakeURL(FSessionID, GET_URL),
    Format('{"url": "%s"}', [AUrl]));
  Result := Self;
end;

function TTSWebDriverBrowserBase.NewSession(): ITSWebDriverBrowser;
var
  lData: string;
  lResponseData: string;
begin
  //add extra args
  lData := StringReplace(NEW_SESSION_JSON, '@extra_args', HandleCustomArgs(), [rfReplaceAll, rfIgnoreCase]);

  lResponseData :=
    Execute.Post(MakeURL(FSessionID, NEW_SESSION), lData);

  with TJSONObject.ParseJSONValue(lResponseData) do
  begin
    try
      if not TryGetValue<string>('sessionId', FSessionID) then
        raise Exception.Create('sessionId not found');
    finally
      Destroy();
    end;
  end;

  Result := Self;
end;

function TTSWebDriverBrowserBase.PrintPage(): string;
begin
  Result := Execute.Post(MakeURL(FSessionID, PRINT_PAGE));
end;

procedure TTSWebDriverBrowserBase.Refresh;
begin
  Execute.Post(MakeURL(FSessionID, TW3C_COMMAND_MAP.REFRESH));
end;

function TTSWebDriverBrowserBase.HandleCustomArgs(): string;
var
  lArgument: string;
begin
  Result := EmptyStr;

  if FDriverArguments.Count <= 0 then Exit;

  for lArgument in FDriverArguments do
    Result := Result + ', ' + AnsiQuotedStr(lArgument, '"');
end;

function TTSWebDriverBrowserBase.SessionID(AValue: string): ITSWebDriverBrowser;
begin
  FSessionID := AValue;
  Result := Self;
end;

function TTSWebDriverBrowserBase.Status(): Boolean;
var
  lResponseData: string;
begin
  try
    try
      lResponseData := Execute.Get(MakeURL(FSessionID, GET_SERVER_STATUS));
    finally
      Result := Pos('"ready":true', lResponseData) > 0;
    end;
  except
    Result := False;
  end;
end;

function TTSWebDriverBrowserBase.SessionID(): string;
begin
  Result := FSessionID;
end;

function TTSWebDriverBrowserBase.WaitForSelector(AValue: string; ATimeout: Integer = 15000): ITSWebDriverBrowser;
var
  I: Integer;
  isMainThread: Boolean;
  j: Integer;
begin
  isMainThread := (GetCurrentThreadId = MainThreadId);
  I := 0;
  while (I < ATimeout) do
  begin
    for j := 1 to 100 do
    begin
      Sleep(10);
      if isMainThread then
        CheckSynchronize(0);
    end;
    Inc(I, 1000);
    if Self.ExecuteSyncScript(Format('return document.querySelector(''%s'')', [AValue])) <> 'null' then
      break;
  end;
end;

procedure TTSWebDriverBrowserBase.WaitForPageReady(ATimeout: Integer = 15000);
var
  I: Integer;
  isMainThread: Boolean;
  j: Integer;
begin
  isMainThread := (GetCurrentThreadId = MainThreadId);
  I := 0;
  while (I < ATimeout) do
  begin
    for j := 1 to 100 do
    begin
      sleep(10);
      if isMainThread then
        CheckSynchronize(0);
    end;
    Inc(I, 1000);
    if Self.ExecuteSyncScript('return document.readyState') = 'complete' then
      break;
  end;
end;

end.
