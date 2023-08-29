object Form1: TForm1
  Left = 0
  Top = 0
  ClientHeight = 413
  ClientWidth = 827
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object btnNewSection: TButton
    Left = 8
    Top = 99
    Width = 120
    Height = 25
    Caption = 'New Section'
    TabOrder = 0
    OnClick = btnNewSectionClick
  end
  object Memo1: TMemo
    Left = 134
    Top = 37
    Width = 557
    Height = 368
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'JetBrains Mono'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object edtSessionId: TEdit
    Left = 8
    Top = 8
    Width = 683
    Height = 23
    TabOrder = 2
    OnChange = edtSessionIdChange
  end
  object btnNavigateTo: TButton
    Left = 8
    Top = 161
    Width = 120
    Height = 25
    Caption = 'Navigate To'
    TabOrder = 3
    OnClick = btnNavigateToClick
  end
  object btnExecuteScript: TButton
    Left = 8
    Top = 192
    Width = 120
    Height = 25
    Caption = 'Execute Script'
    TabOrder = 4
    OnClick = btnExecuteScriptClick
  end
  object btnCloseSession: TButton
    Left = 8
    Top = 130
    Width = 120
    Height = 25
    Caption = 'Close Session'
    TabOrder = 5
    OnClick = btnCloseSessionClick
  end
  object btnLauch: TButton
    Left = 8
    Top = 37
    Width = 120
    Height = 25
    Caption = 'Launch'
    TabOrder = 6
    OnClick = btnLauchClick
  end
  object btnClose: TButton
    Left = 8
    Top = 68
    Width = 120
    Height = 25
    Caption = 'Close'
    TabOrder = 7
    OnClick = btnCloseClick
  end
  object btnFindElement: TButton
    Left = 8
    Top = 223
    Width = 120
    Height = 25
    Caption = 'Find Element'
    TabOrder = 8
    OnClick = btnFindElementClick
  end
  object btnFindElements: TButton
    Left = 8
    Top = 254
    Width = 120
    Height = 25
    Caption = 'Find Elements'
    TabOrder = 9
    OnClick = btnFindElementsClick
  end
  object btnElementClick: TButton
    Left = 8
    Top = 285
    Width = 120
    Height = 25
    Caption = 'Element Click'
    TabOrder = 10
    OnClick = btnElementClickClick
  end
  object btnElementSendKeys: TButton
    Left = 8
    Top = 316
    Width = 120
    Height = 25
    Caption = 'Element Send Keys'
    TabOrder = 11
    OnClick = btnElementSendKeysClick
  end
  object btnTakeScreenshot: TButton
    Left = 8
    Top = 347
    Width = 120
    Height = 25
    Caption = 'Take Screenshot'
    TabOrder = 12
    OnClick = btnTakeScreenshotClick
  end
  object btnInjectWppScript: TButton
    Left = 8
    Top = 380
    Width = 120
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Inject wpp script'
    TabOrder = 13
    OnClick = btnInjectWppScriptClick
  end
  object btnRunSequence: TButton
    Left = 697
    Top = 99
    Width = 120
    Height = 25
    Caption = 'Run Sequence'
    TabOrder = 14
    OnClick = btnRunSequenceClick
  end
  object btnStatus: TButton
    Left = 697
    Top = 37
    Width = 120
    Height = 25
    Caption = 'Status'
    TabOrder = 15
    OnClick = btnStatusClick
  end
  object btnIsRunning: TButton
    Left = 697
    Top = 68
    Width = 120
    Height = 25
    Caption = 'Is Running'
    TabOrder = 16
    OnClick = btnIsRunningClick
  end
  object Button1: TButton
    Left = 697
    Top = 130
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 17
    OnClick = Button1Click
  end
end
