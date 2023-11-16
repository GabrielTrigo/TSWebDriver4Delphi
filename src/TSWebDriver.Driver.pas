unit TSWebDriver.Driver;

interface

uses
  Winapi.Windows, System.SysUtils, TSWebDriver.Utils,
  Winapi.Messages, TSWebDriver.Browsers, TSWebDriver.Interfaces;

type
  TTSWebDriverBaseOptions = class(TInterfacedObject, ITSWebDriverBaseOptions)
  strict private
    [weak]
    FTSWebDriverBase: ITSWebDriverBase;
    FDriverPath: string;
  public
    class function New(ATSWebDriverBase: ITSWebDriverBase): ITSWebDriverBaseOptions;
    function &End(): ITSWebDriverBase;
    constructor Create(ATSWebDriverBase: ITSWebDriverBase);
    destructor Destroy(); override;
    function DriverPath(AValue: String): ITSWebDriverBaseOptions; overload;
    function AddArgument(AValue: String): ITSWebDriverBaseOptions;
    function DriverPath(): String; overload;
  end;

  TTSWebDriverBase = class(TInterfacedObject, ITSWebDriverBase)
  strict private
    FSWebDriverBaseOptions: ITSWebDriverBaseOptions;
    FProccessName: string;
    FStartupInfo: TStartupInfo;
    FProcessInfo: TProcessInformation;
  public
    class function New(): ITSWebDriverBase;
    constructor Create();
    destructor Destroy(); override;
    function Start(): ITSWebDriverBase;
    function Stop(): ITSWebDriverBase;
    function IsRunning(): Boolean;
    function Options(): ITSWebDriverBaseOptions;
    function Browser(): ITSWebDriverBrowsers;
  end;

implementation

class function TTSWebDriverBase.New(): ITSWebDriverBase;
begin
  Result := Self.Create();
end;

constructor TTSWebDriverBase.Create();
begin
  FillChar(FProcessInfo, SizeOf(FProcessInfo), 0);
  FSWebDriverBaseOptions := TTSWebDriverBaseOptions.New(Self);
end;

function TTSWebDriverBase.Options(): ITSWebDriverBaseOptions;
begin
  Result := FSWebDriverBaseOptions;
end;

function TTSWebDriverBase.Browser(): ITSWebDriverBrowsers;
begin
  Result := TTSWebDriverBrowsers.New();
end;

destructor TTSWebDriverBase.Destroy();
begin
  Self.Stop();
  inherited;
end;

function TTSWebDriverBase.Start(): ITSWebDriverBase;
begin
  FProccessName := ExtractFileName(FSWebDriverBaseOptions.DriverPath);

  if not FileExists(FSWebDriverBaseOptions.DriverPath) then
    raise Exception.Create('driver file not exists.' +
      FSWebDriverBaseOptions.DriverPath);

  if Self.IsRunning() or (FProcessInfo.hProcess <> 0) then Exit;

  FillChar(FStartupInfo, SizeOf(FStartupInfo), 0);
  FillChar(FProcessInfo, SizeOf(FProcessInfo), 0);

  FStartupInfo.wShowWindow := SW_NORMAL;
  FStartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  if CreateProcess(nil, Pchar(FSWebDriverBaseOptions.DriverPath + ' '), nil, nil, False,
    NORMAL_PRIORITY_CLASS, nil, nil, FStartupInfo, FProcessInfo) then
  begin end;
end;

function TTSWebDriverBase.Stop(): ITSWebDriverBase;
begin
  TerminateProcess(FProcessInfo.hProcess, 0);
  FillChar(FStartupInfo, SizeOf(FStartupInfo), 0);
  FillChar(FProcessInfo, SizeOf(FProcessInfo), 0);
end;

function TTSWebDriverBase.IsRunning(): Boolean;
begin
  Result := ProccessIsRunning(FProccessName);
end;

{ TTSWebDriverBaseOptions }

class function TTSWebDriverBaseOptions.New(ATSWebDriverBase: ITSWebDriverBase): ITSWebDriverBaseOptions;
begin
  Result := Self.Create(ATSWebDriverBase);
end;

function TTSWebDriverBaseOptions.AddArgument(
  AValue: String): ITSWebDriverBaseOptions;
begin
  raise ENotImplemented.Create('Not implemented');
  Result := Self;
end;

constructor TTSWebDriverBaseOptions.Create(ATSWebDriverBase: ITSWebDriverBase);
begin
  FDriverPath := 'webdriver.exe';
  FTSWebDriverBase := ATSWebDriverBase;
end;

destructor TTSWebDriverBaseOptions.Destroy;
begin
  inherited;
end;

function TTSWebDriverBaseOptions.DriverPath: String;
begin
  Result := FDriverPath;
end;

function TTSWebDriverBaseOptions.DriverPath(
  AValue: String): ITSWebDriverBaseOptions;
begin
  FDriverPath := AValue;
  Result := Self;
end;

function TTSWebDriverBaseOptions.&End: ITSWebDriverBase;
begin
  Result := FTSWebDriverBase;
end;

end.
