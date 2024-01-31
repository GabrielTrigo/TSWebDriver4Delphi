unit TSWebDriver.IElement;

interface

uses
  System.Types, System.JSON, System.Generics.Collections, TSWebDriver.By,
  TSWebDriver.Consts;

type
  ITSWebDriverElement = interface;
  TTSWebDriverElementList = TList<ITSWebDriverElement>;

  ITSWebDriverElement = interface
    ['{EA5EC985-C2AE-47AC-85E9-2833BB815962}']
    function GetTagName: string;
    function GetText: string;
    function GetEnabled: Boolean;
    function GetSelected: Boolean;
    function GetLocation: TPoint;
    function GetSize: TSize;
    function Displayed: Boolean;
    procedure Clear;
    procedure SendKeys(const text: string);
    procedure Submit;
    procedure Click;
    function GetAttribute(const AAttributeName: string): string;
    function GetProperty(const propertyName: string): string;
    function GetDomAttribute(const AAttributeName: string): string;
    function GetCssValue(const propertyName: string): string;
    procedure LoadFromJson(const AJson: string);
    function IsEmpty(): Boolean;
    function FindElement(AValue: TSBy; AW3C_COMMAND_MAP: TW3C_COMMAND_MAP = FIND_ELEMENT): ITSWebDriverElement;
    function FindElements(AValue: TSBy; AW3C_COMMAND_MAP: TW3C_COMMAND_MAP = FIND_ELEMENTS): TTSWebDriverElementList;
  end;

implementation

end.
