[![stability-alpha](https://img.shields.io/badge/stability-alpha-f4d03f.svg)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#alpha)

# TSWebDriver4Delphi

TSWebDriver4Delphi is a comprehensive project that encapsulates a variety of tools and libraries that enable web browser automation. TSWebDriver4Delphi specifically provides an infrastructure for the W3C WebDriver specification - a platform and language-neutral coding interface compatible with the Chrome browser (for now, only Chrome).

What is WebDriver? 
--
WebDriver is a remote control interface that enables introspection and control of user agents. It provides a platform- and language-neutral wire protocol as a way for out-of-process programs to remotely instruct the behavior of web browsers.

Provided is a set of interfaces to discover and manipulate DOM elements in web documents and to control the behavior of a user agent. It is primarily intended to allow web authors to write tests that automate a user agent from a separate controlling process, but may also be used in such a way as to allow in-browser scripts to control a — possibly separate — browser.

This library was inspired by [Selenium](https://github.com/SeleniumHQ/selenium)

## Example
Login automation
```delphi
  FChromeDriver.NavigateTo('https://letcode.in/elements');
  FChromeDriver.WaitForPageReady();

  FChromeDriver.FindElement(FBy.Name('username')).SendKeys('GabrielTrigo');

  FChromeDriver.FindElement(FBy.ID('search')).Click();

  FChromeDriver.WaitForSelector('.media');

  with FChromeDriver.FindElement(FBy.CssSelector('.media-content > span')) do
  begin
    Memo1.Lines.AddPair('GitHub bio', GetText());
  end;
```

## Supporting documents

 - [Official WebDriver documentation W3C](https://w3c.github.io/webdriver)
 - [Selenium documentation](https://www.selenium.dev/documentation)
 - [W3C WebDriver Spec](https://github.com/jlipps/simple-wd-spec)


## Tests
<img src="https://github.com/GabrielTrigo/TSWebDriver4Delphi/assets/43503837/bcc0d718-92e2-4107-a074-7f4fcd89c712" alt="drawing" width="500"/>

