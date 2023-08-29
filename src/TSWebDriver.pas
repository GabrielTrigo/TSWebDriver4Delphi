unit TSWebDriver;

interface

uses
  System.Net.HttpClient, System.Net.HttpClientComponent, System.Net.URLClient,
  System.Net.Mime, System.SysUtils, ShellAPI, Winapi.Windows, System.JSON,
  System.Classes, Winapi.Messages, TSWebDriver.Consts, System.IOUtils,
  System.StrUtils, TSWebDriver.Utils, TSWebDriver.Driver, TSWebDriver.Interfaces;

type
  TTSWebDriver = class(TInterfacedObject, ITSWebDriver)
  private
  public
    class function New: ITSWebDriver;
    function Driver(): ITSWebDriverBase;
  end;

implementation

{ TTSWebDriver }

class function TTSWebDriver.New: ITSWebDriver;
begin
  Result := Self.Create();
end;

function TTSWebDriver.Driver: ITSWebDriverBase;
begin
   Result := TTSWebDriverBase.New();
end;

end.

