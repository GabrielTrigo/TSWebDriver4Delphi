program ExampleTSWebDriver;

uses
  Vcl.Forms,
  uExampleTSWebDriver in 'uExampleTSWebDriver.pas' {Form1},
  TSWebDriver.Browser in '..\src\TSWebDriver.Browser.pas',
  TSWebDriver.Browsers in '..\src\TSWebDriver.Browsers.pas',
  TSWebDriver.By in '..\src\TSWebDriver.By.pas',
  TSWebDriver.Chrome in '..\src\TSWebDriver.Chrome.pas',
  TSWebDriver.Consts in '..\src\TSWebDriver.Consts.pas',
  TSWebDriver.Driver in '..\src\TSWebDriver.Driver.pas',
  TSWebDriver.Element in '..\src\TSWebDriver.Element.pas',
  TSWebDriver.IBrowser in '..\src\TSWebDriver.IBrowser.pas',
  TSWebDriver.IElement in '..\src\TSWebDriver.IElement.pas',
  TSWebDriver.Interfaces in '..\src\TSWebDriver.Interfaces.pas',
  TSWebDriver in '..\src\TSWebDriver.pas',
  TSWebDriver.Request in '..\src\TSWebDriver.Request.pas',
  TSWebDriver.Response in '..\src\TSWebDriver.Response.pas',
  TSWebDriver.Utils in '..\src\TSWebDriver.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
