object frmCetakJualApotik: TfrmCetakJualApotik
  Left = 450
  Top = 135
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'cpHospital'
  ClientHeight = 335
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = -1
    Top = -1
    Width = 398
    Height = 54
    Color = clSkyBlue
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 64
      Height = 29
      Caption = 'Cetak'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = -1
    Top = 53
    Width = 397
    Height = 279
    Color = clMoneyGreen
    TabOrder = 1
    object rg: TRadioGroup
      Left = 24
      Top = 32
      Width = 353
      Height = 73
      Caption = ' Query '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'Hari ini'
        'Berdasar Tanggal')
      ParentFont = False
      TabOrder = 0
      OnClick = rgClick
    end
    object BitBtn1: TBitBtn
      Left = 297
      Top = 224
      Width = 82
      Height = 33
      Caption = '&Close'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 209
      Top = 223
      Width = 82
      Height = 33
      Caption = '&Print'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn2Click
    end
    object gbtgl: TGroupBox
      Left = 24
      Top = 115
      Width = 353
      Height = 65
      Enabled = False
      TabOrder = 3
      object Label2: TLabel
        Left = 12
        Top = 29
        Width = 24
        Height = 16
        Caption = 'Tgl:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 186
        Top = 28
        Width = 22
        Height = 16
        Caption = 's/d:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object tglawal: TEdit
        Left = 44
        Top = 24
        Width = 121
        Height = 24
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object tglakhir: TEdit
        Left = 214
        Top = 24
        Width = 121
        Height = 24
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object rpthelapapotik: TRvProject
    Engine = apotikengine
    Left = 23
    Top = 245
  end
  object apotikengine: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemSetups = [ssAllowCopies, ssAllowCollate, ssAllowDuplex, ssAllowDestPreview, ssAllowDestPrinter, ssAllowDestFile, ssAllowPrinterSetup, ssAllowPreviewSetup]
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 63
    Top = 245
  end
  object rdthelapapotik: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = dmz.thelapapotikds
    Left = 103
    Top = 245
  end
end
