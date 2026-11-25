object Form14: TForm14
  Left = 0
  Top = 0
  Caption = 'Nexus Gaming - Pagamento'
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
  object pnlFundoPagamento: TPanel
    Left = 0
    Top = 0
    Width = 1281
    Height = 723
    Align = alClient
    BevelOuter = bvNone
    Color = 2166040
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 536
    ExplicitTop = 400
    ExplicitWidth = 185
    ExplicitHeight = 41
    object pnlFormaPagamento: TPanel
      Left = 50
      Top = 150
      Width = 580
      Height = 400
      BevelOuter = bvNone
      Color = 3873320
      ParentBackground = False
      TabOrder = 0
      object lblTituloFormaPagamento: TLabel
        Left = 25
        Top = 25
        Width = 419
        Height = 32
        Caption = 'ESCOLHA A FORMA DE PAGAMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rbPix: TRadioButton
        Left = 30
        Top = 100
        Width = 200
        Height = 35
        Caption = 'Pix'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
        StyleElements = [seClient, seBorder]
      end
      object rbCredito: TRadioButton
        Left = 30
        Top = 160
        Width = 250
        Height = 35
        Caption = 'Cart'#227'o de Cr'#233'dito'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        StyleElements = [seClient, seBorder]
      end
      object rbDebito: TRadioButton
        Left = 30
        Top = 220
        Width = 250
        Height = 35
        Caption = 'Cart'#227'o de D'#233'bito'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        StyleElements = [seClient, seBorder]
      end
      object pnlAprovarPagamento: TPanel
        Left = 30
        Top = 290
        Width = 350
        Height = 50
        Cursor = crHandPoint
        BevelOuter = bvNone
        Caption = 'SIMULAR PAGAMENTO APROVADO'
        Color = 10506360
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
        OnClick = pnlAprovarPagamentoClick
      end
      object pnlRecusarPagamento: TPanel
        Left = 30
        Top = 355
        Width = 350
        Height = 50
        Cursor = crHandPoint
        BevelOuter = bvNone
        Caption = 'SIMULAR PAGAMENTO RECUSADO'
        Color = 5263520
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        OnClick = pnlRecusarPagamentoClick
      end
    end
    object pnlResumoPagamento: TPanel
      Left = 655
      Top = 150
      Width = 580
      Height = 400
      BevelOuter = bvNone
      Color = 3873320
      ParentBackground = False
      TabOrder = 1
      object lblTituloResumo: TLabel
        Left = 25
        Top = 25
        Width = 240
        Height = 32
        Caption = 'RESUMO DO PEDIDO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalPagamento: TLabel
        Left = 25
        Top = 110
        Width = 175
        Height = 37
        Caption = 'Total: R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblQuantidadePagamento: TLabel
        Left = 25
        Top = 80
        Width = 206
        Height = 23
        Caption = 'Quantidade de produtos: 0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -17
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
