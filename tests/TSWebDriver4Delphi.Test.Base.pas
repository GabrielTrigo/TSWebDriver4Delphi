unit TSWebDriver4Delphi.Test.Base;

interface

uses
  DUnitX.TestFramework, TSWebDriver.Interfaces, TSWebDriver.IBrowser,
  TSWebDriver;

{$M+}

type
  TBaseTest = class
  private
    FDriver: ITSWebDriverBase;
    FChromeDriver: ITSWebDriverBrowser;
  public
    constructor Create; virtual;
    destructor Destroy(); override;
  protected
    property ChromeDriver: ITSWebDriverBrowser read FChromeDriver;
    property Driver: ITSWebDriverBase read FDriver;
  end;

implementation

{ TBaseTest }

constructor TBaseTest.Create();
begin
  FDriver := TTSWebDriver.New.Driver;
  FDriver
    .Options
      .DriverPath('E:\Dev\WebDrivers\chromedriver.exe')
    .&End;

  FChromeDriver := FDriver.Browser().Chrome();
  FChromeDriver
    .AddArgument('--headless=new');
end;

destructor TBaseTest.Destroy;
begin
  FDriver.Stop();
  inherited;
end;

end.
