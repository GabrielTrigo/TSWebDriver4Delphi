unit TSWebDriver.Element;

interface

uses
  TSWebDriver.Request, TSWebDriver.Utils, System.SysUtils, System.Types,
  System.JSON, System.Generics.Collections, TSWebDriver.Consts,
  TSWebDriver.IElement, TSWebDriver.By, TSWebDriver.IBrowser;

type
  TTSWebDriverElement = class(TInterfacedObject, ITSWebDriverElement)
  private
    FElementRef: string;
    FElementID: string;
    FIsEmpty: Boolean;
    [weak]
    FDriver: ITSWebDriverBrowser;
    function GetResourceStream(AResourceName: string): string;
  public
    class function New(const AParentDriver: ITSWebDriverBrowser): TTSWebDriverElement;
    constructor Create(const AParentDriver: ITSWebDriverBrowser); reintroduce;

    function GetTagName: string;
    function GetText: string;
    function GetEnabled: Boolean;
    function GetSelected: Boolean;
    function GetLocation: TPoint;
    function GetSize: TSize;
    function Displayed: Boolean;
    procedure Clear;
    procedure SendKeys(const text: string);
    procedure Submit();
    procedure Click();
    function GetAttribute(const AAttributeName: string): string;
    function GetDomAttribute(const attributeName: string): string;
    function GetProperty(const propertyName: string): string;
    function GetCssValue(const propertyName: string): string;
    procedure LoadFromJson(const AJson: string);
    function IsEmpty(): Boolean;
    function FindElement(AValue: TSBy; AW3C_COMMAND_MAP: TW3C_COMMAND_MAP = FIND_ELEMENT): ITSWebDriverElement;
    function FindElements(AValue: TSBy; AW3C_COMMAND_MAP: TW3C_COMMAND_MAP = FIND_ELEMENTS): TTSWebDriverElementList;
  end;

implementation

uses
  System.Classes;

{$R resources.res }

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

function TTSWebDriverElement.GetProperty(const propertyName: string): string;
var
  lUrl: String;
begin
  lUrl := MakeURL(FDriver.SessionID, GET_ELEMENT_PROPERTY)
    .Replace(':id', FElementID, [rfIgnoreCase])
    .Replace(':propertyName', propertyName, [rfIgnoreCase]);

  Result := FDriver.Execute.Get(lUrl);
end;

function TTSWebDriverElement.GetResourceStream(AResourceName: string): string;
var
  LResourceText: TStringStream;
  LResourceStream: TResourceStream;
begin
  LResourceStream := TResourceStream.Create(HInstance, AResourceName, RT_RCDATA);
  try
    LResourceText := TStringStream.Create;
    try
      LResourceText.LoadFromStream(LResourceStream);
      Result := LResourceText.DataString;
    finally
      FreeAndNil(LResourceText);
    end;
  finally
    FreeAndNil(LResourceStream);
  end;
end;

/// <summary>
/// Obtém o valor de um atributo HTML declarado deste elemento.
/// </summary>
/// <param name="attributeName">O nome do atributo HTML para obter o valor.</param>
/// <returns>O valor atual do atributo HTML. Retorna <see langword="null"/> se o
/// valor não estiver definido ou se o atributo declarado não existir.</returns>
/// <remarks>
/// Ao contrário do método <see cref="GetAttribute(string)"/>, este método
/// retorna apenas atributos declarados na marcação HTML do elemento. Para acessar o valor
/// de uma propriedade IDL do elemento, use o método <see cref="GetAttribute(string)"/>
/// ou o método <see cref="GetDomProperty(string)"/>.
/// </remarks>
function TTSWebDriverElement.GetDomAttribute(const attributeName: string): string;
var
  lUrl: String;
begin
  lUrl := MakeURL(FDriver.SessionID, GET_ELEMENT_ATTRIBUTE)
    .Replace(':id', FElementID, [rfIgnoreCase])
    .Replace(':attributeName', attributeName, [rfIgnoreCase]);

  Result := FDriver.Execute.Get(lUrl);
end;

/// <summary>
/// Obtém o valor do atributo ou propriedade especificado para este elemento.
/// </summary>
/// <param name="attributeName">O nome do atributo ou propriedade.</param>
/// <returns>O valor atual do atributo ou propriedade. Retorna <see langword="null"/>
/// se o valor não estiver definido.</returns>
/// <remarks>O método <see cref="GetAttribute"/> retornará o valor atual
/// do atributo ou propriedade, mesmo que o valor tenha sido modificado após o carregamento
/// da página. Observe que o valor dos seguintes atributos será retornado
/// mesmo se não houver um atributo explícito no elemento:
/// <list type="table">
/// <listheader>
/// <term>Nome do Atributo</term>
/// <term>Valor retornado se não especificado explicitamente</term>
/// <term>Tipos válidos de elementos</term>
/// </listheader>
/// <item>
/// <description>checked</description>
/// <description>checked</description>
/// <description>Caixa de seleção (Check Box)</description>
/// </item>
/// <item>
/// <description>selected</description>
/// <description>selected</description>
/// <description>Opções em elementos Select</description>
/// </item>
/// <item>
/// <description>disabled</description>
/// <description>disabled</description>
/// <description>Entrada e outros elementos de interface do usuário (UI)</description>
/// </item>
/// </list>
/// O método verifica tanto os atributos declarados na marcação HTML da página quanto
/// as propriedades do elemento ao acessar as propriedades do elemento
/// via JavaScript.
/// </remarks>
function TTSWebDriverElement.GetAttribute(const AAttributeName: string): string;
var
  LJSResource: string;
begin
  LJSResource :=
    EscapeJavaScriptString(
      GetResourceStream('get_attribute_js')
    );

  Result := FDriver.ExecuteSyncScript(
    Format('return (%s).apply(null, arguments);', [LJSResource]),
    '{}',
    Format('[{"%s": "%s"}, "%s"]', [FElementRef, FElementID, AAttributeName])
  );
end;

function TTSWebDriverElement.Displayed: Boolean;
var
  LJSResource: string;
begin
  LJSResource :=
    EscapeJavaScriptString(
      GetResourceStream('is_displayed_js')
    );

  Result := FDriver.ExecuteSyncScript(
    Format('return (%s).apply(null, arguments);', [LJSResource]),
    '{}',
    Format('[{"%s": "%s"}]', [FElementRef, FElementID])
  ).Contains('true');
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
      FElementID  := lJSONObject.Pairs[0].JsonValue.Value;
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
  raise ENotImplemented.Create('Not implemented');
end;

function TTSWebDriverElement.GetLocation: TPoint;
begin
  raise ENotImplemented.Create('Not implemented');
end;

procedure TTSWebDriverElement.Clear;
begin
  raise ENotImplemented.Create('Not implemented');
end;

function TTSWebDriverElement.GetSize: TSize;
begin
  raise ENotImplemented.Create('Not implemented');
end;

end.
