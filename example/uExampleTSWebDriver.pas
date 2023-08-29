unit uExampleTSWebDriver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, System.JSON, System.IOUtils, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.Buttons, TSWebDriver, TSWebDriver.IElement,
  Vcl.WinXCtrls, TSWebDriver.Interfaces, TSWebDriver.By;

type
  TForm1 = class(TForm)
    btnNewSection: TButton;
    Memo1: TMemo;
    edtSessionId: TEdit;
    btnNavigateTo: TButton;
    btnExecuteScript: TButton;
    btnCloseSession: TButton;
    btnLauch: TButton;
    btnClose: TButton;
    btnFindElement: TButton;
    btnFindElements: TButton;
    btnElementClick: TButton;
    btnElementSendKeys: TButton;
    btnTakeScreenshot: TButton;
    btnInjectWppScript: TButton;
    btnRunSequence: TButton;
    btnStatus: TButton;
    btnIsRunning: TButton;
    Button1: TButton;
    procedure btnNewSectionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNavigateToClick(Sender: TObject);
    procedure btnExecuteScriptClick(Sender: TObject);
    procedure btnInjectWppScriptClick(Sender: TObject);
    procedure btnLauchClick(Sender: TObject);
    procedure edtSessionIdChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseSessionClick(Sender: TObject);
    procedure btnFindElementClick(Sender: TObject);
    procedure btnFindElementsClick(Sender: TObject);
    procedure btnElementClickClick(Sender: TObject);
    procedure btnElementSendKeysClick(Sender: TObject);
    procedure btnTakeScreenshotClick(Sender: TObject);
    procedure btnRunSequenceClick(Sender: TObject);
    procedure btnStatusClick(Sender: TObject);
    procedure btnIsRunningClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FDriver: ITSWebDriverBase;
    FChromeDriver: ITSWebDriverBrowser;
  public
   { Public declarations }
  end;

var
  Form1: TForm1;

const
  USER_DATA_DIR_ARG = '--user-data-dir=E:\\Dev\\Delphi\\whatsapp-web\\webdriver\\cache';

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

  FChromeDriver.NewSession();
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  lBy: TSBy;
  lElement, lElementTemp: ITSWebDriverElement;
  lElements: TTSWebDriverElementList;
begin
  FChromeDriver.NavigateTo('https://letcode.in/elements');
  FChromeDriver.WaitForPageReady();

  lElement := FChromeDriver.FindElement(lBy.TagName('ol'));

  lElementTemp := lElement.FindElement(lBy.TagName('li'));

  Memo1.Lines.Add(lElementTemp.GetText());

//  http://the-internet.herokuapp.com/dynamic_loading/1
//  Memo1.Lines.Add(FChromeDriver.ElementAttribute(lElement.ID, 'style'));
//  Memo1.Lines.Add(FChromeDriver.ElementProperty(lElement.ID, 'innerText'));
//  Memo1.Lines.Add(FChromeDriver.ElementCSSValue(lElement.ID, 'display'));
//  Memo1.Lines.Add(FChromeDriver.ElementText(lElement.ID));
//  Memo1.Lines.Add(FChromeDriver.ElementTagName(lElement.ID));
//  Memo1.Lines.Add(BoolToStr(FChromeDriver.IsElementEnabled(lElement.ID), True));
//  Memo1.Lines.Add(FChromeDriver.GetPageSource());
//
//  if Assigned(lElement) then
//    FreeAndNil(lElement);

//  FChromeDriver.NavigateTo('https://letcode.in/elements');
//  FChromeDriver.WaitForPageReady();
//
//  with FChromeDriver.FindElement(lBy.Name('username')) do
//  begin
//    SendKeys('GabrielTrigo');
//    Free();
//  end;
//
//  with FChromeDriver.FindElement(lBy.ID('search')) do
//  begin
//    Click();
//    Free();
//  end;
//
//  with FChromeDriver.FindElement(lBy.Xpath('//html/body/app-root/app-githome/section[1]/div/div/div[1]/div/div/div/app-usercard/div/div/div[1]/div[2]/span')) do
//  begin
//    Free();
//  end;
//
//  FChromeDriver.WaitForSelector('.media');
//
//  ShowMessage('ready!!!')

//  FChromeDriver.NavigateTo('https://www.saucedemo.com');
//  FChromeDriver.WaitForPageReady();
//
//  FChromeDriver.FindElement(lBy.Name('user-name')).SendKeys('standard_user');
//  FChromeDriver.FindElement(lBy.ID('password')).SendKeys('secret_sauce');
//  FChromeDriver.FindElement(lBy.Name('login-button')).Click();
//
//  FChromeDriver.WaitForPageReady();
//
//  lElements := FChromeDriver.FindElements(lBy.ClassName('inventory_item'));
//
//  for lElement in lElements do
//    Memo1.Lines.AddPair('GetText', lElement.GetText());
//
//  FreeAndNil(lElements);
end;

procedure TForm1.btnNewSectionClick(Sender: TObject);
begin
  //FPage.NewSession();
  //edtSessionId.Text := FPage.SessionID();
end;

procedure TForm1.btnStatusClick(Sender: TObject);
begin
  //ShowMessage(BoolToStr(FPage.Status, True));
end;

procedure TForm1.edtSessionIdChange(Sender: TObject);
begin
  //FPage.SessionID(TEdit(Sender).Text);
end;

procedure TForm1.btnLauchClick(Sender: TObject);
begin
  //FPage.Launch();
end;

procedure TForm1.btnInjectWppScriptClick(Sender: TObject);
//const
//  SCRIPT_1 = '..\js\findModules.js';
//  SCRIPT_2 = '..\js\injected.js';
//var
//  lFileContents: string;
//  lResponse: TJSONObject;
begin
//  lResponse := TJSONObject.Create();
//  try
//    lFileContents := Tfile.ReadAllText(SCRIPT_1, TEncoding.UTF8).Replace('"', '\"', [rfReplaceAll, rfIgnoreCase]);
//    FPage.ExecuteSyncScript(lFileContents, lResponse);
//    Memo1.Lines.Add(lResponse.Format());
//
//    lFileContents := Tfile.ReadAllText(SCRIPT_2, TEncoding.UTF8).Replace('"', '\"', [rfReplaceAll, rfIgnoreCase]);
//    FPage.ExecuteSyncScript(lFileContents, lResponse);
//    Memo1.Lines.Add(lResponse.Format());
//  finally
//    FreeAndNil(lResponse);
//  end;
end;

procedure TForm1.btnNavigateToClick(Sender: TObject);
begin
//  FPage.NavigateTo(InputBox('Script', '', 'https://www.trigus.com.br'));
end;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
//  FPage.Close();
end;

procedure TForm1.btnCloseSessionClick(Sender: TObject);
begin
//  FPage.CloseSection(edtSessionId.Text);
end;

procedure TForm1.btnElementClickClick(Sender: TObject);
begin
//  Memo1.Text := FPage.ElementClick(InputBox('Element ID', '', ''));
end;

procedure TForm1.btnElementSendKeysClick(Sender: TObject);
begin
//  Memo1.Text := FPage.SendKeys(
//    InputBox('Element ID', '', ''),
//    InputBox('Element send keys', '', 'abcdefghij')
//  );
end;

procedure TForm1.btnExecuteScriptClick(Sender: TObject);
//var
//  lResponse: TJSONObject;
begin
//  try
//    FPage.ExecuteSyncScript(InputBox('Script', '', 'return document.title'), lResponse);
//    Memo1.Lines.Add(lResponse.Format());
//  finally
//    lResponse.Destroy();
//  end;
end;

procedure TForm1.btnTakeScreenshotClick(Sender: TObject);
begin
  //Memo1.Text := FPage.TakeScreenshot();
end;

procedure TForm1.btnRunSequenceClick(Sender: TObject);
begin
//  if not FPage.IsRunning then
//    FPage.Launch();
//
//  FPage.NewSession();
//  FPage.NavigateTo('https://developer.chrome.com');
//
//  lInputElement := FPage.FindElement('.search-box__input');
//
//  FPage.SendKeys(lInputElement.ID, 'automate');
//
//  FPage.WaitForSelector('.search-box__link');
//
//  lInputElement := FPage.FindElement('.search-box__link');
//
//  FPage.ElementClick(lInputElement.ID);
//
//  if Assigned(lInputElement) then
//    FreeAndNil(lInputElement);
  //FPage.Close();
end;

procedure TForm1.btnIsRunningClick(Sender: TObject);
begin
  //ShowMessage(BoolToStr(FPage.IsRunning(), True));
end;

procedure TForm1.btnFindElementClick(Sender: TObject);
begin
  //Memo1.Text := FPage.FindElement('//input', 'xpath');
end;

procedure TForm1.btnFindElementsClick(Sender: TObject);
begin
  //Memo1.Text := FPage.FindElements('//input', 'xpath');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  if FPage.IsRunning() then
//    FPage.Close();
end;

end.

