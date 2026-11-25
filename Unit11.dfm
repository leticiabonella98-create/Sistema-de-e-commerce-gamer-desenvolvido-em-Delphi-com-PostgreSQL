object Form11: TForm11
  Left = 0
  Top = 0
  Caption = 'Nexus Gaming - Carrinho'
  ClientHeight = 723
  ClientWidth = 1281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 1281
    Height = 723
    Align = alClient
    BevelOuter = bvNone
    Color = 2166040
    ParentBackground = False
    TabOrder = 0
    object lblTituloCarrinho: TLabel
      Left = 40
      Top = 35
      Width = 224
      Height = 40
      Caption = 'MEU CARRINHO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15239877
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object scrCarrinho: TScrollBox
      Left = 40
      Top = 110
      Width = 850
      Height = 540
      BorderStyle = bsNone
      Color = 3283497
      ParentColor = False
      TabOrder = 0
      object pnlListaProdutos: TPanel
        Left = 0
        Top = 0
        Width = 850
        Height = 540
        Align = alClient
        BevelOuter = bvNone
        Color = 3283497
        ParentBackground = False
        TabOrder = 0
      end
    end
  end
end
