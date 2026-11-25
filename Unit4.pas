unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.Menus;

type
  TForm4 = class(TForm)
    scrControles: TScrollBox;
    pnlCatalogoControles: TPanel;
    lblTituloControles: TLabel;
    pnlControle1: TPanel;
    pnlControle2: TPanel;
    imgControle1: TImage;
    imgControle2: TImage;
    lblNomeControle1: TLabel;
    lblNomeControle2: TLabel;
    lblPrecoControle1: TLabel;
    Label1: TLabel;
    pnlCarrinhoControle1: TPanel;
    pnlCarrinhoControle2: TPanel;
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
    procedure pnlCarrinhoControle1Click(Sender: TObject);
    procedure pnlCarrinhoControle2Click(Sender: TObject);
    procedure inicioClick(Sender: TObject);
    procedure mnuTecladosClick(Sender: TObject);
    procedure mnuFonesClick(Sender: TObject);
    procedure mnuMousesClick(Sender: TObject);
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
  Form4: TForm4;

implementation
uses
UnitCarrinho, Unit11, Unit2, Unit3, Unit5, Unit6, Unit7, Unit8, Unit9, Unit12, Unit13;

{$R *.dfm}

///////////////NAVEGAR PELAS CATEGORIAS/////////////

procedure TForm4.FormResize(Sender: TObject);
begin
  // Posiciona o botão Voltar
  pnlVoltar.Left := ClientWidth - pnlVoltar.Width - 15;
  pnlVoltar.Top := 10;

  // Ajusta o fundo roxo à área do ScrollBox
  pnlCatalogoControles.Width := scrControles.ClientWidth;
  pnlCatalogoControles.Height := scrControles.ClientHeight;

end;



procedure TForm4.FormShow(Sender: TObject);
var
  I: Integer;
  LNome, LPreco: TLabel;
  Painel: TPanel;
begin
  if not dmBanco.conBanco.Connected then
    dmBanco.conBanco.Connected := True;

  dmBanco.qryProdutos.Close;

  dmBanco.qryProdutos.SQL.Text :=
    'SELECT id_produto, nome, preco_venda ' +
    'FROM produtos ' +
    'WHERE id_categoria = :categoria ' +
    'ORDER BY id_produto';

  dmBanco.qryProdutos.ParamByName('categoria').AsInteger := 1;
  dmBanco.qryProdutos.Open;

  for I := 1 to 2 do
  begin
    if I = 1 then
    begin
      Painel := pnlControle1;
      LNome := lblNomeControle1;
      LPreco := lblPrecoControle1;
    end
    else
    begin
      Painel := pnlControle2;
      LNome := lblNomeControle2;
      LPreco := Label1;
    end;

    Painel.Tag := 0;

    if not dmBanco.qryProdutos.Eof then
    begin
      Painel.Visible := True;

      Painel.Tag :=
        dmBanco.qryProdutos.FieldByName('id_produto').AsInteger;

      LNome.Caption :=
        dmBanco.qryProdutos.FieldByName('nome').AsString;

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

procedure TForm4.inicioClick(Sender: TObject);
begin
  if not Assigned(Form2) then
    Form2 := TForm2.Create(Application);

  Form2.Show;
  Form2.BringToFront;
  Self.Hide;
end;

procedure TForm4.mnuTecladosClick(Sender: TObject);
begin
 if not Assigned(Form3) then
    Form3 := TForm3.Create(Application);

  Form3.Show;
  Form3.BringToFront;
  Self.Hide;
end;

procedure TForm4.mnuFonesClick(Sender: TObject);
begin
if not Assigned(Form5) then
    Form5 := TForm5.Create(Application);

  Form5.Show;
  Form5.BringToFront;
  Self.Hide;
end;

procedure TForm4.mnuMousesClick(Sender: TObject);
begin
 if not Assigned(Form6) then
    Form6 := TForm6.Create(Application);

  Form6.Show;
  Form6.BringToFront;
  Self.Hide;
end;

procedure TForm4.mnuPerfilClick(Sender: TObject);
begin
  Form12.Show;
  Form4.Hide;
end;

procedure TForm4.mnuCadeirasClick(Sender: TObject);
begin
  if not Assigned(Form7) then
    Form7 := TForm7.Create(Application);

  Form7.Show;
  Form7.BringToFront;
  Self.Hide;
end;

procedure TForm4.mnuHardwareClick(Sender: TObject);
begin
Form8.Show;
  Form4.Hide;
end;

procedure TForm4.mnuMonitoresClick(Sender: TObject);
begin
  Form9.Show;
  Form4.Hide;
end;



procedure TForm4.pnlCarrinhoControle1Click(Sender: TObject);
begin
  if pnlControle1.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeControle1.Caption,
    lblPrecoControle1.Caption,
    imgControle1,
    pnlControle1.Tag
  );

  ShowMessage(lblNomeControle1.Caption + ' adicionado ao carrinho!');
end;




procedure TForm4.pnlCarrinhoControle2Click(Sender: TObject);
begin
  if pnlControle2.Tag <= 0 then
  begin
    ShowMessage('Produto indisponível.');
    Exit;
  end;

  AdicionarProduto(
    lblNomeControle2.Caption,
    Label1.Caption,
    imgControle2,
    pnlControle2.Tag
  );

  ShowMessage(lblNomeControle2.Caption + ' adicionado ao carrinho!');
end;


procedure TForm4.pnlVoltarClick(Sender: TObject);
begin
  Form2.Show;
  Self.Hide;
end;

procedure TForm4.mnuCarrinhoClick(Sender: TObject);
begin
  Form11.Show;
  Self.Hide;
end;

end.
