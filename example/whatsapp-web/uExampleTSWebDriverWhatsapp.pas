unit uExampleTSWebDriverWhatsapp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,  System.IOUtils, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.Buttons, System.JSON, REST.Json,

  TSWebDriver,
  TSWebDriver.IElement,
  TSWebDriver.Interfaces,
  TSWebDriver.By,
  TSWebDriver.IBrowser;

type
  TFrmMain = class(TForm)
    MemLog: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FDriver: ITSWebDriverBase;
    FChromeDriver: ITSWebDriverBrowser;
  public
   { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  FChromeDriver.ExecuteSyncScript(
    TFile.ReadAllText('F:\Downloads\whatsapp-web.js\injected.json')
  );
end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
  MemLog.Text := FChromeDriver.ExecuteSyncScript(
    'return window.WWebJS.getChats();'
  );
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  MemLog.Clear();

  FDriver := TTSWebDriver.New.Driver();

  FChromeDriver := FDriver.Browser().Chrome();
  FChromeDriver
    .AddArgument('user-data-dir', 'E:\\Dev\\Delphi\\whatsapp-web\\webdriver\\cache');

  FDriver.Start();

  FChromeDriver.NewSession();
  FChromeDriver.NavigateTo('https://web.whatsapp.com');
  FChromeDriver.WaitForPageReady();
end;

end.

