unit uExampleTSWebDriver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, System.JSON, System.IOUtils, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.Buttons, TSWebDriver, TSWebDriver.IElement,
  Vcl.WinXCtrls, TSWebDriver.Interfaces, TSWebDriver.By, TSWebDriver.IBrowser;

type
  TFrmMain = class(TForm)
    MemLog: TMemo;
    btnNavigateTo: TButton;
    btnExecuteScript: TButton;
    btnExample4: TButton;
    btnExample5: TButton;
    btnExample1: TButton;
    btnExample2: TButton;
    btnExample3: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteScriptClick(Sender: TObject);
    procedure btnExample4Click(Sender: TObject);
    procedure btnExample5Click(Sender: TObject);
    procedure btnExample2Click(Sender: TObject);
    procedure btnExample3Click(Sender: TObject);
    procedure btnNavigateToClick(Sender: TObject);
    procedure btnExample1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FDriver: ITSWebDriverBase;
    FChromeDriver: ITSWebDriverBrowser;
    FBy: TSBy;
    procedure Run(AProc: Tproc; AUrl: string = ''; ACloseSection: Boolean = True);
    procedure ExampleLoginAndScrap;
    procedure ExampleDynamicElement;
    procedure ExampleGitHubBio;
    procedure ExampleGitHubFollowers;
    procedure ExampleChromeSearch;
  public
   { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  FDriver := TTSWebDriver.New.Driver();

  FChromeDriver := FDriver.Browser().Chrome();
  FChromeDriver
    .AddArgument('window-size', '1000,800')
    .AddArgument('user-data-dir', 'E:/Dev/Delphi/TSWebDriver4Delphi/example/cache');

  FDriver.Start();
end;

procedure TFrmMain.Run(AProc: Tproc; AUrl: string = ''; ACloseSection: Boolean = True);
begin
  MemLog.Clear();

  FChromeDriver.NewSession();

  if not AUrl.IsEmpty then
    FChromeDriver.NavigateTo(AUrl);

  FChromeDriver.WaitForPageReady();

  AProc();

  if ACloseSection then
    FChromeDriver.CloseSession();
end;

procedure TFrmMain.btnExample1Click(Sender: TObject);
begin
  Self.Run(
    ExampleLoginAndScrap,
    'https://www.saucedemo.com'
  );
end;

procedure TFrmMain.btnExample2Click(Sender: TObject);
begin
  Self.Run(
    ExampleDynamicElement,
    'https://www.selenium.dev/selenium/web/dynamic.html'
  );
end;

procedure TFrmMain.btnExample3Click(Sender: TObject);
begin
  Self.Run(
    ExampleGitHubBio,
    'https://letcode.in/elements'
  );
end;

procedure TFrmMain.btnExample4Click(Sender: TObject);
begin
  Self.Run(
    ExampleChromeSearch,
    'https://developer.chrome.com'
  );
end;

procedure TFrmMain.btnExample5Click(Sender: TObject);
begin
  Self.Run(
    ExampleGitHubFollowers,
    'https://gh-users-search.netlify.app'
  );
end;

procedure TFrmMain.btnExecuteScriptClick(Sender: TObject);
begin
  MemLog.Text :=
    FChromeDriver.ExecuteSyncScript(
      InputBox('Script', '', 'return document.title'));
end;

procedure TFrmMain.btnNavigateToClick(Sender: TObject);
begin
 Self.Run(procedure
          begin
            FChromeDriver.NavigateTo(
              InputBox('Url', '', 'https://github.com/GabrielTrigo'));
          end,
  '', False);
end;

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  Self.Run(
    procedure
    var
      lCheckbox: ITSWebDriverElement;
    begin
      lCheckbox := FChromeDriver.FindElement(FBy.XPath('//input[@id=''checky'']'));

      MemLog.Lines.AddPair('lCheckbox', lCheckbox.GetProperty('checked'));
      lCheckbox.Click();
      MemLog.Lines.AddPair('lCheckbox', lCheckbox.GetProperty('checked'));
    end,
    'file:///E:/dev/Delphi/TSWebDriver4Delphi/tests/mocks/formPage.html'
  );
end;

procedure TFrmMain.ExampleChromeSearch;
var
  lElement: ITSWebDriverElement;
begin
  lElement := FChromeDriver.FindElement(FBy.ClassName('search-box__input'));

  lElement.SendKeys('automate');

  FChromeDriver.WaitForSelector('.search-box__link');

  lElement := FChromeDriver.FindElement(FBy.ClassName('search-box__link'));

  lElement.Click();
end;

procedure TFrmMain.ExampleDynamicElement;
var
  lElement: ITSWebDriverElement;
begin
  lElement := FChromeDriver.FindElement(FBy.Id('adder'));

  lElement.Click();

  FChromeDriver.WaitForSelector('#box0');

  lElement := FChromeDriver.FindElement(FBy.Id('box0'));

  with MemLog.Lines do
  begin
    AddPair('Property style', lElement.GetProperty('style')).Add('');
    AddPair('Property innerHtml', lElement.GetProperty('innerHtml')).Add('');
    AddPair('CssValue "display"', lElement.GetCssValue('display')).Add('');
    AddPair('CssValue "width"', lElement.GetCssValue('width')).Add('');
    AddPair('CssValue "background-color"', lElement.GetCssValue('background-color')).Add('');
    AddPair('GetText', lElement.GetText()).Add('');
    AddPair('GetTagName', lElement.GetTagName()).Add('');
    AddPair('GetEnabled', BoolToStr(lElement.GetEnabled, True)).Add('');
    AddPair('GetDisplayed', BoolToStr(lElement.GetDisplayed, True)).Add('');
    AddPair('GetPageSource', FChromeDriver.GetPageSource()).Add('');
  end;
end;

procedure TFrmMain.ExampleGitHubBio;
begin
  FChromeDriver.FindElement(FBy.Name('username')).SendKeys('GabrielTrigo');

  FChromeDriver.FindElement(FBy.ID('search')).Click();

  FChromeDriver.WaitForSelector('.media');

  with FChromeDriver.FindElement(FBy.CssSelector('.media-content > span')) do
  begin
    MemLog.Lines.AddPair('GitHub bio', GetText());
  end;
end;

procedure TFrmMain.ExampleGitHubFollowers;
var
  lElement: ITSWebDriverElement;
  lElements: TTSWebDriverElementList;
begin
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

procedure TFrmMain.ExampleLoginAndScrap;
var
  lElement: ITSWebDriverElement;
  lElements: TTSWebDriverElementList;
begin
  try
    FChromeDriver.FindElement(FBy.Name('user-name')).SendKeys('standard_user');
    FChromeDriver.FindElement(FBy.ID('password')).SendKeys('secret_sauce');
    FChromeDriver.FindElement(FBy.Name('login-button')).Click();

    lElements := FChromeDriver.FindElements(FBy.ClassName('inventory_item'));

    for lElement in lElements do
      with MemLog.Lines do
      begin
        AddPair('Name', lElement.FindElement(FBy.ClassName('inventory_item_name')).GetText());
        AddPair('Description', lElement.FindElement(FBy.ClassName('inventory_item_desc')).GetText());
        AddPair('Price', lElement.FindElement(FBy.ClassName('inventory_item_price')).GetText());
        Append('-------------------------');
      end;
  finally
    FreeAndNil(lElements);
  end;
end;

end.

