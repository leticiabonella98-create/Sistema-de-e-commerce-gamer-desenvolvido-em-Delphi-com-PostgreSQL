unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus,
  Vcl.Skia;

type
  TForm7 = class(TForm)
    scrCadeiras: TScrollBox;
    pnlCatalogoCadeiras: TPanel;
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
    TLabel: TLabel;
    pnlCadeira1: TPanel;
    pnlCadeira2: TPanel;
    imgCadeira1: TImage;
    imgCadeira2: TImage;
    lblNomeCadeira1: TLabel;
    lblNomeCadeira2: TLabel;
    lblPrecoCadeira1: TLabel;
    lblPrecoCadeira2: TLabel;
    pnlCarrinhoCadeira1: TPanel;
    pnlCarrinhoCadeira2: TPanel;
    pnlVoltar: TPanel;
    procedure pnlCarrinhoCadeira1Click(Sender: TObject);
    procedure pnlCarrinhoCadeira2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure inicioClick(Sender: TObject);
    procedure mnuTecladosClick(Sender: TObject);
    procedure mnuControlesClick(Sender: TObject);
    procedure mnuFonesClick(Sender: TObject);
    procedure mnuMousesClick(Sender: TObject);
    procedure mnuCadeirasClick(Sender: TObject);
    procedure mnuMonitoresClick(Sender: TObject);
    procedure mnuCarrinhoClick(Sender: TObject);
    procedure pnlVoltarClick(Sender: TObject);
    procedure mnuPerfilClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation
uses
  UnitCarrinho, Unit11, Unit2, Unit3, Unit4, Unit5, Unit6, Unit8, Unit9, Unit12, Unit13;

{$R *.dfm}

   ////FORMRESIZE///////
procedure TForm7.FormResize(Sender: TObject);
var
  LarguraPagina: Integer;
  LarguraCard: Integer;
  Margem: Integer;
  Espacamento: Integer;
begin
  if not Assigned(scrCadeiras) then
    Exit;

  LarguraPagina := scrCadeiras.ClientWidth;

  if LarguraPagina <= 0 then
    Exit;

  // Ajustar largura do catalogo
  pnlCatalogoCadeiras.Width := LarguraPagina;

  // Distribuir os dois cards
  Margem := 80;
  Espacamento := 40;

  LarguraCard :=
    (LarguraPagina - 2 * Margem - Espacamento) div 2;

  // Manter uma largura confortavel
  if LarguraCard > 600 then
    LarguraCard := 600;

  // Centralizar os cards
  Margem :=
    (LarguraPagina - (2 * LarguraCard + Espacamento)) div 2;

  pnlCadeira1.Left := Margem;
  pnlCadeira1.Top := 125;
  pnlCadeira1.Width := LarguraCard;

  pnlCadeira2.Left :=
    Margem + LarguraCard + Espacamento;
  pnlCadeira2.Top := 125;
  pnlCadeira2.Width := LarguraCard;

  // Ajustar largura dos elementos internos
  imgCadeira1.Width := LarguraCard - 80;
  imgCadeira2.Width := LarguraCard - 80;

  lblNomeCadeira1.Width := LarguraCard - 50;
  lblNomeCadeira2.Width := LarguraCard - 50;

  pnlCarrinhoCadeira1.Width := LarguraCard - 50;
  pnlCarrinhoCadeira2.Width := LarguraCard - 50;

  pnlCatalogoCadeiras.Height := 720;

   // Ajusta o fundo roxo à área disponível
  pnlCatalogoCadeiras.Width := scrCadeiras.ClientWidth;
  pnlCatalogoCadeiras.Height := scrCadeiras.ClientHeight;

  // Posiciona o botão Voltar no canto superior direito
  pnlVoltar.Left := ClientWidth - pnlVoltar.Width - 15;
  pnlVoltar.Top := 10;
end;

  ///////Banco De Dados/////////////


procedure TForm7.FormShow(Sender: TObject);
var
  I: Integer;
  LNome, LPreco: Vcl.StdCtrls.TLabel;
  Painel: TPanel;
begin
  // CONECTAR AO POSTGRESQL
  if not dmBanco.conBanco.Connected then
    dmBanco.conBanco.Connected := True;

  // CONSULTAR AS CADEIRAS GAMERS
  dmBanco.qryProdutos.Close;

  dmBanco.qryProdutos.SQL.Text :=
    'SELECT id_produto, nome, preco_venda ' +
    'FROM produtos ' +
    'WHERE id_categoria = :categoria ' +
    'ORDER BY id_produto';

  dmBanco.qryProdutos.ParamByName('categoria').AsInteger := 5;
  dmBanco.qryProdutos.Open;

  // PREENCHER OS DOIS CARDS
  for I := 1 to 2 do
  begin
    case I of
      1:
      begin
        Painel := pnlCadeira1;
        LNome := lblNomeCadeira1;
        LPreco := lblPrecoCadeira1;
      end;

      2:
      begin
        Painel := pnlCadeira2;
        LNome := lblNomeCadeira2;
        LPreco := lblPrecoCadeira2;
      end;
    end;

    // LIMPAR IDENTIFICADOR ANTERIOR
    Painel.Tag := 0;

    if not dmBanco.qryProdutos.Eof then
    begin
      Painel.Visible := True;

      // GUARDAR ID DO PRODUTO
      Painel.Tag :=
        dmBanco.qryProdutos.FieldByName('id_produto').AsInteger;

      // CARREGAR NOME
      LNome.Caption :=
        dmBanco.qryProdutos.FieldByName('nome').AsString;

      // CARREGAR PRECO
      LPreco.Caption :=
        FormatFloat('R$ #,##0.00',
          dmBanco.qryProdutos.FieldByName('preco_venda').AsFloat);

      dmBanco.qryProdutos.Next;
    end
    else
    begin
      Painel.Visible := False;
    end;
  end;

  dmBanco.qryProdutos.Close;
end;

///////NAVEGAR PELAS CATEGORIAS///////////
procedure TForm7.inicioClick(Sender: TObject);
begin
 Form2.Show;
  Form7.Hide;
end;

procedure TForm7.mnuTecladosClick(Sender: TObject);
begin
 Form3.Show;
  Form7.Hide;
end;

procedure TForm7.mnuControlesClick(Sender: TObject);
begin
 Form4.Show;
  Form7.Hide;
end;

procedure TForm7.mnuFonesClick(Sender: TObject);
begin
  Form5.Show;
  Form7.Hide;
end;

procedure TForm7.mnuMousesClick(Sender: TObject);
begin
Form6.Show;
  Form7.Hide;
end;

procedure TForm7.mnuPerfilClick(Sender: TObject);
begin
  Form12.Show;
  Form7.Hide;
end;

procedure TForm7.mnuCadeirasClick(Sender: TObject);
begin
 Form8.Show;
  Form7.Hide;
end;

procedure TForm7.mnuMonitoresClick(Sender: TObject);
begin
 Form9.Show;
  Form7.Hide;
end;

 /////////////////////ADICIONAR AO CARRINHO//////////////////

procedure TForm7.pnlCarrinhoCadeira1Click(Sender: TObject);
begin
  if pnlCadeira1.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeCadeira1.Caption,
    lblPrecoCadeira1.Caption,
    imgCadeira1,
    pnlCadeira1.Tag
  );

  ShowMessage(lblNomeCadeira1.Caption + ' adicionado ao carrinho!');
end;



procedure TForm7.pnlCarrinhoCadeira2Click(Sender: TObject);
begin
  if pnlCadeira2.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeCadeira2.Caption,
    lblPrecoCadeira2.Caption,
    imgCadeira2,
    pnlCadeira2.Tag
  );

  ShowMessage(lblNomeCadeira2.Caption + ' adicionado ao carrinho!');
end;


////BOTAO VOLTAR/////
procedure TForm7.pnlVoltarClick(Sender: TObject);
begin
  Form2.Show;
  Self.Hide;
end;


///MOSTRAR TELA DE CARRINHO/////
procedure TForm7.mnuCarrinhoClick(Sender: TObject);
begin
  Form11.Show;
  Self.Hide;
end;


end.
