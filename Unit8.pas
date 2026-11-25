unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Skia;

type
  TForm8 = class(TForm)
    scrHardware: TScrollBox;
    pnlCatalogoHardware: TPanel;
    lblTituloHardware: TLabel;
    pnlHardware1: TPanel;
    pnlHardware2: TPanel;
    pnlHardware3: TPanel;
    pnlHardware4: TPanel;
    pnlHardware5: TPanel;
    pnlHardware6: TPanel;
    imgHardware1: TImage;
    imgHardware2: TImage;
    imgHardware3: TImage;
    imgHardware4: TImage;
    imgHardware5: TImage;
    imgHardware6: TImage;
    lblNomeHardware1: TLabel;
    lblNomeHardware2: TLabel;
    lblNomeHardware3: TLabel;
    lblNomeHardware4: TLabel;
    lblNomeHardware5: TLabel;
    lblNomeHardware6: TLabel;
    lblPrecoHardware1: TLabel;
    lblPrecoHardware2: TLabel;
    lblPrecoHardware3: TLabel;
    lblPrecoHardware4: TLabel;
    lblPrecoHardware5: TLabel;
    lblPrecoHardware6: TLabel;
    pnlCarrinhoHardware1: TPanel;
    pnlCarrinhoHardware2: TPanel;
    pnlCarrinhoHardware3: TPanel;
    pnlCarrinhoHardware4: TPanel;
    pnlCarrinhoHardware5: TPanel;
    pnlCarrinhoHardware6: TPanel;
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
    pnlHardware7: TPanel;
    imgHardware7: TImage;
    lblNomeHardware7: TLabel;
    lblPrecoHardware7: TLabel;
    pnlCarrinhoHardware7: TPanel;
    pnlVoltar: TPanel;
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure pnlCarrinhoHardware1Click(Sender: TObject);
    procedure pnlCarrinhoHardware2Click(Sender: TObject);
    procedure pnlCarrinhoHardware3Click(Sender: TObject);
    procedure pnlCarrinhoHardware4Click(Sender: TObject);
    procedure pnlCarrinhoHardware5Click(Sender: TObject);
    procedure pnlCarrinhoHardware6Click(Sender: TObject);
    procedure pnlCarrinhoHardware7Click(Sender: TObject);
    procedure inicioClick(Sender: TObject);
    procedure mnuTecladosClick(Sender: TObject);
    procedure mnuControlesClick(Sender: TObject);
    procedure mnuFonesClick(Sender: TObject);
    procedure mnuMousesClick(Sender: TObject);
    procedure mnuCadeirasClick(Sender: TObject);
    procedure mnuMonitoresClick(Sender: TObject);

    procedure mnuCarrinhoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlVoltarClick(Sender: TObject);
    procedure mnuPerfilClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation
uses
  UnitCarrinho, Unit11, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit9, Unit12, Unit13;

{$R *.dfm}



procedure TForm8.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
   scrHardware.VertScrollBar.Position :=
    scrHardware.VertScrollBar.Position - (WheelDelta div 120) * 60;

  Handled := True;
end;


//////BANCO DE DADOS/////

procedure TForm8.FormShow(Sender: TObject);
var
  I: Integer;
  LNome, LPreco: TLabel;
  Painel: TPanel;
begin
  // CONECTAR AO POSTGRESQL
  if not dmBanco.conBanco.Connected then
    dmBanco.conBanco.Connected := True;

  // CONSULTAR OS PRODUTOS DE HARDWARE
  dmBanco.qryProdutos.Close;

  dmBanco.qryProdutos.SQL.Text :=
    'SELECT id_produto, nome, preco_venda ' +
    'FROM produtos ' +
    'WHERE id_categoria = :categoria ' +
    'ORDER BY id_produto';

  dmBanco.qryProdutos.ParamByName('categoria').AsInteger := 6;
  dmBanco.qryProdutos.Open;

  // PREENCHER OS SETE CARDS
  for I := 1 to 7 do
  begin
    Painel := FindComponent(
      'pnlHardware' + IntToStr(I)
    ) as TPanel;

    LNome := FindComponent(
      'lblNomeHardware' + IntToStr(I)
    ) as TLabel;

    LPreco := FindComponent(
      'lblPrecoHardware' + IntToStr(I)
    ) as TLabel;

    // LIMPAR O ID ANTERIOR
    Painel.Tag := 0;

    if not dmBanco.qryProdutos.Eof then
    begin
      Painel.Visible := True;

      // GUARDAR O ID DO PRODUTO
      Painel.Tag :=
        dmBanco.qryProdutos.FieldByName('id_produto').AsInteger;

      // CARREGAR O NOME
      LNome.Caption :=
        dmBanco.qryProdutos.FieldByName('nome').AsString;

      // CARREGAR O PRECO
      LPreco.Caption :=
        FormatFloat('R$ #,##0.00',
          dmBanco.qryProdutos.FieldByName('preco_venda').AsFloat);

      dmBanco.qryProdutos.Next;
    end
    else
    begin
      // OCULTAR CARD SEM PRODUTO CADASTRADO
      Painel.Visible := False;
    end;
  end;

  dmBanco.qryProdutos.Close;
end;


 //// NAVEGAR CATEGORIAS////

procedure TForm8.FormResize(Sender: TObject);
begin
   // Ajusta a largura do catálogo
  pnlCatalogoHardware.Width := scrHardware.ClientWidth;

  // Mantém a altura necessária para os produtos
  if pnlCatalogoHardware.Height < scrHardware.ClientHeight then
    pnlCatalogoHardware.Height := scrHardware.ClientHeight;

  // Posiciona o botão Voltar
  pnlVoltar.Left := ClientWidth - pnlVoltar.Width - 15;
  pnlVoltar.Top := 10;
  pnlVoltar.BringToFront;
end;

procedure TForm8.inicioClick(Sender: TObject);
begin
 Form2.Show;
  Form8.Hide;
end;
procedure TForm8.mnuTecladosClick(Sender: TObject);
begin
 Form3.Show;
  Form8.Hide;
end;

procedure TForm8.mnuControlesClick(Sender: TObject);
begin
Form4.Show;
  Form8.Hide;
end;

procedure TForm8.mnuFonesClick(Sender: TObject);
begin
 Form5.Show;
  Form8.Hide;
end;

procedure TForm8.mnuMousesClick(Sender: TObject);
begin
Form6.Show;
  Form8.Hide;
end;

procedure TForm8.mnuPerfilClick(Sender: TObject);
begin
  Form12.Show;
  Form8.Hide;
end;

procedure TForm8.mnuCadeirasClick(Sender: TObject);
begin
 Form7.Show;
  Form8.Hide;
end;

procedure TForm8.mnuMonitoresClick(Sender: TObject);
begin
Form9.Show;
Form8.Hide;
end;


////////ADICIONAR NO CARRINHO//////


{ ========== HARDWARE 1 ========== }

procedure TForm8.pnlCarrinhoHardware1Click(Sender: TObject);
begin
  if pnlHardware1.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeHardware1.Caption,
    lblPrecoHardware1.Caption,
    imgHardware1,
    pnlHardware1.Tag
  );

  ShowMessage(lblNomeHardware1.Caption + ' adicionado ao carrinho!');
end;


{ ========== HARDWARE 2 ========== }

procedure TForm8.pnlCarrinhoHardware2Click(Sender: TObject);
begin
  if pnlHardware2.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeHardware2.Caption,
    lblPrecoHardware2.Caption,
    imgHardware2,
    pnlHardware2.Tag
  );

  ShowMessage(lblNomeHardware2.Caption + ' adicionado ao carrinho!');
end;


{ ========== HARDWARE 3 ========== }

procedure TForm8.pnlCarrinhoHardware3Click(Sender: TObject);
begin
  if pnlHardware3.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeHardware3.Caption,
    lblPrecoHardware3.Caption,
    imgHardware3,
    pnlHardware3.Tag
  );

  ShowMessage(lblNomeHardware3.Caption + ' adicionado ao carrinho!');
end;


{ ========== HARDWARE 4 ========== }

procedure TForm8.pnlCarrinhoHardware4Click(Sender: TObject);
begin
  if pnlHardware4.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeHardware4.Caption,
    lblPrecoHardware4.Caption,
    imgHardware4,
    pnlHardware4.Tag
  );

  ShowMessage(lblNomeHardware4.Caption + ' adicionado ao carrinho!');
end;


{ ========== HARDWARE 5 ========== }

procedure TForm8.pnlCarrinhoHardware5Click(Sender: TObject);
begin
  if pnlHardware5.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeHardware5.Caption,
    lblPrecoHardware5.Caption,
    imgHardware5,
    pnlHardware5.Tag
  );

  ShowMessage(lblNomeHardware5.Caption + ' adicionado ao carrinho!');
end;


{ ========== HARDWARE 6 ========== }

procedure TForm8.pnlCarrinhoHardware6Click(Sender: TObject);
begin
  if pnlHardware6.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeHardware6.Caption,
    lblPrecoHardware6.Caption,
    imgHardware6,
    pnlHardware6.Tag
  );

  ShowMessage(lblNomeHardware6.Caption + ' adicionado ao carrinho!');
end;


{ ========== HARDWARE 7 ========== }

procedure TForm8.pnlCarrinhoHardware7Click(Sender: TObject);
begin
  if pnlHardware7.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeHardware7.Caption,
    lblPrecoHardware7.Caption,
    imgHardware7,
    pnlHardware7.Tag
  );

  ShowMessage(lblNomeHardware7.Caption + ' adicionado ao carrinho!');
end;



/////MOSTRAR CARRINHO////
procedure TForm8.mnuCarrinhoClick(Sender: TObject);
begin
  Form11.Show;
  Self.Hide;
end;

/////botao voltar/////
procedure TForm8.pnlVoltarClick(Sender: TObject);
begin
  Form2.Show;
  Form8.Hide;
end;

end.
