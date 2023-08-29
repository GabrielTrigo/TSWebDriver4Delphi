program TSWebDriver4DelphiTests;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
{$R *.dres}

uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  TSWebDriver4Delphi.Test.CssValue in 'TSWebDriver4Delphi.Test.CssValue.pas',
  TSWebDriver4Delphi.Test.Utils in 'TSWebDriver4Delphi.Test.Utils.pas',
  TSWebDriver.Browsers in '..\src\TSWebDriver.Browsers.pas',
  TSWebDriver.Chrome in '..\src\TSWebDriver.Chrome.pas',
  TSWebDriver.Consts in '..\src\TSWebDriver.Consts.pas',
  TSWebDriver.Driver in '..\src\TSWebDriver.Driver.pas',
  TSWebDriver.Element in '..\src\TSWebDriver.Element.pas',
  TSWebDriver.IElement in '..\src\TSWebDriver.IElement.pas',
  TSWebDriver.Interfaces in '..\src\TSWebDriver.Interfaces.pas',
  TSWebDriver in '..\src\TSWebDriver.pas',
  TSWebDriver.Request in '..\src\TSWebDriver.Request.pas',
  TSWebDriver.Response in '..\src\TSWebDriver.Response.pas',
  TSWebDriver.Utils in '..\src\TSWebDriver.Utils.pas',
  TSWebDriver4Delphi.Test.ElementAttributeTest in 'TSWebDriver4Delphi.Test.ElementAttributeTest.pas',
  TSWebDriver.By in '..\src\TSWebDriver.By.pas',
  TSWebDriver.Browser in '..\src\TSWebDriver.Browser.pas',
  TSWebDriver.IBrowser in '..\src\TSWebDriver.IBrowser.pas';

{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    ReportMemoryLeaksOnShutdown := True;

    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
