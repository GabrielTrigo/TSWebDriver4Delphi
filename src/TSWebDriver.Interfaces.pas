unit TSWebDriver.Interfaces;

interface

uses
  System.JSON, System.SysUtils, TSWebDriver.Element, TSWebDriver.IElement,
  TSWebDriver.By, System.Generics.Collections, TSWebDriver.IBrowser;

{$M+}

type
  ITSWebDriverBaseOptions = interface;
  ITSWebDriverBrowsers = interface;

  ITSWebDriverBase = interface
    ['{9F8EDEBB-3838-4DBC-A743-E2E49A62C842}']
    function Start(): ITSWebDriverBase;
    function Stop(): ITSWebDriverBase;
    function IsRunning(): Boolean;
    function Options(): ITSWebDriverBaseOptions;
    function Browser(): ITSWebDriverBrowsers;
  end;

  ITSWebDriverBaseOptions = interface
    ['{A5972545-D66E-4311-A79F-5D756791057F}']
    function DriverPath(AValue: String): ITSWebDriverBaseOptions; overload;
    function DriverPath(): String; overload;
    function AddArgument(AValue: String): ITSWebDriverBaseOptions;
    function &End(): ITSWebDriverBase;
  end;

  ITSWebDriver = interface
    ['{F78C7681-FCAC-4F50-A85A-96A498FE045F}']
    function Driver(): ITSWebDriverBase;
  end;

  ITSWebDriverBrowsers = interface
    ['{33FE127D-B125-4EFD-840F-6F44785CD065}']
    function Chrome: ITSWebDriverBrowser;
  end;

implementation

end.
