[![stability-alpha](https://img.shields.io/badge/stability-alpha-f4d03f.svg)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#alpha)

# TSWebDriver4Delphi
This library was inspired by [Selenium](https://github.com/SeleniumHQ/selenium)

TSWebDriver4Delphi is a comprehensive project that encapsulates a variety of tools that enable web browser automation. Specifically provides an infrastructure for the W3C WebDriver specification - a platform and language-neutral coding interface compatible with the Chrome browser (for now, only Chrome).

Demo
--
Login and E-commerce scraping
![ezgif com-video-to-gif (2)](https://github.com/GabrielTrigo/TSWebDriver4Delphi/assets/43503837/912ca229-ad64-4fb5-b33c-6cdb3af65d5f)


What is WebDriver? 
--
_WebDriver is a remote control interface that enables introspection and control of user agents. It provides a platform- and language-neutral wire protocol as a way for out-of-process programs to remotely instruct the behavior of web browsers._

_Provided is a set of interfaces to discover and manipulate DOM elements in web documents and to control the behavior of a user agent. It is primarily intended to allow web authors to write tests that automate a user agent from a separate controlling process, but may also be used in such a way as to allow in-browser scripts to control a — possibly separate — browser._

## Example
Search automation
```delphi
  FChromeDriver.NavigateTo('https://letcode.in/elements');
  FChromeDriver.WaitForPageReady();

  lElement := FChromeDriver.FindElement(FBy.ClassName('search-box__input'));

  lElement.SendKeys('automate');

  FChromeDriver.WaitForSelector('.search-box__link');

  lElement := FChromeDriver.FindElement(FBy.ClassName('search-box__link'));

  lElement.Click();
```

## Features

- Browser
  - Execute
  - NewSession
  - CloseSection
  - NavigateTo
  - ExecuteSyncScript
  - ExecuteAsyncScript
  - SessionID (sobrecarga)
  - FindElement
  - FindElements
  - TakeScreenshot
  - Status
  - AddArgument
  - WaitForSelector
  - GetPageSource
  - WaitForPageReady
  - Refresh
  - Forward
  - Back
  - PrintPage
  - GetTitle
  - GetCurrentUrl
- Element
  - Cross
  - GetTagName
  - GetText
  - GetEnabled
  - GetSelected
  - GetLocation
  - GetSize
  - GetDisplayed
  - Clear
  - SendKeys
  - Submit
  - Click
  - GetAttribute
  - GetProperty
  - GetDomAttribute
  - GetCssValue
  - LoadFromJson
  - IsEmpty
  - FindElement(in current element)
  - FindElements(in current element)

## Supporting documents

 - [Official WebDriver documentation W3C](https://w3c.github.io/webdriver)
 - [ChromeDriver docs and download](https://chromedriver.chromium.org/home)
 - [Selenium documentation](https://www.selenium.dev/documentation)
 - [W3C WebDriver Spec](https://github.com/jlipps/simple-wd-spec)


## Tests
<img src="https://github.com/GabrielTrigo/TSWebDriver4Delphi/assets/43503837/bcc0d718-92e2-4107-a074-7f4fcd89c712" alt="drawing" width="500"/>

