unit TSWebDriver.Response;

interface

uses
  System.SysUtils, System.JSON;

{$M+}

type
  TTSResponse = class
  private
    FValue: string;
  public
    procedure Validate(const AHttpResponse: string);
  published
    property Value: string read FValue;
  end;

implementation

{ TTSResponse }

procedure TTSResponse.Validate(const AHttpResponse: string);
var
  lJsonResponse: TJsonValue;
  lJsonValue: TJSONValue;
begin
  FValue := EmptyStr;

  try
    if not AHttpResponse.StartsWith('{') and not AHttpResponse.StartsWith('[') then
      raise Exception.Create('Invalid JSON');

    lJsonResponse := TJSONObject.ParseJSONValue(AHttpResponse) as TJsonObject;

    if not lJsonResponse.TryGetValue<TJSONValue>('value', lJsonValue) then
      raise Exception.Create('"value" key not found');

    if Assigned(lJsonResponse.FindValue('value.error')) then
      raise Exception.Create(lJsonResponse.GetValue<String>('value.message'));

    if (lJsonValue is TJSONArray) or (lJsonValue is TJSONObject) then
      FValue := lJsonValue.ToJson()
    else
      FValue := lJsonValue.Value;
  finally
    FreeAndNil(lJsonResponse);
  end;
end;

end.
