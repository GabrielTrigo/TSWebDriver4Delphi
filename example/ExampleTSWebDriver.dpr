program ExampleTSWebDriver;



uses
  Vcl.Forms,
  uExampleTSWebDriver in 'uExampleTSWebDriver.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;

end.
