unit TSWebDriver.Element;

interface

uses
  TSWebDriver.Request, TSWebDriver.Utils, System.SysUtils,
  TSWebDriver.Consts, TSWebDriver.IElement, System.Types, System.JSON,
  TSWebDriver.By, TSWebDriver.IBrowser;

type
  TTSWebDriverElement = class(TInterfacedObject, ITSWebDriverElement)
  private
    FElementRef: string;
    FElementID: string;
    FIsEmpty: Boolean;
    [weak]
    FDriver: ITSWebDriverBrowser;
  public
    class function New(const AParentDriver: ITSWebDriverBrowser): TTSWebDriverElement;
    constructor Create(const AParentDriver: ITSWebDriverBrowser); reintroduce;

    function GetTagName: string;
    function GetText: string;
    function GetEnabled: Boolean;
    function GetSelected: Boolean;
    function GetLocation: TPoint;
    function GetSize: TSize;
    function GetDisplayed: Boolean;
    procedure Clear;
    procedure SendKeys(const text: string);
    procedure Submit();
    procedure Click();
    function GetAttribute(const attributeName: string): string;
    function GetDomAttribute(const attributeName: string): string;
    function GetProperty(const propertyName: string): string;
    function GetCssValue(const propertyName: string): string;
    procedure LoadFromJson(const AJson: string);
    function IsEmpty(): Boolean;
    function FindElement(AValue: TSBy; AW3C_COMMAND_MAP: TW3C_COMMAND_MAP = FIND_ELEMENT): ITSWebDriverElement;
    function FindElements(AValue: TSBy; AW3C_COMMAND_MAP: TW3C_COMMAND_MAP = FIND_ELEMENTS): TTSWebDriverElementList;
  end;

implementation

{ TTSWebDriverElement }

class function TTSWebDriverElement.New(const AParentDriver: ITSWebDriverBrowser): TTSWebDriverElement;
begin
  Result := Self.Create(AParentDriver);
end;

constructor TTSWebDriverElement.Create(const AParentDriver: ITSWebDriverBrowser);
begin
  FIsEmpty := False;
  FDriver := AParentDriver;
end;

function TTSWebDriverElement.FindElement(AValue: TSBy; AW3C_COMMAND_MAP: TW3C_COMMAND_MAP = FIND_ELEMENT): ITSWebDriverElement;
begin
  Result := FDriver.FindElement(AValue, FElementID);
end;

function TTSWebDriverElement.FindElements(AValue: TSBy; AW3C_COMMAND_MAP: TW3C_COMMAND_MAP = FIND_ELEMENTS): TTSWebDriverElementList;
begin
  Result := FDriver.FindElements(AValue, FElementID);
end;

procedure TTSWebDriverElement.Click();
begin
  FDriver.Execute.Post(
      MakeURL(FDriver.SessionID, CLICK_ELEMENT).Replace(':id', FElementID, [rfIgnoreCase]), '{}');
end;

function TTSWebDriverElement.GetDomAttribute(const attributeName: string): string;
var
  lUrl: String;
begin
  lUrl := MakeURL(FDriver.SessionID, GET_ELEMENT_ATTRIBUTE)
    .Replace(':id', FElementID, [rfIgnoreCase])
    .Replace(':attributeName', attributeName, [rfIgnoreCase]);

  Result := FDriver.Execute.Get(lUrl);
end;

function TTSWebDriverElement.GetProperty(const propertyName: string): string;
var
  lUrl: String;
begin
  lUrl := MakeURL(FDriver.SessionID, GET_ELEMENT_PROPERTY)
    .Replace(':id', FElementID, [rfIgnoreCase])
    .Replace(':propertyName', propertyName, [rfIgnoreCase]);

  Result := FDriver.Execute.Get(lUrl);
end;

function TTSWebDriverElement.GetAttribute(const attributeName: string): string;
var
  lResource: string;
begin
  lResource := LoadCustomResource('get_attribute');

  if lResource.IsEmpty then
  begin
    raise Exception.Create('Resource not found');
    Exit;
  end;

  Result := FDriver.ExecuteSyncScript(lResource, '{}',
    Format('[{"%s": "%s"}, "%s"]', [FElementRef, FElementID, attributeName]));
end;

function TTSWebDriverElement.GetCssValue(const propertyName: string): string;
var
  lUrl: String;
begin
  lUrl := MakeURL(FDriver.SessionID, GET_ELEMENT_VALUE_OF_CSS_PROPERTY)
    .Replace(':id', FElementID, [rfIgnoreCase])
    .Replace(':propertyName', propertyName, [rfIgnoreCase]);

  Result := FDriver.Execute.Get(lUrl);
end;

function TTSWebDriverElement.GetDisplayed: Boolean;
var
  lResource: string;
begin
  lResource := LoadCustomResource('is_displayed');

  if lResource.IsEmpty then
  begin
    raise Exception.Create('Resource not found');
    Exit;
  end;

  Result := FDriver.ExecuteSyncScript(lResource, '{}',
    Format('[{"%s": "%s"}]', [FElementRef, FElementID])).StartsWith('true', True);
end;

function TTSWebDriverElement.GetEnabled: Boolean;
var
  lUrl: String;
begin
  lUrl := MakeURL(FDriver.SessionID, IS_ELEMENT_ENABLED)
    .Replace(':id', FElementID, [rfIgnoreCase]);

  Result := FDriver.Execute.Get(lUrl).StartsWith('true', True);
end;

function TTSWebDriverElement.GetSelected: Boolean;
begin
  Result := False;
end;

function TTSWebDriverElement.GetTagName: string;
var
  lUrl: String;
begin
  lUrl := MakeURL(FDriver.SessionID, GET_ELEMENT_TAG_NAME)
    .Replace(':id', FElementID, [rfIgnoreCase]);

  Result := FDriver.Execute.Get(lUrl);
end;

function TTSWebDriverElement.GetText: string;
var
  lUrl: String;
begin
  lUrl := MakeURL(FDriver.SessionID, GET_ELEMENT_TEXT)
    .Replace(':id', FElementID, [rfIgnoreCase]);

  Result := FDriver.Execute.Get(lUrl);
end;

function TTSWebDriverElement.IsEmpty: Boolean;
begin
  Result := FIsEmpty;
end;

procedure TTSWebDriverElement.LoadFromJson(const AJson: string);
var
  lJSONObject: TJSONObject;
begin
  try
    try
      lJSONObject := (TJSONObject.ParseJSONValue(AJson) as TJSONObject);
      if (lJSONObject.Count <= 0) then
      begin
         FIsEmpty := True;
         Exit;
      end;

      FElementRef := lJSONObject.Pairs[0].JsonString.Value;
      FElementID := lJSONObject.Pairs[0].JsonValue.Value;
    finally
      FreeAndNil(lJSONObject);
    end;
  except
    FIsEmpty := True;
  end;

  //Key: AJson.Pairs[0].JsonString.Value
  //Value: AJson.Pairs[0].JsonValue.Value
end;

procedure TTSWebDriverElement.SendKeys(const text: string);
begin
  FDriver.Execute.Post(
    MakeURL(FDriver.SessionID, SEND_KEYS_TO_ELEMENT).Replace(':id', FElementID, [rfIgnoreCase]),
    Format('{"text": "%s"}', [text]));
end;

procedure TTSWebDriverElement.Submit;
begin
  raise Exception.Create('Not implemented');
end;

function TTSWebDriverElement.GetLocation: TPoint;
begin
  raise Exception.Create('Not implemented');
end;

procedure TTSWebDriverElement.Clear;
begin
  raise Exception.Create('Not implemented');
end;

function TTSWebDriverElement.GetSize: TSize;
begin
  raise Exception.Create('Not implemented');
end;

end.
