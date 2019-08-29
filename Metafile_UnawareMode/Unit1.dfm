object Form1: TForm1
  Left = 255
  Top = 249
  Caption = 'Form1'
  ClientHeight = 390
  ClientWidth = 514
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
end
