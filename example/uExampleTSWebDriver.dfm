object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Example TSWebDriver4Delphi'
  ClientHeight = 351
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object MemLog: TMemo
    AlignWithMargins = True
    Left = 5
    Top = 74
    Width = 518
    Height = 272
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'JetBrains Mono'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitTop = 65
    ExplicitWidth = 512
  end
  object btnNavigateTo: TButton
    Left = 8
    Top = 10
    Width = 120
    Height = 25
    Caption = 'Navigate To'
    TabOrder = 1
    OnClick = btnNavigateToClick
  end
  object btnExecuteScript: TButton
    Left = 8
    Top = 41
    Width = 120
    Height = 25
    Caption = 'Execute Script'
    TabOrder = 2
    OnClick = btnExecuteScriptClick
  end
  object btnExample4: TButton
    Left = 296
    Top = 41
    Width = 89
    Height = 25
    Caption = 'Mercado Livre'
    TabOrder = 3
    OnClick = btnExample4Click
  end
  object btnExample5: TButton
    Left = 296
    Top = 10
    Width = 75
    Height = 25
    Caption = 'Example 5'
    TabOrder = 4
    OnClick = btnExample5Click
  end
  object btnExample1: TButton
    Left = 134
    Top = 10
    Width = 75
    Height = 25
    Caption = 'Example 1'
    TabOrder = 5
    OnClick = btnExample1Click
  end
  object btnExample2: TButton
    Left = 134
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Example 2'
    TabOrder = 6
    OnClick = btnExample2Click
  end
  object btnExample3: TButton
    Left = 215
    Top = 10
    Width = 75
    Height = 25
    Caption = 'Example 3'
    TabOrder = 7
    OnClick = btnExample3Click
  end
  object Button1: TButton
    Left = 215
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 8
    OnClick = Button1Click
  end
end
