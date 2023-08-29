program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  WebDriver4Delphi in 'WebDriver4Delphi.pas',
  WebDriver4Delphi.Consts in 'WebDriver4Delphi.Consts.pas',
  WebDriver4Delphi.Utils in 'WebDriver4Delphi.Utils.pas',
  TSWebDriver.Chrome in 'TSWebDriver.Chrome.pas',
  TSWebDriver.Interfaces in 'TSWebDriver.Interfaces.pas',
  TSRequestWebDriver4Delphi in 'TSRequestWebDriver4Delphi.pas',
  TSWebDriver.Driver in 'TSWebDriver.Driver.pas',
  TSWebDriver.Browsers in 'TSWebDriver.Browsers.pas',
  TSWebDriver.Types in 'TSWebDriver.Types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
