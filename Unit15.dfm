object Form15: TForm15
  Left = 0
  Top = 0
  Caption = 'Nexus Gaming - Meus Pedidos'
  ClientHeight = 723
  ClientWidth = 1281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object pnlFundoPedidos: TPanel
    Left = 0
    Top = 0
    Width = 1281
    Height = 723
    Align = alClient
    BevelOuter = bvNone
    Color = 2166040
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 416
    ExplicitTop = 344
    ExplicitWidth = 185
    ExplicitHeight = 41
    object lblTituloPedidos: TLabel
      Left = 50
      Top = 40
      Width = 235
      Height = 45
      Caption = 'MEUS PEDIDOS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object scrPedidos: TScrollBox
      Left = 50
      Top = 110
      Width = 1190
      Height = 550
      BorderStyle = bsNone
      TabOrder = 0
      object pnlListaPedidos: TPanel
        Left = 0
        Top = 0
        Width = 1190
        Height = 500
        Align = alTop
        BevelOuter = bvNone
        Color = 3283497
        ParentBackground = False
        TabOrder = 0
      end
    end
    object pnlVoltarInicio: TPanel
      Left = 50
      Top = 680
      Width = 200
      Height = 45
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = 'VOLTAR AO IN'#205'CIO'
      Color = 5255241
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
end
