object Form17: TForm17
  Left = 0
  Top = 0
  Caption = 'Nexus Gaming - Cadastro de Produtos'
  ClientHeight = 723
  ClientWidth = 1281
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object scrCadastroProdutos: TScrollBox
    Left = 0
    Top = 0
    Width = 1281
    Height = 723
    VertScrollBar.Position = 177
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 0
    ExplicitWidth = 734
    ExplicitHeight = 661
    object pnlFundoCadastro: TPanel
      Left = 0
      Top = -177
      Width = 1264
      Height = 900
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object lblNomeProduto: TLabel
        Left = 40
        Top = 95
        Width = 186
        Height = 30
        Caption = 'Nome do Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTituloCadastro: TLabel
        Left = 40
        Top = 25
        Width = 409
        Height = 54
        Caption = 'Cadastro de Produtos'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -40
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lblCategoriaProduto: TLabel
        Left = 650
        Top = 95
        Width = 101
        Height = 30
        Caption = 'Categoria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCodigoBarras: TLabel
        Left = 40
        Top = 285
        Width = 178
        Height = 30
        Caption = 'C'#243'digo de Barras'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDescricaoProduto: TLabel
        Left = 40
        Top = 380
        Width = 224
        Height = 30
        Caption = 'Descri'#231#227'o do Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPrecoCusto: TLabel
        Left = 40
        Top = 525
        Width = 205
        Height = 30
        Caption = 'Pre'#231'o de Custo (R$)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPrecoVenda: TLabel
        Left = 650
        Top = 525
        Width = 211
        Height = 30
        Caption = 'Pre'#231'o de Venda (R$)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEstoqueAtual: TLabel
        Left = 40
        Top = 620
        Width = 249
        Height = 30
        Caption = 'Quantidade em Estoque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEstoqueMinimo: TLabel
        Left = 650
        Top = 620
        Width = 168
        Height = 30
        Caption = 'Estoque M'#237'nimo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblMarcaProduto: TLabel
        Left = 40
        Top = 190
        Width = 66
        Height = 31
        Caption = 'Marca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -23
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblModeloProduto: TLabel
        Left = 650
        Top = 190
        Width = 83
        Height = 31
        Caption = 'Modelo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -23
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtNomeProduto: TEdit
        Left = 40
        Top = 125
        Width = 560
        Height = 38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object cmbCategoriaProduto: TComboBox
        Left = 650
        Top = 125
        Width = 560
        Height = 38
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Items.Strings = (
          'Controles'
          'Fones'
          'Teclados'
          'Mouses'
          'Cadeiras Gamers'
          'Pe'#231'as de Hardware'
          'Monitores Gamers')
      end
      object edtCodigoBarras: TEdit
        Left = 40
        Top = 315
        Width = 560
        Height = 38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object memDescricaoProduto: TMemo
        Left = 40
        Top = 410
        Width = 1170
        Height = 85
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 3
      end
      object edtPrecoCusto: TEdit
        Left = 40
        Top = 555
        Width = 560
        Height = 38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object edtPrecoVenda: TEdit
        Left = 650
        Top = 555
        Width = 560
        Height = 38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object edtEstoqueAtual: TEdit
        Left = 40
        Top = 650
        Width = 560
        Height = 38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object edtEstoqueMinimo: TEdit
        Left = 650
        Top = 650
        Width = 560
        Height = 38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object chkProdutoAtivo: TCheckBox
        Left = 40
        Top = 725
        Width = 200
        Height = 25
        Caption = 'Produto Ativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -22
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object pnlSalvarProduto: TPanel
        Left = 1030
        Top = 790
        Width = 180
        Height = 40
        Cursor = crHandPoint
        BevelOuter = bvNone
        Caption = 'Salvar Produto'
        Color = 6172745
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 9
        OnClick = pnlSalvarProdutoClick
      end
      object pnlCancelarProduto: TPanel
        Left = 890
        Top = 790
        Width = 120
        Height = 40
        Cursor = crHandPoint
        BevelOuter = bvNone
        Caption = 'Cancelar'
        Color = 13750235
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 10
        OnClick = pnlCancelarProdutoClick
      end
      object edtMarcaProduto: TEdit
        Left = 40
        Top = 220
        Width = 560
        Height = 39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object edtModeloProduto: TEdit
        Left = 650
        Top = 220
        Width = 560
        Height = 39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
    end
  end
  object qryCategorias: TFDQuery
    Left = 584
    Top = 639
  end
  object qrySalvarProduto: TFDQuery
    Left = 488
    Top = 639
  end
end
