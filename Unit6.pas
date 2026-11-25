unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Skia, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Menus;

type
  TForm6 = class(TForm)
    scrMouses: TScrollBox;
    pnlCatalogoMouses: TPanel;
    lblTituloMouses: TLabel;
    pnlMouse1: TPanel;
    Panel1: TPanel;
    imgMouse1: TImage;
    lblNomeMouse1: TLabel;
    imgMouse2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    pnlCarrinhoMouse1: TPanel;
    Label3: TLabel;
    pnlCarrinhoMouse2: TPanel;
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
    pnlVoltar: TPanel;
    procedure pnlCarrinhoMouse1Click(Sender: TObject);
    procedure pnlCarrinhoMouse2Click(Sender: TObject);
    procedure inicioClick(Sender: TObject);
    procedure mnuControlesClick(Sender: TObject);
    procedure mnuFonesClick(Sender: TObject);
    procedure mnuTecladosClick(Sender: TObject);
    procedure mnuCadeirasClick(Sender: TObject);
    procedure mnuHardwareClick(Sender: TObject);
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
  Form6: TForm6;

implementation

uses
  UnitCarrinho, Unit11, Unit2, Unit3, Unit4, Unit5, Unit7, Unit8, Unit9, Unit12, Unit13;

{$R *.dfm}

//////////NAVEGAR PELAS CATEGORIAS/////////////////

procedure TForm6.FormResize(Sender: TObject);
begin
    // Ajusta o fundo roxo
  pnlCatalogoMouses.Width := scrMouses.ClientWidth;
  pnlCatalogoMouses.Height := scrMouses.ClientHeight;

  // Posiciona o botão Voltar
  pnlVoltar.Left := ClientWidth - pnlVoltar.Width - 15;
  pnlVoltar.Top := 10;
end;



procedure TForm6.FormShow(Sender: TObject);
var
  I: Integer;
  LNome, LPreco: TLabel;
  Painel: TPanel;
begin
  // CONECTAR AO POSTGRESQL
  if not dmBanco.conBanco.Connected then
    dmBanco.conBanco.Connected := True;

  // CONSULTAR OS MOUSES
  dmBanco.qryProdutos.Close;

  dmBanco.qryProdutos.SQL.Text :=
    'SELECT id_produto, nome, preco_venda ' +
    'FROM produtos ' +
    'WHERE id_categoria = :categoria ' +
    'ORDER BY id_produto';

  dmBanco.qryProdutos.ParamByName('categoria').AsInteger := 4;
  dmBanco.qryProdutos.Open;

  // PREENCHER OS DOIS CARDS
  for I := 1 to 2 do
  begin
    case I of
      1:
      begin
        Painel := pnlMouse1;
        LNome := lblNomeMouse1;
        LPreco := Label3;
      end;

      2:
      begin
        Painel := Panel1;
        LNome := Label1;
        LPreco := Label2;
      end;
    end;

    // LIMPAR O ID ANTERIOR
    Painel.Tag := 0;

    if not dmBanco.qryProdutos.Eof then
    begin
      Painel.Visible := True;

      // GUARDAR O ID DO PRODUTO
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


procedure TForm6.inicioClick(Sender: TObject);
begin
 Form2.Show;
  Form6.Hide;
end;

procedure TForm6.mnuTecladosClick(Sender: TObject);
begin
  Form3.Show;
  Form6.Hide;
end;

procedure TForm6.mnuControlesClick(Sender: TObject);
begin
  Form4.Show;
  Form6.Hide;
end;

procedure TForm6.mnuFonesClick(Sender: TObject);
begin
 Form5.Show;
  Form6.Hide;
end;

procedure TForm6.mnuCadeirasClick(Sender: TObject);
begin
 Form7.Show;
  Form6.Hide;
end;

procedure TForm6.mnuHardwareClick(Sender: TObject);
begin
 Form8.Show;
  Form6.Hide;
end;

procedure TForm6.mnuMonitoresClick(Sender: TObject);
begin
  Form9.Show;
  Form6.Hide;
end;

procedure TForm6.mnuPerfilClick(Sender: TObject);
begin
Form12.Show;
  Form6.Hide;
end;

///////////////ADICIONAR AO CARRINHO////////////

procedure TForm6.pnlCarrinhoMouse1Click(Sender: TObject);
begin
  if pnlMouse1.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeMouse1.Caption,
    Label3.Caption,
    imgMouse1,
    pnlMouse1.Tag
  );

  ShowMessage(lblNomeMouse1.Caption + ' adicionado ao carrinho!');
end;



procedure TForm6.pnlCarrinhoMouse2Click(Sender: TObject);
begin
  if Panel1.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    Label1.Caption,
    Label2.Caption,
    imgMouse2,
    Panel1.Tag
  );

  ShowMessage(Label1.Caption + ' adicionado ao carrinho!');
end;

procedure TForm6.pnlVoltarClick(Sender: TObject);
begin
  Form2.Show;
  Self.Hide;
end;

procedure TForm6.mnuCarrinhoClick(Sender: TObject);
begin
  Form11.Show;
  Self.Hide;
end;

end.
