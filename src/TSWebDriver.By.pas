unit TSWebDriver.By;

interface

uses
  System.SysUtils;

type
  TSBy = record
  private
    FUsingName: string;
    FKeyName: string;
  public
    function Id(AValue: string): TSBy;
    function Name(AValue: string): TSBy;
    function TagName(AValue: string): TSBy;
    function ClassName(AValue: string): TSBy;
    function Xpath(AValue: string): TSBy;
    function LinkText(AValue: string): TSBy;
    function CssSelector(AValue: string): TSBy;
    function PartialLinkText(AValue: string): TSBy;
    property UsingName: string read FUsingName;
    property KeyName: string read FKeyName;
  end;

implementation

{ TSBy }

function TSBy.ClassName(AValue: string): TSBy;
begin
  FUsingName := 'css selector';
  FKeyName := Format('.%s', [AValue]);
  Result := Self;
end;

function TSBy.CssSelector(AValue: string): TSBy;
begin
  FUsingName := 'css selector';
  FKeyName := AValue;
  Result := Self;
end;

function TSBy.Id(AValue: string): TSBy;
begin
  FUsingName := 'css selector';
  FKeyName := Format('[id=''%s'']', [AValue]);
  Result := Self;
end;

function TSBy.LinkText(AValue: string): TSBy;
begin
  FUsingName := 'link text';
  FKeyName := AValue;
  Result := Self;
end;

function TSBy.Name(AValue: string): TSBy;
begin
  FUsingName := 'css selector';
  FKeyName := Format('[name=''%s'']', [AValue]);
  Result := Self;
end;

function TSBy.PartialLinkText(AValue: string): TSBy;
begin
  FUsingName := 'partial link text';
  FKeyName := AValue;
  Result := Self;
end;

function TSBy.TagName(AValue: string): TSBy;
begin
  FUsingName := 'tag name';
  FKeyName := AValue;
  Result := Self;
end;

function TSBy.Xpath(AValue: string): TSBy;
begin
  FUsingName := 'xpath';
  FKeyName := AValue;
  Result := Self;
end;

end.
