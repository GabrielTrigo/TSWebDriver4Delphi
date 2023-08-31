unit TSWebDriver4Delphi.Test.ElementAttributeTest;

interface

uses
  DUnitX.TestFramework, TSWebDriver4Delphi.Test.Utils,
  TSWebDriver.IElement, TSWebDriver.By, TSWebDriver.Utils,
  TSWebDriver4Delphi.Test.Base;

type
  [TestFixture]
  TElementAttributeTest = class(TBaseTest)
  private
    By: TSBy;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure ShouldReturnNullWhenGettingTheValueOfAnAttributeThatIsNotListed;
    [Test]
    procedure ShouldReturnNullWhenGettingSrcAttributeOfInvalidImgTag;
    [Test]
    procedure ShouldReturnAnAbsoluteUrlWhenGettingSrcAttributeOfAValidImgTag;
    [Test]
    procedure ShouldReturnAnAbsoluteUrlWhenGettingHrefAttributeOfAValidAnchorTag;
    [Test]
    procedure ShouldReturnEmptyAttributeValuesWhenPresentAndTheValueIsActuallyEmpty;
    [Test]
    procedure ShouldReturnTheValueOfTheDisabledAttributeAsNullIfNotSet;
    [Test]
    procedure ShouldReturnTheValueOfTheIndexAttrbuteEvenIfItIsMissing;
    [Test]
    procedure ShouldIndicateTheElementsThatAreDisabledAreNotEnabled;
    [Test]
    procedure ElementsShouldBeDisabledIfTheyAreDisabledUsingRandomDisabledStrings;
    [Test]
    procedure ShouldThrowExceptionIfSendingKeysToElementDisabledUsingRandomDisabledStrings;
    [Test]
    procedure ShouldIndicateWhenATextAreaIsDisabled;
    [Test]
    procedure ShouldIndicateWhenASelectIsDisabled;
    [Test]
    procedure ShouldReturnTheValueOfCheckedForACheckboxOnlyIfItIsChecked;
  end;

implementation

uses
  System.SysUtils;

constructor TElementAttributeTest.Create;
begin
  inherited;
end;

destructor TElementAttributeTest.Destroy;
begin
  inherited;
end;

procedure TElementAttributeTest.Setup;
begin
  ChromeDriver.NewSession();
end;

procedure TElementAttributeTest.TearDown;
begin
  if Driver.IsRunning and (ChromeDriver.SessionID <> EmptyStr) then
    ChromeDriver.CloseSection();
end;

/// <summary>
/// Deve retornar nulo ao obter o valor de um atributo que não está listado
/// </summary>
procedure TElementAttributeTest.ShouldReturnNullWhenGettingTheValueOfAnAttributeThatIsNotListed;
var
  lhead: ITSWebDriverElement;
  lattribute: string;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  ChromeDriver.WaitForPageReady();

  lhead := ChromeDriver.FindElement(By.Xpath('/html'));
  lattribute := lhead.GetAttribute('cheese');

  Assert.AreEqual('null', lattribute);
end;

/// <summary>
/// Deve retornar nulo ao obter o atributo src de tag inválida
/// </summary>
procedure TElementAttributeTest.ShouldReturnNullWhenGettingSrcAttributeOfInvalidImgTag;
var
  limg: ITSWebDriverElement;
  lattribute: string;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  ChromeDriver.WaitForPageReady();

  limg := ChromeDriver.FindElement(By.Id('invalidImgTag'));
  lattribute := limg.GetAttribute('src');

  Assert.AreEqual('null', lattribute);
end;

/// <summary>
/// Deve retornar um URL absoluto ao obter o atributo src de uma tag img válida
/// </summary>
procedure TElementAttributeTest.ShouldReturnAnAbsoluteUrlWhenGettingSrcAttributeOfAValidImgTag;
var
  limg: ITSWebDriverElement;
  lattribute: string;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  ChromeDriver.WaitForPageReady();

  limg := ChromeDriver.FindElement(By.Id('validImgTag'));
  lattribute := limg.GetAttribute('src');

  Assert.Contains(MakeUrlFile('icon.gif'), lattribute);
end;

/// <summary>
/// Deve retornar um URL absoluto ao obter o atributo href de uma tag âncora válida
/// </summary>
procedure TElementAttributeTest.ShouldReturnAnAbsoluteUrlWhenGettingHrefAttributeOfAValidAnchorTag;
var
  limg: ITSWebDriverElement;
  lattribute: string;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  ChromeDriver.WaitForPageReady();

  limg := ChromeDriver.FindElement(By.Id('validAnchorTag'));
  lattribute := limg.GetAttribute('href');

  Assert.Contains(MakeUrlFile('icon.gif'), lattribute);
end;

/// <summary>
/// Deve retornar valores de atributos vazios quando presentes e o valor estiver realmente vazio
/// </summary>
procedure TElementAttributeTest.ShouldReturnEmptyAttributeValuesWhenPresentAndTheValueIsActuallyEmpty;
var
  lbody: ITSWebDriverElement;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  ChromeDriver.WaitForPageReady();

  lbody := ChromeDriver.FindElement(By.XPath('//body'));

  Assert.IsEmpty(lbody.GetAttribute('style'));
end;

/// <summary>
/// Deve retornar o valor do atributo "disabled" como nulo se não for definido
/// </summary>
procedure TElementAttributeTest.ShouldReturnTheValueOfTheDisabledAttributeAsNullIfNotSet;
var
  linputElement: ITSWebDriverElement;
  lPElement: ITSWebDriverElement;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  ChromeDriver.WaitForPageReady();

  linputElement := ChromeDriver.FindElement(By.XPath('//input[@id=''working'']'));

  Assert.AreEqual('null', linputElement.GetAttribute('disabled'));
  Assert.IsTrue(linputElement.GetEnabled(), 'Element is not enabled');

  lPElement := ChromeDriver.FindElement(By.Id('peas'));

  Assert.AreEqual('null', lPElement.GetAttribute('disabled'));
  Assert.IsTrue(lPElement.GetEnabled(), 'Element is not enabled');
end;

/// <summary>
/// Deve retornar o valor do atributo do índice mesmo que esteja faltando
/// </summary>
procedure TElementAttributeTest.ShouldReturnTheValueOfTheIndexAttrbuteEvenIfItIsMissing;
var
  lMultiSelect: ITSWebDriverElement;
  lOptions: TTSWebDriverElementList;
begin
  try
    ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
    ChromeDriver.WaitForPageReady();

    lMultiSelect := ChromeDriver.FindElement(By.Id('multi'));
    lOptions := lMultiSelect.FindElements(By.TagName('option'));
    
    Assert.AreEqual('1', lOptions[1].GetAttribute('index'));
  finally
    if Assigned(lOptions) then
      FreeAndNil(lOptions);
  end;
end;

/// <summary>
/// Deve indicar que os elementos que estão desabilitados não estão habilitados
/// </summary>
procedure TElementAttributeTest.ShouldIndicateTheElementsThatAreDisabledAreNotEnabled;
var
  linputElement: ITSWebDriverElement;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  ChromeDriver.WaitForPageReady();

  linputElement := ChromeDriver.FindElement(By.XPath('//input[@id=''notWorking'']'));
  Assert.IsFalse(linputElement.GetEnabled(), 'Element should be disabled');

  linputElement := ChromeDriver.FindElement(By.XPath('//input[@id=''working'']'));
  Assert.IsTrue(linputElement.GetEnabled(), 'Element should be enabled');
end;

/// <summary>
/// Os elementos devem ser desativados se forem desativados usando strings aleatórias desativadas
/// </summary>
procedure TElementAttributeTest.ElementsShouldBeDisabledIfTheyAreDisabledUsingRandomDisabledStrings;
var
  lDisabledTextElement1: ITSWebDriverElement;
  lDisabledTextElement2: ITSWebDriverElement;
  lDisabledTextElement3: ITSWebDriverElement;
  lattribute: string;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  ChromeDriver.WaitForPageReady();

  lDisabledTextElement1 := ChromeDriver.FindElement(By.Id('disabledTextElement1'));
  Assert.IsFalse(lDisabledTextElement1.GetEnabled(), 'disabledTextElement1 should be disabled');

  lDisabledTextElement2 := ChromeDriver.FindElement(By.Id('disabledTextElement2'));
  Assert.IsFalse(lDisabledTextElement2.GetEnabled(), 'disabledTextElement2 should be disabled');

  lDisabledTextElement3 := ChromeDriver.FindElement(By.Id('disabledSubmitElement'));
  Assert.IsFalse(lDisabledTextElement3.GetEnabled(), 'disabledSubmitElement should be disabled');
end;

/// <summary>
///  Deve lançar uma exceção se enviar chaves para o elemento desativado usando strings aleatórias desativadas
/// </summary>
procedure TElementAttributeTest.ShouldThrowExceptionIfSendingKeysToElementDisabledUsingRandomDisabledStrings;
var
  ldisabledTextElement1: ITSWebDriverElement;
  ldisabledTextElement2: ITSWebDriverElement;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  ChromeDriver.WaitForPageReady();

  ldisabledTextElement1 := ChromeDriver.FindElement(By.Id('disabledTextElement1'));

  try
    ldisabledTextElement1.SendKeys('foo');
    Assert.Fail('Should have thrown exception');
  except
    //Expected
  end;

  Assert.AreEqual(EmptyStr, ldisabledTextElement1.GetText());

  ldisabledTextElement2 := ChromeDriver.FindElement(By.Id('disabledTextElement2'));

  try
    ldisabledTextElement2.SendKeys('bar');
    Assert.Fail('Should have thrown exception');
  except 
    //Expected
  end;

  Assert.AreEqual(EmptyStr, ldisabledTextElement2.GetText());  
end;

/// <summary>
/// Deve indicar quando uma "TextArea" está desativada
/// </summary>
procedure TElementAttributeTest.ShouldIndicateWhenATextAreaIsDisabled;
var
  ltextArea: ITSWebDriverElement;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  ChromeDriver.WaitForPageReady();

  ltextArea := ChromeDriver.FindElement(By.XPath('//textarea[@id=''notWorkingArea'']'));
  
  Assert.IsFalse(ltextArea.GetEnabled());
end;

/// <summary>
/// Deve indicar quando um "select" está desabilitado
/// </summary>
procedure TElementAttributeTest.ShouldIndicateWhenASelectIsDisabled;
var
  lEnabled: ITSWebDriverElement;
  lDisabled: ITSWebDriverElement;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  ChromeDriver.WaitForPageReady();

  lEnabled := ChromeDriver.FindElement(By.Name('selectomatic'));
  lDisabled := ChromeDriver.FindElement(By.Name('no-select'));

  Assert.IsTrue(lEnabled.GetEnabled(), 'Expected select element to be enabled');
  Assert.IsFalse(lDisabled.GetEnabled(), 'Expected select element to be disabled');
end;

/// <summary>
/// Deve retornar o valor de "checked" para um CheckBox somente se estiver marcada
/// </summary>
procedure TElementAttributeTest.ShouldReturnTheValueOfCheckedForACheckboxOnlyIfItIsChecked;
var
  lCheckbox: ITSWebDriverElement;
begin
  ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  ChromeDriver.WaitForPageReady();

  lCheckbox := ChromeDriver.FindElement(By.XPath('//input[@id=''checky'']'));

  // Verifique se o atributo "checked" é nulo (null) inicialmente
  Assert.AreEqual('null', lCheckbox.GetAttribute('checked'));

  // Clique na caixa de seleção
  lCheckbox.Click();
  lCheckbox.GetDisplayed();

  // Verifique se o atributo "checked" agora é "true" após o clique
  Assert.AreEqual('true', lCheckbox.GetAttribute('checked'));
end;

initialization
  TDUnitX.RegisterTestFixture(TElementAttributeTest);

end.
