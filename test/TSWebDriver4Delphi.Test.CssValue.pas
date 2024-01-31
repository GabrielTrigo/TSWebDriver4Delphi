unit TSWebDriver4Delphi.Test.CssValue;

interface

uses
  DUnitX.TestFramework, TSWebDriver4Delphi.Test.Utils, TSWebDriver,
  TSWebDriver.IElement, TSWebDriver.By, TSWebDriver4Delphi.Test.Driver;

type
  [TestFixture]
  TCssValueTest = class
  private
    By: TSBy;
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

implementation

uses
  System.SysUtils;

procedure TCssValueTest.Setup;
begin
  TDriverTest.ChromeDriver.NewSession();
end;

procedure TCssValueTest.TearDown;
begin
  TDriverTest.ChromeDriver.CloseSession();
end;

procedure TCssValueTest.ShouldPickUpStyleOfAnElement;
var
  lElement: ITSWebDriverElement;
  lbackgroundColour: string;
begin
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('javascriptPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  lElement := TDriverTest.ChromeDriver.FindElement(By.Id('green-parent'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['#008000', 'rgba(0, 128, 0, 1)', 'rgb(0, 128, 0)'], lbackgroundColour);

  lElement := TDriverTest.ChromeDriver.FindElement(By.Id('red-item'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['#ff0000', 'rgba(255, 0, 0, 1)', 'rgb(255, 0, 0)'], lbackgroundColour);
end;

procedure TCssValueTest.GetCssValueShouldReturnStandardizedColour;
var
  lElement: ITSWebDriverElement;
  lbackgroundColour: string;
begin
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('colorPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  lElement := TDriverTest.ChromeDriver.FindElement(By.Id('namedColor'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['rgba(0, 128, 0, 1)', 'rgb(0, 128, 0)'], lbackgroundColour);

  lElement := TDriverTest.ChromeDriver.FindElement(By.Id('rgb'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['rgba(0, 128, 0, 1)', 'rgb(0, 128, 0)'], lbackgroundColour);
end;

procedure TCssValueTest.ShouldAllowInheritedStylesToBeUsed;
var
  lElement: ITSWebDriverElement;
  lbackgroundColour: string;
begin
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('javascriptPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  lElement := TDriverTest.ChromeDriver.FindElement(By.Id('green-item'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['transparent', 'rgba(0, 0, 0, 0)'], lbackgroundColour);
end;

initialization
  TDUnitX.RegisterTestFixture(TCssValueTest);

end.
