unit TSWebDriver.Request;

interface

uses
  System.Net.HttpClientComponent, System.Classes, System.SysUtils,
  TSWebDriver.Response;

type
  ITSWebDriverRequest = interface
    ['{AED0599D-2E89-4B73-9670-E3F2D434C61F}']
    function Post(AUrl: string; AData: string = '{}'): String;
    function Delete(AUrl: string; AData: string = ''): String;
    function Get(AUrl: string): String;
  end;

  TTSWebDriverRequest = class(TInterfacedObject, ITSWebDriverRequest)
  private
    FResponse: TTSResponse;
    FNetHTTPClient: TNetHTTPClient;
    function HandleResponse(AJson: String): string;
  public
    class function New(): ITSWebDriverRequest;
    constructor Create();
    destructor Destroy(); override;
    function Post(AUrl: string; AData: string = '{}'): String;
    function Delete(AUrl: string; AData: string = ''): String;
    function Get(AUrl: string): String;
  end;

implementation

{ TTSWebDriverRequest }

constructor TTSWebDriverRequest.Create();
begin
  FResponse := TTSResponse.Create();
  FNetHTTPClient := TNetHTTPClient.Create(nil);

  with FNetHTTPClient do
  begin
    ContentType := 'application/json';
    AcceptEncoding := 'UTF-8';
    ConnectionTimeout := 10000;
    SendTimeout := 10000;
    ResponseTimeout := 10000;
  end;
end;

destructor TTSWebDriverRequest.Destroy();
begin
  FreeAndNil(FResponse);
  FreeAndNil(FNetHTTPClient);
  inherited;
end;

function TTSWebDriverRequest.Get(AUrl: string): String;
begin
  Result := FNetHTTPClient.Get(AUrl).ContentAsString();
  Result := HandleResponse(Result);
end;

function TTSWebDriverRequest.Post(AUrl: string; AData: string = '{}'): String;
var
  lData: TStringStream;
begin
  try
    lData := TStringStream.Create(AData, TEncoding.UTF8);
    Result := FNetHTTPClient.Post(AUrl, lData).ContentAsString();
    Result := HandleResponse(Result);
  finally
    FreeAndNil(lData);
  end;
end;

function TTSWebDriverRequest.Delete(AUrl: string; AData: string = ''): String;
var
  lData: TStringStream;
begin
  try
    lData := TStringStream.Create(AData, TEncoding.UTF8);
    Result := FNetHTTPClient.Delete(AUrl, lData).ContentAsString();
    Result := HandleResponse(Result);
  finally
    FreeAndNil(lData);
  end;
end;

function TTSWebDriverRequest.HandleResponse(AJson: String): string;
begin
  Result := EmptyStr;
  try
    FResponse.Validate(AJson);
  finally
    Result := FResponse.Value;
  end;
end;

class function TTSWebDriverRequest.New: ITSWebDriverRequest;
begin
  Result := Self.Create();
end;

end.
