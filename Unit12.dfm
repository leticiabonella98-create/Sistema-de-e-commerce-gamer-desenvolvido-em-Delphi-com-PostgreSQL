object Form12: TForm12
  Left = 0
  Top = 0
  Caption = 'Nexus Gaming - Meu Perfil'
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
  TextHeight = 15
  object scrPerfil: TScrollBox
    Left = 0
    Top = 0
    Width = 1281
    Height = 723
    VertScrollBar.Position = 327
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 0
    DesignSize = (
      1264
      723)
    object pnlConteudoPerfil: TPanel
      Left = 0
      Top = 0
      Width = 1250
      Height = 1200
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Color = 2166040
      UseDockManager = False
      ParentBackground = False
      TabOrder = 0
      object lblTituloPerfil: TLabel
        Left = 45
        Top = 35
        Width = 181
        Height = 45
        Caption = 'MEU PERFIL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlDadosPessoais: TPanel
        Left = 45
        Top = 110
        Width = 1160
        Height = 320
        BevelOuter = bvNone
        Color = 3283497
        ParentBackground = False
        TabOrder = 0
        object lblDadosPessoais: TLabel
          Left = 25
          Top = 20
          Width = 177
          Height = 30
          Caption = 'DADOS PESSOAIS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNomePerfil: TLabel
          Left = 25
          Top = 75
          Width = 109
          Height = 20
          Caption = 'Nome completo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblEmailPerfil: TLabel
          Left = 25
          Top = 160
          Width = 43
          Height = 20
          Caption = 'E-mail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object edtNomePerfil: TEdit
          Left = 25
          Top = 105
          Width = 500
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 0
        end
        object edtEmailPerfil: TEdit
          Left = 25
          Top = 190
          Width = 500
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 150
          ParentFont = False
          TabOrder = 1
        end
      end
      object pnlSalvarPerfil: TPanel
        Left = 70
        Top = 367
        Width = 200
        Height = 40
        BevelOuter = bvNone
        Caption = 'SALVAR ALTERA'#199#213'ES'
        Color = 13132444
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        OnClick = pnlSalvarPerfilClick
      end
      object pnlEndereco: TPanel
        Left = 45
        Top = 460
        Width = 1160
        Height = 530
        BevelOuter = bvNone
        Color = 3283497
        ParentBackground = False
        TabOrder = 2
        object lblTituloEndereco: TLabel
          Tag = 20
          Left = 25
          Top = 20
          Width = 250
          Height = 30
          AutoSize = False
          Caption = 'ENDERE'#199'O DE ENTREGA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblCEP: TLabel
          Left = 25
          Top = 75
          Width = 100
          Height = 25
          AutoSize = False
          Caption = 'CEP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblRua: TLabel
          Left = 250
          Top = 75
          Width = 117
          Height = 20
          AutoSize = False
          Caption = 'Rua (Logradouro)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblNumero: TLabel
          Left = 875
          Top = 75
          Width = 54
          Height = 20
          Caption = 'N'#250'mero'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblBairro: TLabel
          Left = 25
          Top = 165
          Width = 150
          Height = 20
          AutoSize = False
          Caption = 'Bairro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblCidade: TLabel
          Left = 400
          Top = 165
          Width = 47
          Height = 20
          Caption = 'Cidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblEstado: TLabel
          Left = 875
          Top = 165
          Width = 76
          Height = 20
          Caption = 'Estado (UF)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object lblComplemento: TLabel
          Left = 25
          Top = 255
          Width = 167
          Height = 20
          Caption = 'Complemento (opcional)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object mskCEP: TMaskEdit
          Left = 25
          Top = 105
          Width = 199
          Height = 28
          EditMask = '00000-000;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 9
          ParentFont = False
          TabOrder = 0
          Text = '     -   '
        end
        object edtRua: TEdit
          Left = 250
          Top = 105
          Width = 600
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 150
          ParentFont = False
          TabOrder = 1
        end
        object edtNumero: TEdit
          Left = 875
          Top = 105
          Width = 200
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 2
        end
        object edtBairro: TEdit
          Left = 25
          Top = 195
          Width = 350
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 3
        end
        object edtCidade: TEdit
          Left = 400
          Top = 195
          Width = 450
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 4
        end
        object cmbEstado: TComboBox
          Left = 875
          Top = 195
          Width = 200
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          Items.Strings = (
            'AC'
            'AL'
            'AP'
            'AM'
            'BA'
            'CE'
            'DF'
            'ES'
            'GO'
            'MA'
            'MT'
            'MS'
            'MG'
            'PA'
            'PB'
            'PR'
            'PE'
            'PI'
            'RJ'
            'RN'
            'RS'
            'RO'
            'RR'
            'SC'
            'SP'
            'SE'
            'TO')
        end
        object edtComplemento: TEdit
          Left = 25
          Top = 285
          Width = 600
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 150
          ParentFont = False
          TabOrder = 6
        end
        object pnlSalvarEndereco: TPanel
          Left = 25
          Top = 365
          Width = 200
          Height = 40
          Cursor = crHandPoint
          BevelOuter = bvNone
          Caption = 'SALVAR ENDERE'#199'O'
          Color = 13132444
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 7
          OnClick = pnlSalvarEnderecoClick
        end
      end
      object pnlVoltar: TPanel
        Left = 1150
        Top = 10
        Width = 110
        Height = 35
        Cursor = crHandPoint
        BevelOuter = bvNone
        Caption = #8592' VOLTAR'
        Color = 13132444
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
        OnClick = pnlVoltarClick
      end
    end
  end
end
