object Form10: TForm10
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Nexus Gaming - Cadastro'
  ClientHeight = 611
  ClientWidth = 884
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 884
    Height = 611
    Align = alClient
    BevelOuter = bvNone
    Color = 2166040
    ParentBackground = False
    TabOrder = 0
  end
  object pnlCadastro: TPanel
    Left = 225
    Top = 35
    Width = 450
    Height = 565
    BevelOuter = bvNone
    Color = 3283497
    ParentBackground = False
    TabOrder = 1
    object lblTitulo: TLabel
      Left = 30
      Top = 20
      Width = 225
      Height = 40
      Caption = 'NEXUS GAMING'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15239877
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSubtitulo: TLabel
      Left = 30
      Top = 62
      Width = 130
      Height = 17
      Caption = 'Crie sua conta gamer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCadastro: TLabel
      Left = 30
      Top = 105
      Width = 188
      Height = 28
      Caption = 'Cadastro de usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15239877
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNome: TLabel
      Left = 30
      Top = 155
      Width = 95
      Height = 17
      Caption = 'Nome completo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblEmail: TLabel
      Left = 30
      Top = 222
      Width = 36
      Height = 17
      Caption = 'E-mail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblSenha: TLabel
      Left = 30
      Top = 289
      Width = 35
      Height = 17
      Caption = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblConfirmarSenha: TLabel
      Left = 30
      Top = 356
      Width = 96
      Height = 17
      Caption = 'Confirmar senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtNome: TEdit
      Left = 30
      Top = 178
      Width = 390
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3546669
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edtEmail: TEdit
      Left = 30
      Top = 245
      Width = 390
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3546669
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtSenha: TEdit
      Left = 30
      Top = 312
      Width = 390
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3546669
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtConfirmarSenha: TEdit
      Left = 30
      Top = 379
      Width = 390
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3546669
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object pnlCadastrar: TPanel
      Left = 30
      Top = 435
      Width = 390
      Height = 40
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = 'CADASTRAR'
      Color = 13132444
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
      OnClick = pnlCadastrarClick
    end
    object pnlVoltar: TPanel
      Left = 30
      Top = 510
      Width = 390
      Height = 35
      Cursor = crHandPoint
      Caption = #8592' VOLTAR'
      Color = 4794429
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
      OnClick = pnlVoltarClick
    end
  end
end
