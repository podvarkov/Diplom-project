object Form1: TForm1
  Left = 214
  Top = 146
  Width = 696
  Height = 480
  Caption = 'LEVEL '
  Color = 12910532
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 800
    Height = 600
  end
  object MediaPlayer1: TMediaPlayer
    Left = 240
    Top = 56
    Width = 253
    Height = 30
    AutoEnable = False
    Visible = False
    TabOrder = 0
  end
  object MobTimer: TTimer
    Interval = 300
    OnTimer = MobTimerTimer
    Left = 72
    Top = 64
  end
  object LoadTimer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = LoadTimerTimer
    Left = 152
    Top = 120
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 75
    OnTimer = Timer1Timer
    Left = 64
    Top = 208
  end
  object detonator: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = detonatorTimer
    Left = 160
    Top = 176
  end
  object frtime: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = frtimeTimer
    Left = 288
    Top = 192
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 520
    Top = 184
  end
end
