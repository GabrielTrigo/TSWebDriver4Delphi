unit uExampleTSWebDriver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, System.JSON, System.IOUtils, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.Buttons, TSWebDriver, TSWebDriver.IElement,
  Vcl.WinXCtrls, TSWebDriver.Interfaces, TSWebDriver.By, TSWebDriver.IBrowser;

type
  TForm1 = class(TForm)
    MemLog: TMemo;
    btnNavigateTo: TButton;
    btnExecuteScript: TButton;
    btnExample4: TButton;
    btnExample5: TButton;
    btnExample1: TButton;
    btnExample2: TButton;
    btnExample3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteScriptClick(Sender: TObject);
    procedure btnTakeScreenshotClick(Sender: TObject);
    procedure btnExample4Click(Sender: TObject);
    procedure btnExample5Click(Sender: TObject);
    procedure btnExample1Click(Sender: TObject);
    procedure btnExample2Click(Sender: TObject);
    procedure btnExample3Click(Sender: TObject);
    procedure btnNavigateToClick(Sender: TObject);
  private
    { Private declarations }
    FDriver: ITSWebDriverBase;
    FChromeDriver: ITSWebDriverBrowser;
    FBy: TSBy;
  public
   { Public declarations }
  end;

var
  Form1: TForm1;

const
  USER_DATA_DIR_ARG = '--user-data-dir=E:\\Dev\\Delphi\\TSWebDriver4Delphi\\example\\cache';

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  FDriver := TTSWebDriver.New.Driver;
  FDriver
    .Options
      .DriverPath('E:\Dev\WebDrivers\chromedriver.exe')
    .&End;

  FChromeDriver := FDriver.Browser().Chrome();
  FChromeDriver.AddArgument(USER_DATA_DIR_ARG);

  FDriver.Start();
  FChromeDriver.NewSession();
end;

procedure TForm1.btnExample1Click(Sender: TObject);
var
  lElement: ITSWebDriverElement;
  lElements: TTSWebDriverElementList;
begin
  MemLog.Clear();

  FChromeDriver.NavigateTo('https://www.saucedemo.com');
  FChromeDriver.WaitForPageReady();

  FChromeDriver.FindElement(FBy.Name('user-name')).SendKeys('standard_user');
  FChromeDriver.FindElement(FBy.ID('password')).SendKeys('secret_sauce');
  FChromeDriver.FindElement(FBy.Name('login-button')).Click();

  FChromeDriver.WaitForPageReady();

  lElements := FChromeDriver.FindElements(FBy.ClassName('inventory_item'));

  for lElement in lElements do
    with MemLog.Lines do
    begin
      AddPair('Name', lElement.FindElement(FBy.ClassName('inventory_item_name')).GetText());
      AddPair('Description', lElement.FindElement(FBy.ClassName('inventory_item_desc')).GetText());
      AddPair('Price', lElement.FindElement(FBy.ClassName('inventory_item_price')).GetText());
      Append('-------------------------');
    end;

  FreeAndNil(lElements);
end;

procedure TForm1.btnExample2Click(Sender: TObject);
var
  lElement: ITSWebDriverElement;
begin
  MemLog.Clear();

  FChromeDriver.NavigateTo('https://www.selenium.dev/selenium/web/dynamic.html');
  FChromeDriver.WaitForPageReady();

  lElement := FChromeDriver.FindElement(FBy.Id('adder'));

  lElement.Click();

  FChromeDriver.WaitForSelector('#box0');

  lElement := FChromeDriver.FindElement(FBy.Id('box0'));

  with MemLog.Lines do
  begin
    AddPair('Property style', lElement.GetProperty('style'));
    AddPair('Property innerHtml', lElement.GetProperty('innerHtml'));
    AddPair('CssValue "display"', lElement.GetCssValue('display'));
    AddPair('CssValue "width"', lElement.GetCssValue('width'));
    AddPair('CssValue "background-color"', lElement.GetCssValue('background-color'));
    AddPair('GetText', lElement.GetText());
    AddPair('GetTagName', lElement.GetTagName());
    AddPair('GetEnabled', BoolToStr(lElement.GetEnabled, True));
    AddPair('GetDisplayed', BoolToStr(lElement.GetDisplayed, True));
    AddPair('GetPageSource', FChromeDriver.GetPageSource());
  end;
end;

procedure TForm1.btnExample3Click(Sender: TObject);
begin
  MemLog.Clear();

  FChromeDriver.NavigateTo('https://letcode.in/elements');
  FChromeDriver.WaitForPageReady();

  FChromeDriver.FindElement(FBy.Name('username')).SendKeys('GabrielTrigo');

  FChromeDriver.FindElement(FBy.ID('search')).Click();

  FChromeDriver.WaitForSelector('.media');

  with FChromeDriver.FindElement(FBy.CssSelector('.media-content > span')) do
  begin
    MemLog.Lines.AddPair('GitHub bio', GetText());
  end;
end;

procedure TForm1.btnExample4Click(Sender: TObject);
var
  lElement: ITSWebDriverElement;
begin
  MemLog.Clear();

  FChromeDriver.NavigateTo('https://developer.chrome.com');
  FChromeDriver.WaitForPageReady();

  lElement := FChromeDriver.FindElement(FBy.ClassName('search-box__input'));

  lElement.SendKeys('automate');

  FChromeDriver.WaitForSelector('.search-box__link');

  lElement := FChromeDriver.FindElement(FBy.ClassName('search-box__link'));

  lElement.Click();
end;

procedure TForm1.btnExample5Click(Sender: TObject);
var
  lElement: ITSWebDriverElement;
  lElements: TTSWebDriverElementList;
begin
  MemLog.Clear();

  FChromeDriver.NavigateTo('https://gh-users-search.netlify.app');
  FChromeDriver.WaitForPageReady();

  lElements := FChromeDriver.FindElements(FBy.CssSelector('.followers > article'));

  for lElement in lElements do
    with MemLog.Lines do
    begin
      AddPair('Name', lElement.FindElement(FBy.TagName('h4')).GetText());
      AddPair('Link', lElement.FindElement(FBy.TagName('a')).GetText());
      Append('-------------------------');
    end;

  FreeAndNil(lElements);
end;

procedure TForm1.btnExecuteScriptClick(Sender: TObject);
begin
  MemLog.Text :=
    FChromeDriver.ExecuteSyncScript(
      InputBox('Script', '', 'return document.title'));
end;

procedure TForm1.btnNavigateToClick(Sender: TObject);
begin
  FChromeDriver.NavigateTo(
    InputBox('Url', '', 'https://github.com/GabrielTrigo'));
end;

procedure TForm1.btnTakeScreenshotClick(Sender: TObject);
begin
  MemLog.Text := FChromeDriver.TakeScreenshot();
end;

end.

