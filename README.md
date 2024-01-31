[![stability-alpha](https://img.shields.io/badge/stability-alpha-f4d03f.svg?style=for-the-badge)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#alpha)
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

# TSWebDriver4Delphi
This library was inspired by [Selenium](https://github.com/SeleniumHQ/selenium) and [Puppeteer](https://pptr.dev)

TSWebDriver4Delphi is a comprehensive project that encapsulates a variety of tools that enable web browser automation. Specifically provides an infrastructure for the W3C WebDriver specification - a platform and language-neutral coding interface compatible with the Chrome browser (for now, only Chrome).


# What is WebDriver? 
_WebDriver is a remote control interface that enables introspection and control of user agents. It provides a platform- and language-neutral wire protocol as a way for out-of-process programs to remotely instruct the behavior of web browsers._

_Provided is a set of interfaces to discover and manipulate DOM elements in web documents and to control the behavior of a user agent. It is primarily intended to allow web authors to write tests that automate a user agent from a separate controlling process, but may also be used in such a way as to allow in-browser scripts to control a — possibly separate — browser._


# Demo
![ezgif com-video-to-gif (2)](https://github.com/GabrielTrigo/TSWebDriver4Delphi/assets/43503837/912ca229-ad64-4fb5-b33c-6cdb3af65d5f)


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
