object Form16: TForm16
  Left = 0
  Top = 0
  Caption = 'Nexus Gaming - Painel Administrativo'
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
  TextHeight = 15
  object pnlMenuAdmin: TPanel
    Left = 0
    Top = 0
    Width = 250
    Height = 723
    Align = alLeft
    BevelOuter = bvNone
    Color = 6172745
    ParentBackground = False
    TabOrder = 0
    object scrMenuAdmin: TScrollBox
      Left = 0
      Top = 0
      Width = 250
      Height = 723
      Align = alClient
      TabOrder = 0
      object pnlFundoMenu: TPanel
        Left = 0
        Top = 0
        Width = 246
        Height = 650
        Align = alTop
        BevelOuter = bvNone
        Color = 6172745
        ParentBackground = False
        TabOrder = 0
        object lblLogoAdmin: TLabel
          Left = 25
          Top = 35
          Width = 278
          Height = 48
          Caption = 'NEXUS GAMING'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -36
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object pnlVisaoGeral: TPanel
          Left = 20
          Top = 110
          Width = 210
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Vis'#227'o geral'
          Color = 10321034
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          OnClick = pnlVisaoGeralClick
        end
        object pnlClientes: TPanel
          Left = 20
          Top = 160
          Width = 210
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Clientes'
          Color = 10321034
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          OnClick = pnlClientesClick
        end
        object pnlProdutos: TPanel
          Left = 20
          Top = 210
          Width = 210
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Produtos'
          Color = 10321034
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          OnClick = pnlProdutosClick
        end
        object pnlFornecedores: TPanel
          Left = 20
          Top = 260
          Width = 210
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Fornecedores'
          Color = 10321034
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
          OnClick = pnlFornecedoresClick
        end
        object pnlFuncionarios: TPanel
          Left = 20
          Top = 310
          Width = 210
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Funcion'#225'rios'
          Color = 10321034
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 4
          OnClick = pnlFuncionariosClick
        end
        object pnlEstoque: TPanel
          Left = 20
          Top = 360
          Width = 210
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Estoque'
          Color = 10321034
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
          OnClick = pnlEstoqueClick
        end
        object pnlVendas: TPanel
          Left = 20
          Top = 410
          Width = 210
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Vendas'
          Color = 10321034
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
          OnClick = pnlVendasClick
        end
        object pnlPagamentos: TPanel
          Left = 20
          Top = 460
          Width = 210
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Pagamentos'
          Color = 10321034
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 7
          OnClick = pnlPagamentosClick
        end
        object pnlSairAdmin: TPanel
          Left = 20
          Top = 530
          Width = 210
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'Sair do sistema'
          Color = 10321034
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 8
        end
      end
    end
  end
  object pnlConteudoAdmin: TPanel
    Left = 250
    Top = 0
    Width = 1031
    Height = 723
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object scrAdmin: TScrollBox
      Left = 0
      Top = 0
      Width = 1031
      Height = 723
      HorzScrollBar.Visible = False
      VertScrollBar.Position = 177
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      object pnlPrincipalAdmin: TPanel
        Left = 0
        Top = -177
        Width = 1014
        Height = 1100
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object lblTituloAdmin: TLabel
          Left = 30
          Top = 25
          Width = 488
          Height = 65
          Caption = 'Painel Administrativo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clPurple
          Font.Height = -48
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblDescricaoAdmin: TLabel
          Left = 30
          Top = 75
          Width = 436
          Height = 30
          Caption = 'Gerenciamento e consultas da Nexus Gaming'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -22
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object pnlTotalClientes: TPanel
          Left = 30
          Top = 130
          Width = 210
          Height = 110
          BevelOuter = bvNone
          Color = 13750235
          ParentBackground = False
          TabOrder = 0
          object lblCardClientes: TLabel
            Left = 15
            Top = 15
            Width = 168
            Height = 30
            Caption = 'Total de clientes'
            Color = 6172745
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6172745
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lblValorClientes: TLabel
            Left = 15
            Top = 45
            Width = 28
            Height = 65
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6172745
            Font.Height = -48
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object pnlTotalProdutos: TPanel
          Left = 260
          Top = 130
          Width = 210
          Height = 110
          BevelOuter = bvNone
          Color = 13750235
          ParentBackground = False
          TabOrder = 1
          object lblCardProdutos: TLabel
            Left = 15
            Top = 15
            Width = 184
            Height = 30
            Caption = 'Total de produtos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6172745
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblValorProdutos: TLabel
            Left = 23
            Top = 45
            Width = 28
            Height = 65
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6172745
            Font.Height = -48
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object pnlTotalEstoque: TPanel
          Left = 720
          Top = 130
          Width = 210
          Height = 110
          BevelOuter = bvNone
          Color = 13750235
          ParentBackground = False
          TabOrder = 2
          object lblCardEstoque: TLabel
            Left = 15
            Top = 15
            Width = 178
            Height = 30
            Caption = 'Itens em estoque'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6172745
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblValorEstoque: TLabel
            Left = 39
            Top = 45
            Width = 28
            Height = 65
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6172745
            Font.Height = -48
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object pnlTotalVendas: TPanel
          Left = 490
          Top = 130
          Width = 210
          Height = 110
          BevelOuter = bvNone
          Color = 13750235
          ParentBackground = False
          TabOrder = 3
          object pnlCardlVendas: TLabel
            Left = 15
            Top = 15
            Width = 162
            Height = 30
            Caption = 'Total de vendas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6172745
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblValorVendas: TLabel
            Left = 31
            Top = 45
            Width = 28
            Height = 65
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 6172745
            Font.Height = -48
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object pnlConsultas: TPanel
          Left = 30
          Top = 270
          Width = 950
          Height = 650
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 4
          object lblTituloConsulta: TLabel
            Left = 20
            Top = 0
            Width = 324
            Height = 45
            Caption = 'Consulta de Registros'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clPurple
            Font.Height = -32
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object edtPesquisarAdmin: TEdit
            Left = 20
            Top = 70
            Width = 350
            Height = 38
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TextHint = 'Digite o nome ou c'#243'digo para pesquisar...'
          end
          object pnlPesquisarAdmin: TPanel
            Left = 385
            Top = 70
            Width = 120
            Height = 35
            Caption = 'Pesquisar'
            Color = 6172745
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
          end
          object dbgConsultasAdmin: TDBGrid
            Left = 20
            Top = 125
            Width = 900
            Height = 330
            Color = clWhite
            DataSource = dsAdmin
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -20
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
          end
          object pnlNovoAdmin: TPanel
            Left = 20
            Top = 475
            Width = 150
            Height = 45
            Cursor = crHandPoint
            BevelOuter = bvNone
            Caption = 'Adicionar'
            Color = 6172745
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            OnClick = pnlNovoAdminClick
          end
          object pnlEditarAdmin: TPanel
            Left = 194
            Top = 475
            Width = 150
            Height = 45
            Cursor = crHandPoint
            BevelOuter = bvNone
            Caption = 'Editar'
            Color = 6172745
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
          end
          object pnlExcluirAdmin: TPanel
            Left = 369
            Top = 475
            Width = 150
            Height = 45
            Cursor = crHandPoint
            BevelOuter = bvNone
            Caption = 'Excluir'
            Color = 6172745
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
          end
          object pnlAtualizarAdmin: TPanel
            Left = 543
            Top = 475
            Width = 150
            Height = 45
            Cursor = crHandPoint
            BevelOuter = bvNone
            Caption = 'Atualizar'
            Color = 6172745
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -22
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 6
          end
        end
      end
    end
  end
  object qryAdmin: TFDQuery
    Left = 936
    Top = 125
  end
  object dsAdmin: TDataSource
    DataSet = qryAdmin
    Left = 848
    Top = 141
  end
end
