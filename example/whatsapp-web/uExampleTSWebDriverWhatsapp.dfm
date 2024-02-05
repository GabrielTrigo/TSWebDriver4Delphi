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
    ExplicitLeft = 0
    ExplicitTop = 10
  end
  object Button1: TButton
    Left = 8
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 89
    Top = 41
    Width = 75
    Height = 25
    Caption = 'getChats'
    TabOrder = 2
    OnClick = Button2Click
  end
end
