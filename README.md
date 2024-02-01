[![stability-alpha](https://img.shields.io/badge/stability-alpha-f4d03f.svg?style=for-the-badge)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#alpha)
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

# TSWebDriver4Delphi
This library was inspired by [Selenium](https://github.com/SeleniumHQ/selenium) and [Puppeteer](https://pptr.dev)

TSWebDriver4Delphi is a project that encapsulates a variety of tools enabling web browser automation (for now, only Chrome). It specifically provides an infrastructure for the W3C WebDriver specification. With an approach similar to Selenium, TSWebDriver4Delphi allows the automation of interactions with user interface elements, making tests more efficient and reliable.


# What is WebDriver? 
_WebDriver is a remote control interface that enables introspection and control of user agents. It provides a platform- and language-neutral wire protocol as a way for out-of-process programs to remotely instruct the behavior of web browsers._

_Provided is a set of interfaces to discover and manipulate DOM elements in web documents and to control the behavior of a user agent. It is primarily intended to allow web authors to write tests that automate a user agent from a separate controlling process, but may also be used in such a way as to allow in-browser scripts to control a — possibly separate — browser._

## Why?
The conception of this project originated from the need to perform "Web scraping" on a specific website. Although there are numerous options for this task, such as Selenium with Python, Puppeteer in Node.JS, and Playwright in C#, the question arose: what about Delphi?
I chose not to resort to the renowned CEF4Delphi, seeking a lighter alternative with fewer dependencies. I wanted a solution that efficiently addressed the demands, providing a more agile and uncomplicated experience.
In this scenario, I developed this tool in Delphi to simplify my work.

<!-- GETTING STARTED -->
## Getting Started

```
⚠️ Attention: The project is still in the alpha stage. Classes and methods may undergo changes during development.
```

Clone the repository and ensure that dependencies are up to date
```git
git clone git@github.com:GabrielTrigo/TSWebDriver4Delphi.git
git submodule init
git submodule update
```

Visit the official download page of your browser's WebDriver (currently, only for Chrome) and download the driver that corresponds to the version installed on your computer.

To find your Chrome browser version, follow these steps: go to Settings > Help > About Google Chrome. For instance, the version might be something like 121.0.6167.140 (Official Build) 64-bit. Make sure to download the WebDriver that matches this specific version to ensure proper integration with your development environment.

[Chrome WebDriver Downloads](https://chromedriver.chromium.org/downloads)

### Usage

  ```delphi
  var
    FDriver: ITSWebDriverBase;
    FChromeDriver: ITSWebDriverBrowser;
  begin
    FDriver := TTSWebDriver.New.Driver();
    FDriver.Options.DriverPath('your-path\webdriver.exe');

    FChromeDriver := FDriver.Browser().Chrome();
  end;
  ```
📌 See the example project (`\example\ExampleTSWebDriver`) and the test project (`\test\TSWebDriver4DelphiTests`)

# Demo
_Scraping Mercado Livre site_
<br/>
![demo)](img/Demo_TSWebDriver4Delphi-ezgif.com-video-to-gif-converter.gif)


# Example
```delphi
  FChromeDriver.NavigateTo('https://letcode.in/elements');
  FChromeDriver.WaitForPageReady();

  LElement := FChromeDriver.FindElement(FBy.ClassName('search-box__input'));

  LElement.SendKeys('automate');

  FChromeDriver.WaitForSelector('.search-box__link');

  LElement := FChromeDriver.FindElement(FBy.ClassName('search-box__link'));

  LElement.Click();
```

# Supporting documents

 - [Official WebDriver documentation W3C](https://w3c.github.io/webdriver)
 - [ChromeDriver docs and download](https://chromedriver.chromium.org/home)
 - [Selenium documentation](https://www.selenium.dev/documentation)
 - [W3C WebDriver Spec](https://github.com/jlipps/simple-wd-spec)


# Tests
<img src="https://github.com/GabrielTrigo/TSWebDriver4Delphi/assets/43503837/bcc0d718-92e2-4107-a074-7f4fcd89c712" alt="drawing" width="500"/>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/GabrielTrigo/TSWebDriver4Delphi.svg?style=for-the-badge
[contributors-url]: https://github.com/GabrielTrigo/TSWebDriver4Delphi/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/GabrielTrigo/TSWebDriver4Delphi.svg?style=for-the-badge
[forks-url]: https://github.com/GabrielTrigo/TSWebDriver4Delphi/network/members
[stars-shield]: https://img.shields.io/github/stars/GabrielTrigo/TSWebDriver4Delphi.svg?style=for-the-badge
[stars-url]: https://github.com/GabrielTrigo/TSWebDriver4Delphi/stargazers
[issues-shield]: https://img.shields.io/github/issues/GabrielTrigo/TSWebDriver4Delphi.svg?style=for-the-badge
[issues-url]: https://github.com/GabrielTrigo/TSWebDriver4Delphi/issues
[license-shield]: https://img.shields.io/github/license/GabrielTrigo/TSWebDriver4Delphi.svg?style=for-the-badge
[license-url]: https://github.com/GabrielTrigo/TSWebDriver4Delphi/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/gabriel-trigo-982968161
[product-screenshot]: images/screenshot.png
