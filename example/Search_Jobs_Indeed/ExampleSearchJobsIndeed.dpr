program ExampleSearchJobsIndeed;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  TSWebDriver.Element in '..\..\src\TSWebDriver.Element.pas',
  TSWebDriver.Utils in '..\..\src\TSWebDriver.Utils.pas',
  TSWebDriver.Browser in '..\..\src\TSWebDriver.Browser.pas',
  TSWebDriver in '..\..\src\TSWebDriver.pas',
  TSWebDriver.Consts in '..\..\src\TSWebDriver.Consts.pas',
  TSWebDriver.IBrowser in '..\..\src\TSWebDriver.IBrowser.pas',
  TSWebDriver.Driver in '..\..\src\TSWebDriver.Driver.pas',
  TSWebDriver.Interfaces in '..\..\src\TSWebDriver.Interfaces.pas',
  TSWebDriver.IElement in '..\..\src\TSWebDriver.IElement.pas',
  TSWebDriver.Request in '..\..\src\TSWebDriver.Request.pas',
  TSWebDriver.Chrome in '..\..\src\TSWebDriver.Chrome.pas',
  TSWebDriver.Browsers in '..\..\src\TSWebDriver.Browsers.pas',
  TSWebDriver.By in '..\..\src\TSWebDriver.By.pas',
  TSWebDriver.Response in '..\..\src\TSWebDriver.Response.pas';

var
  FDriver: ITSWebDriverBase;
  FChromeDriver: ITSWebDriverBrowser;
  FBy: TSBy;
  FJobsList: string;

const QUERY = 'delphi';

procedure StartDriver();
begin
  FDriver := TTSWebDriver.New.Driver;
  FDriver
    .Options
      .DriverPath('E:\Dev\WebDrivers\chromedriver.exe')
    .&End;

  FChromeDriver := FDriver.Browser().Chrome();
  FChromeDriver
    .AddArgument('--window-size=1000,800')
    .AddArgument('--user-data-dir=E:/Dev/Delphi/TSWebDriver4Delphi/example/cache');

  FDriver.Start();
end;

begin
  StartDriver();
  try
    FChromeDriver.NewSession();

    FChromeDriver.NavigateTo(Format('https://br.indeed.com/jobs?q=%s&l=Brasil&fromage=3', [QUERY]));
    FChromeDriver.WaitForPageReady();

    FJobsList := FChromeDriver.ExecuteSyncScript('return window.mosaic.providerData[\"mosaic-provider-jobcards\"]');

    Writeln(FJobsList);

    FChromeDriver.CloseSession();

    while true do
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

