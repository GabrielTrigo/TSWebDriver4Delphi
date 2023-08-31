unit TSWebDriver4Delphi.Test.CssValue;

interface

uses
  DUnitX.TestFramework, TSWebDriver4Delphi.Test.Utils, TSWebDriver,
  TSWebDriver.IElement, TSWebDriver.By, TSWebDriver4Delphi.Test.Base;

type
  [TestFixture]
  TCssValueTest = class(TBaseTest)
  private
    By: TSBy;
  public
    constructor Create(); override;
    destructor Destroy(); override;
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

constructor TCssValueTest.Create;
begin
  inherited;
end;

destructor TCssValueTest.Destroy;
begin
  inherited;
end;

procedure TCssValueTest.Setup;
begin
  ChromeDriver.NewSession();
end;

procedure TCssValueTest.TearDown;
begin
  if Driver.IsRunning and (ChromeDriver.SessionID <> EmptyStr) then
    ChromeDriver.CloseSection();
end;

procedure TCssValueTest.ShouldPickUpStyleOfAnElement;
var
  lElement: ITSWebDriverElement;
  lbackgroundColour: string;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('javascriptPage.html'));
  ChromeDriver.WaitForPageReady();

  lElement := ChromeDriver.FindElement(By.Id('green-parent'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['#008000', 'rgba(0, 128, 0, 1)', 'rgb(0, 128, 0)'], lbackgroundColour);

  lElement := ChromeDriver.FindElement(By.Id('red-item'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['#ff0000', 'rgba(255, 0, 0, 1)', 'rgb(255, 0, 0)'], lbackgroundColour);
end;

procedure TCssValueTest.GetCssValueShouldReturnStandardizedColour;
var
  lElement: ITSWebDriverElement;
  lbackgroundColour: string;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('colorPage.html'));
  ChromeDriver.WaitForPageReady();

  lElement := ChromeDriver.FindElement(By.Id('namedColor'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['rgba(0, 128, 0, 1)', 'rgb(0, 128, 0)'], lbackgroundColour);

  lElement := ChromeDriver.FindElement(By.Id('rgb'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['rgba(0, 128, 0, 1)', 'rgb(0, 128, 0)'], lbackgroundColour);
end;

procedure TCssValueTest.ShouldAllowInheritedStylesToBeUsed;
var
  lElement: ITSWebDriverElement;
  lbackgroundColour: string;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('javascriptPage.html'));
  ChromeDriver.WaitForPageReady();

  lElement := ChromeDriver.FindElement(By.Id('green-item'));
  lbackgroundColour := lElement.GetCssValue('background-color');

  Assert.Contains(['transparent', 'rgba(0, 0, 0, 0)'], lbackgroundColour);
end;

initialization
  TDUnitX.RegisterTestFixture(TCssValueTest);

end.
