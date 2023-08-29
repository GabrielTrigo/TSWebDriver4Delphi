unit TSWebDriver4Delphi.Test.CssValue;

interface

uses
  DUnitX.TestFramework, TSWebDriver4Delphi.Test.Utils, TSWebDriver.Interfaces,
  TSWebDriver, TSWebDriver.IElement, TSWebDriver.By, TSWebDriver.IBrowser;

{$M+}

type
  [TestFixture]
  TCssValueTest = class
  private
    By: TSBy;
    FDriver: ITSWebDriverBase;
    FChromeDriver: ITSWebDriverBrowser;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure ShouldPickUpStyleOfAnElement;
    [Test]
    procedure GetCssValueShouldReturnStandardizedColour;
    [Test]
    procedure ShouldAllowInheritedStylesToBeUsed;
  end;

const
  USER_DATA_DIR_ARG = '--user-data-dir=E:\\Dev\\WebDrivers\\cache';

implementation

procedure TCssValueTest.Setup;
begin
  FDriver := TTSWebDriver.New.Driver;
  FDriver
    .Options
      .DriverPath('E:\Dev\WebDrivers\chromedriver.exe')
    .&End;

  FChromeDriver := FDriver.Browser().Chrome();
  FChromeDriver.AddArgument(USER_DATA_DIR_ARG);

  FChromeDriver.NewSession();
end;

procedure TCssValueTest.TearDown;
begin
  FChromeDriver.CloseSection();
  FDriver.Stop();
end;

procedure TCssValueTest.ShouldPickUpStyleOfAnElement;
var
  lElement: ITSWebDriverElement;
  lbackgroundColour: string;
begin
  FChromeDriver.NavigateTo(MakeUrlFile('javascriptPage.html'));
  FChromeDriver.WaitForPageReady();

  lElement := FChromeDriver.FindElement(By.Id('green-parent'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.AreEqual('rgba(0, 128, 0, 1)', lbackgroundColour);

  lElement := FChromeDriver.FindElement(By.Id('red-item'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.AreEqual('rgba(255, 0, 0, 1)', lbackgroundColour);
end;

procedure TCssValueTest.GetCssValueShouldReturnStandardizedColour;
var
  lElement: ITSWebDriverElement;
  lbackgroundColour: string;
begin
  FChromeDriver.NavigateTo(MakeUrlFile('colorPage.html'));
  FChromeDriver.WaitForPageReady();

  lElement := FChromeDriver.FindElement(By.Id('namedColor'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.AreEqual('rgba(0, 128, 0, 1)', lbackgroundColour);

  lElement := FChromeDriver.FindElement(By.Id('rgb'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.AreEqual('rgba(0, 128, 0, 1)', lbackgroundColour);
end;

procedure TCssValueTest.ShouldAllowInheritedStylesToBeUsed;
var
  lElement: ITSWebDriverElement;
  lbackgroundColour: string;
begin
  FChromeDriver.NavigateTo(MakeUrlFile('javascriptPage.html'));
  FChromeDriver.WaitForPageReady();

  lElement := FChromeDriver.FindElement(By.Id('green-item'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.AreEqual('rgba(0, 0, 0, 0)', lbackgroundColour);
end;

initialization
  TDUnitX.RegisterTestFixture(TCssValueTest);

end.
