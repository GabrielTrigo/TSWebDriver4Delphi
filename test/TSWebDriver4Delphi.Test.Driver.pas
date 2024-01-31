unit TSWebDriver4Delphi.Test.Driver;

interface

uses
  DUnitX.TestFramework, TSWebDriver.Interfaces, TSWebDriver.IBrowser,
  TSWebDriver;

{$M+}

type
  TDriverTest = class
  private
    class var
      FDriver: ITSWebDriverBase;
    class var
      FChromeDriver: ITSWebDriverBrowser;
    class procedure Start();
    class procedure Stop();
  public
    class function ChromeDriver: ITSWebDriverBrowser;
  end;

implementation

{ TDriverTest }

class function TDriverTest.ChromeDriver: ITSWebDriverBrowser;
begin
  Result := FChromeDriver;
end;

class procedure TDriverTest.Start();
begin
  if Assigned(FDriver) or Assigned(FChromeDriver) then Exit;

  FDriver := TTSWebDriver.New.Driver();

  //  FDriver
  //    .Options
  //      .DriverPath('..\example\bin\webdriver.exe')
  //    .&End;

  FChromeDriver := FDriver.Browser().Chrome();
  //FChromeDriver.AddArgument('--headless=new');

  FDriver.Start();
end;

class procedure TDriverTest.Stop();
begin
  FDriver.Stop();
end;

initialization TDriverTest.Start();

finalization TDriverTest.Stop();

end.

