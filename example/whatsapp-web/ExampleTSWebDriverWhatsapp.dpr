program ExampleTSWebDriverWhatsapp;



uses
  Vcl.Forms,
  uExampleTSWebDriverWhatsapp in 'uExampleTSWebDriverWhatsapp.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;

end.
