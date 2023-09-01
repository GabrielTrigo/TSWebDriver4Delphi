unit TSWebDriver.Consts;

interface

uses System.Generics.Collections, System.SysUtils;

type
  TW3C_COMMAND_MAP = (NEW_SESSION, QUIT, GET_SERVER_STATUS, GET_TIMEOUT, SET_TIMEOUT, GET_CURRENT_URL, GET_URL,
    GO_BACK, GO_FORWARD, REFRESH, GET_PAGE_SOURCE, GET_TITLE, EXECUTE_SCRIPT, EXECUTE_ASYNC_SCRIPT,
    SWITCH_TO_FRAME, SWITCH_TO_FRAME_PARENT, GET_CURRENT_WINDOW_HANDLE, CLOSE, SWITCH_TO_WINDOW,
    SWITCH_TO_NEW_WINDOW, GET_WINDOW_HANDLES, GET_WINDOW_RECT, SET_WINDOW_RECT, MAXIMIZE_WINDOW,
    MINIMIZE_WINDOW, FULLSCREEN_WINDOW, ACTIONS, CLEAR_ACTIONS, PRINT_PAGE, GET_ACTIVE_ELEMENT,
    FIND_ELEMENT, FIND_ELEMENTS, FIND_ELEMENTS_RELATIVE, FIND_CHILD_ELEMENT, FIND_CHILD_ELEMENTS,
    GET_ELEMENT_TAG_NAME, GET_ELEMENT_ATTRIBUTE, GET_ELEMENT_PROPERTY,
    GET_ELEMENT_VALUE_OF_CSS_PROPERTY, GET_ELEMENT_RECT, CLEAR_ELEMENT, CLICK_ELEMENT,
    SEND_KEYS_TO_ELEMENT, GET_ELEMENT_TEXT, GET_COMPUTED_ROLE, GET_COMPUTED_LABEL, IS_ELEMENT_ENABLED,
    IS_ELEMENT_SELECTED, IS_ELEMENT_DISPLAYED, GET_ALL_COOKIES, ADD_COOKIE, DELETE_ALL_COOKIES,
    GET_COOKIE, DELETE_COOKIE, ACCEPT_ALERT, DISMISS_ALERT, GET_ALERT_TEXT, SET_ALERT_TEXT, SCREENSHOT,
    TAKE_ELEMENT_SCREENSHOT, GET_SHADOW_ROOT, FIND_ELEMENT_FROM_SHADOWROOT, FIND_ELEMENTS_FROM_SHADOWROOT,
    GET_LOG, GET_AVAILABLE_LOG_TYPES, UPLOAD_FILE, ADD_VIRTUAL_AUTHENTICATOR, REMOVE_VIRTUAL_AUTHENTICATOR,
    ADD_CREDENTIAL, GET_CREDENTIALS, REMOVE_CREDENTIAL, REMOVE_ALL_CREDENTIALS, SET_USER_VERIFIED);

const
  BASE_URL = 'http://localhost:9515';

  NEW_SESSION_JSON =
    '{' +
      '"capabilities":{' +
        '"browserName":"chrome",' +
        '"platformName":"windows",' +
        '"alwaysMatch":{' +
        '"goog:chromeOptions":{' +
            '"args":[' +
            '"--allow-pre-commit-input",' +
            '"--disable-background-networking",' +
            '"--disable-background-timer-throttling",' +
            '"--disable-backgrounding-occluded-windows",' +
            '"--disable-breakpad",' +
            '"--disable-client-side-phishing-detection",' +
            '"--disable-component-extensions-with-background-pages",' +
            '"--disable-component-update",' +
            '"--disable-default-apps",' +
            '"--disable-dev-shm-usage",' +
            '"--disable-extensions",' +
            '"--disable-features=Translate,BackForwardCache,AcceptCHFrame,MediaRouter,OptimizationHints",' +
            '"--disable-hang-monitor",' +
            '"--disable-ipc-flooding-protection",' +
            '"--disable-popup-blocking",' +
            '"--disable-prompt-on-repost",' +
            '"--disable-renderer-backgrounding",' +
            '"--disable-sync",' +
            '"--enable-automation",' +
            '"--enable-blink-features=IdleDetection",' +
            '"--enable-features=NetworkServiceInProcess2",' +
            '"--export-tagged-pdf",' +
            '"--force-color-profile=srgb",' +
            '"--metrics-recording-only",' +
            '"--no-first-run",' +
            '"--password-store=basic",' +
            '"--use-mock-keychain",' +
            '"--remote-debugging-port=0"' +
            '@extra_args' +
            ']' +
          '}' +
        '}' +
      '}' +
    '}';

var
  CommandMap: TDictionary<TW3C_COMMAND_MAP, string>;

implementation

procedure InitializeCommandMap();
begin
  CommandMap := TDictionary<TW3C_COMMAND_MAP, string>.Create();

  // Session management
  CommandMap.Add(NEW_SESSION, '/session');
  CommandMap.Add(QUIT, '/session/:sessionId');

  // Server status
  CommandMap.Add(GET_SERVER_STATUS, '/status');

  // Timeouts
  CommandMap.Add(GET_TIMEOUT, '/session/:sessionId/timeouts');
  CommandMap.Add(SET_TIMEOUT, '/session/:sessionId/timeouts');

  // Navigation
  CommandMap.Add(GET_CURRENT_URL, '/session/:sessionId/url');
  CommandMap.Add(GET_URL, '/session/:sessionId/url');
  CommandMap.Add(GO_BACK, '/session/:sessionId/back');
  CommandMap.Add(GO_FORWARD, '/session/:sessionId/forward');
  CommandMap.Add(REFRESH, '/session/:sessionId/refresh');

  // Page inspection
  CommandMap.Add(GET_PAGE_SOURCE, '/session/:sessionId/source');
  CommandMap.Add(GET_TITLE, '/session/:sessionId/title');

  // Script execution
  CommandMap.Add(EXECUTE_SCRIPT, '/session/:sessionId/execute/sync');
  CommandMap.Add(EXECUTE_ASYNC_SCRIPT, '/session/:sessionId/execute/async');

  // Frame selection
  CommandMap.Add(SWITCH_TO_FRAME, '/session/:sessionId/frame');
  CommandMap.Add(SWITCH_TO_FRAME_PARENT, '/session/:sessionId/frame/parent');

  // Window management
  CommandMap.Add(GET_CURRENT_WINDOW_HANDLE, '/session/:sessionId/window');
  CommandMap.Add(CLOSE, '/session/:sessionId/window');
  CommandMap.Add(SWITCH_TO_WINDOW, '/session/:sessionId/window');
  CommandMap.Add(SWITCH_TO_NEW_WINDOW, '/session/:sessionId/window/new');
  CommandMap.Add(GET_WINDOW_HANDLES, '/session/:sessionId/window/handles');
  CommandMap.Add(GET_WINDOW_RECT, '/session/:sessionId/window/rect');
  CommandMap.Add(SET_WINDOW_RECT, '/session/:sessionId/window/rect');
  CommandMap.Add(MAXIMIZE_WINDOW, '/session/:sessionId/window/maximize');
  CommandMap.Add(MINIMIZE_WINDOW, '/session/:sessionId/window/minimize');
  CommandMap.Add(FULLSCREEN_WINDOW, '/session/:sessionId/window/fullscreen');

  // Actions
  CommandMap.Add(ACTIONS, '/session/:sessionId/actions');
  CommandMap.Add(CLEAR_ACTIONS, '/session/:sessionId/actions');
  CommandMap.Add(PRINT_PAGE, '/session/:sessionId/print');

  // Locating elements
  CommandMap.Add(GET_ACTIVE_ELEMENT, '/session/:sessionId/element/active');
  CommandMap.Add(FIND_ELEMENT, '/session/:sessionId/element');
  CommandMap.Add(FIND_ELEMENTS, '/session/:sessionId/elements');
  CommandMap.Add(FIND_ELEMENTS_RELATIVE, '/session/:sessionId/element/:id/element');
  CommandMap.Add(FIND_CHILD_ELEMENT, '/session/:sessionId/element/:id/element');
  CommandMap.Add(FIND_CHILD_ELEMENTS, '/session/:sessionId/element/:id/elements');
  CommandMap.Add(SEND_KEYS_TO_ELEMENT, '/session/:sessionId/element/:id/value');
  CommandMap.Add(CLICK_ELEMENT, '/session/:sessionId/element/:id/click');

  CommandMap.Add(GET_ELEMENT_ATTRIBUTE, '/session/:sessionId/element/:id/attribute/:attributeName');
  CommandMap.Add(GET_ELEMENT_PROPERTY, '/session/:sessionId/element/:id/property/:propertyName');
  CommandMap.Add(GET_ELEMENT_VALUE_OF_CSS_PROPERTY, '/session/:sessionId/element/:id/css/:propertyName');
  CommandMap.Add(GET_ELEMENT_TEXT, '/session/:sessionId/element/:id/text');
  CommandMap.Add(GET_ELEMENT_TAG_NAME, '/session/:sessionId/element/:id/name');
  CommandMap.Add(IS_ELEMENT_ENABLED, '/session/:sessionId/element/:id/enabled');
end;

initialization
  InitializeCommandMap();

finalization
  FreeAndNil(CommandMap);

end.

