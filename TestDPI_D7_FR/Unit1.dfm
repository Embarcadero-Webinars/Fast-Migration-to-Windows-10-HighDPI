object Form1: TForm1
  Left = 255
  Top = 249
  Width = 530
  Height = 429
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 104
    Top = 16
    Width = 395
    Height = 363
    Caption = 'Panel1'
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 393
      Height = 361
      OnPaint = PaintBox1Paint
    end
  end
  object Button1: TButton
    Left = 8
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Draw'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 64
    Width = 89
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'ComboBox1'
  end
  object Edit1: TEdit
    Left = 8
    Top = 96
    Width = 89
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 128
    Width = 81
    Height = 17
    Caption = 'RadioButton1'
    TabOrder = 4
  end
  object Button2: TButton
    Left = 8
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 5
    OnClick = Button2Click
  end
  object DateTimePicker1: TDateTimePicker
    Left = 8
    Top = 0
    Width = 186
    Height = 21
    Date = 43700.001267800920000000
    Time = 43700.001267800920000000
    TabOrder = 6
  end
  object XPManifest1: TXPManifest
    Left = 48
    Top = 272
  end
  object frxReport1: TfrxReport
    Version = '6.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43699.552166215280000000
    ReportOptions.LastChange = 43699.552166215280000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 16
    Top = 232
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 64
    Top = 240
  end
end
