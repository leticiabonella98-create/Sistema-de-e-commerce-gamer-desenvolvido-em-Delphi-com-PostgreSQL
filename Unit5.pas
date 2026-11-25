
unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Skia, Vcl.Menus;

type
  TForm5 = class(TForm)

    // ========================================
    // 1. COMPONENTES DA TELA DE FONES
    // ========================================

    scrFones: TScrollBox;
    pnlCatalogoFones: TPanel;
    lblTituloFones: TLabel;

    // CARDS DOS PRODUTOS
    pnlFone1: TPanel;
    pnlFone2: TPanel;
    pnlFone3: TPanel;

    // IMAGENS DOS PRODUTOS
    imgFone1: TImage;
    imgFone2: TImage;
    Image1: TImage;

    // NOMES DOS PRODUTOS
    lblNomeFone1: TLabel;
    lblNomeFone2: TLabel;
    lblNomeFone3: TLabel;

    // PRECOS DOS PRODUTOS
    lblPrecoFone1: TLabel;
    lblPrecoFone2: TLabel;
    lblPrecoFone3: TLabel;

    // BOTOES DO CARRINHO
    pnlCarrinhoFone1: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;

    // ========================================
    // 2. MENU PRINCIPAL
    // ========================================

    mnuInicio: TMainMenu;
    inicio: TMenuItem;
    mnuProdutos: TMenuItem;
    mnuControles: TMenuItem;
    mnuFones: TMenuItem;
    mnuTeclados: TMenuItem;
    mnuMouses: TMenuItem;
    mnuCadeiras: TMenuItem;
    mnuHardware: TMenuItem;
    mnuMonitores: TMenuItem;
    mnuCarrinho: TMenuItem;
    mnuPerfil: TMenuItem;

    // BOTAO VOLTAR
    pnlVoltar: TPanel;

    // ========================================
    // 3. EVENTOS DO FORMULARIO
    // ========================================

    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);

    // EVENTO DO BOTAO VOLTAR
    procedure pnlVoltarClick(Sender: TObject);

    // EVENTOS DO MENU
    procedure inicioClick(Sender: TObject);
    procedure mnuTecladosClick(Sender: TObject);
    procedure mnuControlesClick(Sender: TObject);
    procedure mnuMousesClick(Sender: TObject);
    procedure mnuCadeirasClick(Sender: TObject);
    procedure mnuHardwareClick(Sender: TObject);
    procedure mnuMonitoresClick(Sender: TObject);
    procedure mnuPerfilClick(Sender: TObject);
    procedure mnuCarrinhoClick(Sender: TObject);

    // EVENTOS DO CARRINHO
    procedure pnlCarrinhoFone1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);

  private
    // POSICIONAR O BOTAO VOLTAR
    procedure ConfigurarBotaoVoltar;

  public
  end;

var
  Form5: TForm5;

implementation

uses
  UnitCarrinho, Unit11, Unit2, Unit3,
  Unit4, Unit6, Unit7, Unit8, Unit9,
  Unit12, Unit13;

{$R *.dfm}


// ============================================
// 4. CONFIGURAR BOTAO VOLTAR
// ============================================

procedure TForm5.ConfigurarBotaoVoltar;
begin

  // GARANTIR QUE O PAINEL ESTEJA VISIVEL
  pnlVoltar.Visible := True;
  pnlVoltar.Enabled := True;

  // CONECTAR O EVENTO DO CLIQUE
  pnlVoltar.OnClick := pnlVoltarClick;

  // POSICIONAR NO CANTO SUPERIOR DIREITO
  pnlVoltar.Left :=
    ClientWidth - pnlVoltar.Width - 15;

  pnlVoltar.Top := 10;

  // COLOCAR ACIMA DO SCROLLBOX
  pnlVoltar.BringToFront;

  // MOSTRAR CURSOR DE CLIQUE
  pnlVoltar.Cursor := crHandPoint;

end;


// ============================================
// 5. REDIMENSIONAR FORMULARIO
// ============================================

procedure TForm5.FormResize(Sender: TObject);
begin

  // AJUSTAR LARGURA DO CATALOGO
  if pnlCatalogoFones.Width < scrFones.ClientWidth then
    pnlCatalogoFones.Width := scrFones.ClientWidth;

  // AJUSTAR ALTURA DO CATALOGO
  pnlCatalogoFones.Height :=
    scrFones.ClientHeight;

  // REPOSICIONAR BOTAO VOLTAR
  ConfigurarBotaoVoltar;

end;


// ============================================
// 6. CARREGAR TELA E PRODUTOS
// ============================================

procedure TForm5.FormShow(Sender: TObject);
var
  I: Integer;
  LNome, LPreco: TLabel;
  Painel: TPanel;
begin

  // PREPARAR BOTAO VOLTAR
  ConfigurarBotaoVoltar;

  // VERIFICAR CONEXAO COM POSTGRESQL
  if not dmBanco.conBanco.Connected then
    dmBanco.conBanco.Connected := True;

  // FECHAR CONSULTA ANTERIOR
  dmBanco.qryProdutos.Close;

  // CONSULTAR PRODUTOS DA CATEGORIA FONES
  dmBanco.qryProdutos.SQL.Text :=
    'SELECT id_produto, nome, preco_venda ' +
    'FROM produtos ' +
    'WHERE id_categoria = :categoria ' +
    'ORDER BY id_produto';

  // CATEGORIA 2 = FONES
  dmBanco.qryProdutos.ParamByName(
    'categoria').AsInteger := 2;

  // EXECUTAR CONSULTA
  dmBanco.qryProdutos.Open;

  try

    // PREENCHER OS TRES CARDS
    for I := 1 to 3 do
    begin

      // IDENTIFICAR COMPONENTES DO CARD
      case I of

        1:
        begin
          Painel := pnlFone1;
          LNome := lblNomeFone1;
          LPreco := lblPrecoFone1;
        end;

        2:
        begin
          Painel := pnlFone2;
          LNome := lblNomeFone2;
          LPreco := lblPrecoFone2;
        end;

        3:
        begin
          Painel := pnlFone3;
          LNome := lblNomeFone3;
          LPreco := lblPrecoFone3;
        end;

      end;

      // LIMPAR ID ANTERIOR
      Painel.Tag := 0;

      if not dmBanco.qryProdutos.Eof then
      begin

        // EXIBIR CARD
        Painel.Visible := True;

        // ARMAZENAR ID DO PRODUTO
        Painel.Tag :=
          dmBanco.qryProdutos.FieldByName(
            'id_produto').AsInteger;

        // EXIBIR NOME
        LNome.Caption :=
          dmBanco.qryProdutos.FieldByName(
            'nome').AsString;

        // EXIBIR PRECO
        LPreco.Caption :=
          FormatFloat(
            'R$ #,##0.00',
            dmBanco.qryProdutos.FieldByName(
              'preco_venda').AsFloat
          );

        // AVANCAR PARA O PROXIMO PRODUTO
        dmBanco.qryProdutos.Next;

      end
      else
      begin

        // OCULTAR CARD SEM PRODUTO
        Painel.Visible := False;

      end;

    end;

  finally

    // FECHAR CONSULTA MESMO EM CASO DE ERRO
    dmBanco.qryProdutos.Close;

  end;

end;


// ============================================
// 7. BOTAO VOLTAR PARA TELA INICIAL
// ============================================

procedure TForm5.pnlVoltarClick(Sender: TObject);
begin

  // EXIBIR TELA INICIAL
  Form2.Show;

  // OCULTAR TELA DE FONES
  Form5.Hide;

end;


// ============================================
// 8. MENU INICIO
// ============================================

procedure TForm5.inicioClick(Sender: TObject);
begin

  // UTILIZAR A MESMA NAVEGACAO DO BOTAO VOLTAR
  pnlVoltarClick(Sender);

end;


// ============================================
// 9. MENU TECLADOS
// ============================================

procedure TForm5.mnuTecladosClick(Sender: TObject);
begin

  Form3.Show;
  Form5.Hide;

end;


// ============================================
// 10. MENU CONTROLES
// ============================================

procedure TForm5.mnuControlesClick(Sender: TObject);
begin

  Form4.Show;
  Form5.Hide;

end;


// ============================================
// 11. MENU MOUSES
// ============================================

procedure TForm5.mnuMousesClick(Sender: TObject);
begin

  Form6.Show;
  Form5.Hide;

end;


// ============================================
// 12. MENU PERFIL
// ============================================

procedure TForm5.mnuPerfilClick(Sender: TObject);
begin

  Form12.Show;
  Form5.Hide;

end;


// ============================================
// 13. MENU CADEIRAS GAMERS
// ============================================

procedure TForm5.mnuCadeirasClick(Sender: TObject);
begin

  Form7.Show;
  Form5.Hide;

end;


// ============================================
// 14. MENU CARRINHO
// ============================================

procedure TForm5.mnuCarrinhoClick(Sender: TObject);
begin

  Form11.Show;
  Form5.Hide;

end;


// ============================================
// 15. MENU HARDWARE
// ============================================

procedure TForm5.mnuHardwareClick(Sender: TObject);
begin

  Form8.Show;
  Form5.Hide;

end;


// ============================================
// 16. MENU MONITORES
// ============================================

procedure TForm5.mnuMonitoresClick(Sender: TObject);
begin

  Form9.Show;
  Form5.Hide;

end;


// ============================================
// 17. ADICIONAR FONE 1 AO CARRINHO
// ============================================

procedure TForm5.pnlCarrinhoFone1Click(
  Sender: TObject);
begin

  // VERIFICAR DISPONIBILIDADE
  if pnlFone1.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  // ADICIONAR PRODUTO
  AdicionarProduto(
    lblNomeFone1.Caption,
    lblPrecoFone1.Caption,
    imgFone1,
    pnlFone1.Tag
  );

  // CONFIRMAR ADICAO
  ShowMessage(
    lblNomeFone1.Caption +
    ' adicionado ao carrinho!'
  );

end;


// ============================================
// 18. ADICIONAR FONE 2 AO CARRINHO
// ============================================

procedure TForm5.Panel1Click(Sender: TObject);
begin

  if pnlFone2.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeFone2.Caption,
    lblPrecoFone2.Caption,
    imgFone2,
    pnlFone2.Tag
  );

  ShowMessage(
    lblNomeFone2.Caption +
    ' adicionado ao carrinho!'
  );

end;


// ============================================
// 19. ADICIONAR FONE 3 AO CARRINHO
// ============================================

procedure TForm5.Panel2Click(Sender: TObject);
begin

  if pnlFone3.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeFone3.Caption,
    lblPrecoFone3.Caption,
    Image1,
    pnlFone3.Tag
  );

  ShowMessage(
    lblNomeFone3.Caption +
    ' adicionado ao carrinho!'
  );

end;

end.

