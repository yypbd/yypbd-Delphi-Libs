object FormShellKnownPathExampleMain: TFormShellKnownPathExampleMain
  Left = 0
  Top = 0
  Caption = 'FormShellKnownPathExampleMain'
  ClientHeight = 300
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 32
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 32
    Top = 76
    Width = 541
    Height = 209
    ImeName = 'Microsoft Office IME 2007'
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
