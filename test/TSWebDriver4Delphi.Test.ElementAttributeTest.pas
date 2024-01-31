unit TSWebDriver4Delphi.Test.ElementAttributeTest;

interface

uses
  DUnitX.TestFramework, TSWebDriver4Delphi.Test.Utils,
  TSWebDriver.IElement, TSWebDriver.By, TSWebDriver.Utils,
  TSWebDriver4Delphi.Test.Driver;

type
  [TestFixture]
  TElementAttributeTest = class
  private
    By: TSBy;
  public
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

procedure TElementAttributeTest.Setup;
begin
  TDriverTest.ChromeDriver.NewSession();
end;

procedure TElementAttributeTest.TearDown;
begin
  TDriverTest.ChromeDriver.CloseSession();
end;

/// <summary>
/// Deve retornar nulo ao obter o valor de um atributo que não está listado
/// </summary>
procedure TElementAttributeTest.ShouldReturnNullWhenGettingTheValueOfAnAttributeThatIsNotListed;
var
  lhead: ITSWebDriverElement;
  lattribute: string;
begin
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  lhead := TDriverTest.ChromeDriver.FindElement(By.Xpath('/html'));
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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  limg := TDriverTest.ChromeDriver.FindElement(By.Id('invalidImgTag'));
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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  limg := TDriverTest.ChromeDriver.FindElement(By.Id('validImgTag'));
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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  limg := TDriverTest.ChromeDriver.FindElement(By.Id('validAnchorTag'));
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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('simpleTest.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  lbody := TDriverTest.ChromeDriver.FindElement(By.XPath('//body'));

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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  linputElement := TDriverTest.ChromeDriver.FindElement(By.XPath('//input[@id=''working'']'));

  Assert.AreEqual('null', linputElement.GetAttribute('disabled'));
  Assert.IsTrue(linputElement.GetEnabled(), 'Element is not enabled');

  lPElement := TDriverTest.ChromeDriver.FindElement(By.Id('peas'));

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
    TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
    TDriverTest.ChromeDriver.WaitForPageReady();

    lMultiSelect := TDriverTest.ChromeDriver.FindElement(By.Id('multi'));
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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  linputElement := TDriverTest.ChromeDriver.FindElement(By.XPath('//input[@id=''notWorking'']'));
  Assert.IsFalse(linputElement.GetEnabled(), 'Element should be disabled');

  linputElement := TDriverTest.ChromeDriver.FindElement(By.XPath('//input[@id=''working'']'));
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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  lDisabledTextElement1 := TDriverTest.ChromeDriver.FindElement(By.Id('disabledTextElement1'));
  Assert.IsFalse(lDisabledTextElement1.GetEnabled(), 'disabledTextElement1 should be disabled');

  lDisabledTextElement2 := TDriverTest.ChromeDriver.FindElement(By.Id('disabledTextElement2'));
  Assert.IsFalse(lDisabledTextElement2.GetEnabled(), 'disabledTextElement2 should be disabled');

  lDisabledTextElement3 := TDriverTest.ChromeDriver.FindElement(By.Id('disabledSubmitElement'));
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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  ldisabledTextElement1 := TDriverTest.ChromeDriver.FindElement(By.Id('disabledTextElement1'));

  try
    ldisabledTextElement1.SendKeys('foo');
    Assert.Fail('Should have thrown exception');
  except
    //Expected
  end;

  Assert.AreEqual(EmptyStr, ldisabledTextElement1.GetText());

  ldisabledTextElement2 := TDriverTest.ChromeDriver.FindElement(By.Id('disabledTextElement2'));

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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  ltextArea := TDriverTest.ChromeDriver.FindElement(By.XPath('//textarea[@id=''notWorkingArea'']'));
  
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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  lEnabled := TDriverTest.ChromeDriver.FindElement(By.Name('selectomatic'));
  lDisabled := TDriverTest.ChromeDriver.FindElement(By.Name('no-select'));

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
  TDriverTest.ChromeDriver.NavigateTo(MakeUrlFile('formPage.html'));
  TDriverTest.ChromeDriver.WaitForPageReady();

  lCheckbox := TDriverTest.ChromeDriver.FindElement(By.XPath('//input[@id=''checky'']'));

  // Verifique se o atributo "checked" é nulo (null) inicialmente
  Assert.AreEqual('null', lCheckbox.GetAttribute('checked'));

  // Clique na caixa de seleção
  lCheckbox.Click();

  // Verifique se o atributo "checked" agora é "true" após o clique
  Assert.AreEqual('true', lCheckbox.GetAttribute('checked'));
end;

initialization
  TDUnitX.RegisterTestFixture(TElementAttributeTest);

end.
