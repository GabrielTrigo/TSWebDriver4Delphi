unit TSWebDriver.Browsers;

interface

uses
  TSWebDriver.Chrome, TSWebDriver.Interfaces, TSWebDriver.IBrowser;

type
  TTSWebDriverBrowsers = class(TInterfacedObject, ITSWebDriverBrowsers)
  public
    class function New(): ITSWebDriverBrowsers;
    function Chrome: ITSWebDriverBrowser;
  end;

implementation

{ TTSWebDriverBrowsers }

class function TTSWebDriverBrowsers.New: ITSWebDriverBrowsers;
begin
  Result := Self.Create();
end;

function TTSWebDriverBrowsers.Chrome: ITSWebDriverBrowser;
begin
  Result := TTSWebDriverChrome.New();
end;

end.
