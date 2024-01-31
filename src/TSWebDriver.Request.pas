unit TSWebDriver.Request;

interface

uses
  System.SysUtils, TSWebDriver.Response;

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

uses RESTRequest4D;

constructor TTSWebDriverRequest.Create();
begin
  FResponse := TTSResponse.Create();
end;

destructor TTSWebDriverRequest.Destroy();
begin
  FreeAndNil(FResponse);
  inherited;
end;

function TTSWebDriverRequest.Get(AUrl: string): String;
begin
  Result := HandleResponse(
    TRequest.New.BaseURL(AUrl).Get().Content
  );
end;

function TTSWebDriverRequest.Post(AUrl: string; AData: string = '{}'): String;
begin
  Result := HandleResponse(
    TRequest
    .New
    //.RaiseExceptionOn500(False)
    .BaseURL(AUrl)
    .AddBody(AData)
    .Post()
    .Content()
  );
end;

function TTSWebDriverRequest.Delete(AUrl: string; AData: string = ''): String;
begin
  Result := HandleResponse(
    TRequest.New.BaseURL(AUrl).AddBody(AData).Delete().Content()
  );
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
