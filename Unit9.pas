unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Skia,
  Vcl.Menus;

type
  TForm9 = class(TForm)
    scrMonitores: TScrollBox;
    pnlCatalogoMonitores: TPanel;
    lblTituloMonitores: TLabel;
    pnlMonitor1: TPanel;
    pnlMonitor2: TPanel;
    imgMonitor1: TImage;
    imgMonitor2: TImage;
    lblNomeMonitor1: TLabel;
    lblNomeMonitor2: TLabel;
    lblPrecoMonitor1: TLabel;
    lblPrecoMonitor2: TLabel;
    pnlCarrinhoMonitor1: TPanel;
    pnlCarrinhoMonitor2: TPanel;
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
    procedure pnlCarrinhoMonitor1Click(Sender: TObject);
    procedure pnlCarrinhoMonitor2Click(Sender: TObject);
    procedure inicioClick(Sender: TObject);
    procedure mnuTecladosClick(Sender: TObject);
    procedure mnuControlesClick(Sender: TObject);
    procedure mnuFonesClick(Sender: TObject);
    procedure mnuMousesClick(Sender: TObject);
    procedure mnuCadeirasClick(Sender: TObject);
    procedure mnuHardwareClick(Sender: TObject);
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
  Form9: TForm9;

implementation
uses
  UnitCarrinho, Unit11, Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit12, Unit13;

{$R *.dfm}


/////NAVEGAR A CATEGORIA////

procedure TForm9.FormResize(Sender: TObject);
begin
pnlCatalogoMonitores.Width := scrMonitores.ClientWidth;
pnlCatalogoMonitores.Height := scrMonitores.ClientHeight;

pnlVoltar.Left := ClientWidth - pnlVoltar.Width - 15;
pnlVoltar.Top := 10;
end;

/////BANCO DE DADOS////////

procedure TForm9.FormShow(Sender: TObject);
var
  I: Integer;
  LNome, LPreco: TLabel;
  Painel: TPanel;
begin
  // CONECTAR AO POSTGRESQL
  if not dmBanco.conBanco.Connected then
    dmBanco.conBanco.Connected := True;

  // CONSULTAR MONITORES
  dmBanco.qryProdutos.Close;

  dmBanco.qryProdutos.SQL.Text :=
    'SELECT id_produto, nome, preco_venda ' +
    'FROM produtos ' +
    'WHERE id_categoria = :categoria ' +
    'ORDER BY id_produto';

  dmBanco.qryProdutos.ParamByName('categoria').AsInteger := 7;
  dmBanco.qryProdutos.Open;

  // PREENCHER OS DOIS CARDS
  for I := 1 to 2 do
  begin
    case I of
      1:
      begin
        Painel := pnlMonitor1;
        LNome := lblNomeMonitor1;
        LPreco := lblPrecoMonitor1;
      end;

      2:
      begin
        Painel := pnlMonitor2;
        LNome := lblNomeMonitor2;
        LPreco := lblPrecoMonitor2;
      end;
    end;

    // LIMPAR ID ANTERIOR
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

///////mostrar tela inicio////
procedure TForm9.inicioClick(Sender: TObject);
begin
  Form2.Show;
  Form9.Hide;
end;

///NAVEGAR TELAS////
procedure TForm9.mnuCadeirasClick(Sender: TObject);
begin
 Form7.Show;
  Form9.Hide;
end;

procedure TForm9.mnuControlesClick(Sender: TObject);
begin
  Form4.Show;
  Form9.Hide;
end;

procedure TForm9.mnuFonesClick(Sender: TObject);
begin
 Form5.Show;
  Form9.Hide;
end;

procedure TForm9.mnuHardwareClick(Sender: TObject);
begin
Form8.Show;
  Form9.Hide;
end;

procedure TForm9.mnuMousesClick(Sender: TObject);
begin
 Form6.Show;
  Form9.Hide;
end;

procedure TForm9.mnuPerfilClick(Sender: TObject);
begin
   Form12.Show;
  Form9.Hide;
end;

procedure TForm9.mnuTecladosClick(Sender: TObject);
begin
Form3.Show;
  Form9.Hide;
end;

/////ADICIONAR CARRINHO//////////

{ ========== MONITOR 1 ========== }

procedure TForm9.pnlCarrinhoMonitor1Click(Sender: TObject);
begin
  if pnlMonitor1.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeMonitor1.Caption,
    lblPrecoMonitor1.Caption,
    imgMonitor1,
    pnlMonitor1.Tag
  );

  ShowMessage(lblNomeMonitor1.Caption + ' adicionado ao carrinho!');
end;


{ ========== MONITOR 2 ========== }

procedure TForm9.pnlCarrinhoMonitor2Click(Sender: TObject);
begin
  if pnlMonitor2.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeMonitor2.Caption,
    lblPrecoMonitor2.Caption,
    imgMonitor2,
    pnlMonitor2.Tag
  );

  ShowMessage(lblNomeMonitor2.Caption + ' adicionado ao carrinho!');
end;

///////BOTAO VOLTAR///////
procedure TForm9.pnlVoltarClick(Sender: TObject);
begin
 Form2.Show;
  Self.Hide;
end;

///MOSTRAR CARRINHO////////
procedure TForm9.mnuCarrinhoClick(Sender: TObject);
begin
  Form11.Show;
  Self.Hide;
end;

end.
