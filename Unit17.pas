unit Unit17;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TForm17 = class(TForm)
    lblTituloCadastro: TLabel;
    lblNomeProduto: TLabel;
    edtNomeProduto: TEdit;
    scrCadastroProdutos: TScrollBox;
    pnlFundoCadastro: TPanel;
    lblCategoriaProduto: TLabel;
    cmbCategoriaProduto: TComboBox;
    lblCodigoBarras: TLabel;
    edtCodigoBarras: TEdit;
    lblDescricaoProduto: TLabel;
    memDescricaoProduto: TMemo;
    lblPrecoCusto: TLabel;
    edtPrecoCusto: TEdit;
    lblPrecoVenda: TLabel;
    edtPrecoVenda: TEdit;
    lblEstoqueAtual: TLabel;
    edtEstoqueAtual: TEdit;
    lblEstoqueMinimo: TLabel;
    edtEstoqueMinimo: TEdit;
    chkProdutoAtivo: TCheckBox;
    pnlSalvarProduto: TPanel;
    pnlCancelarProduto: TPanel;
    lblMarcaProduto: TLabel;
    edtMarcaProduto: TEdit;
    lblModeloProduto: TLabel;
    edtModeloProduto: TEdit;
    qryCategorias: TFDQuery;
    qrySalvarProduto: TFDQuery;
    procedure pnlCancelarProdutoClick(Sender: TObject);
    procedure pnlSalvarProdutoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form17: TForm17;

implementation

Uses Unit13;

{$R *.dfm}

procedure TForm17.FormCreate(Sender: TObject);
begin
qryCategorias.Connection := dmBanco.conBanco;

qrySalvarProduto.Connection := dmBanco.conBanco;

 if not dmBanco.conBanco.Connected then
    dmBanco.conBanco.Connected := True;

  qryCategorias.Close;
  qryCategorias.SQL.Text :=
    'SELECT id_categoria, nome ' +
    'FROM categorias ' +
    'ORDER BY nome';

  qryCategorias.Open;

  cmbCategoriaProduto.Items.Clear;

  while not qryCategorias.Eof do
  begin
    cmbCategoriaProduto.Items.AddObject(
      qryCategorias.FieldByName('nome').AsString,
      TObject(NativeInt(
        qryCategorias.FieldByName('id_categoria').AsInteger
      ))
    );

    qryCategorias.Next;
  end;

  qryCategorias.Close;
end;

procedure TForm17.pnlCancelarProdutoClick(Sender: TObject);
begin
  Close;
end;


procedure TForm17.pnlSalvarProdutoClick(Sender: TObject);
var
  IdCategoria: Integer;
  PrecoCusto, PrecoVenda: Currency;
  EstoqueAtual, EstoqueMinimo: Integer;
begin
  if Trim(edtNomeProduto.Text) = '' then
  begin
    ShowMessage('Informe o nome do produto.');
    edtNomeProduto.SetFocus;
    Exit;
  end;

  if cmbCategoriaProduto.ItemIndex = -1 then
  begin
    ShowMessage('Selecione uma categoria.');
    cmbCategoriaProduto.SetFocus;
    Exit;
  end;

  if not TryStrToCurr(Trim(edtPrecoCusto.Text), PrecoCusto) or
     (PrecoCusto < 0) then
  begin
    ShowMessage('Informe um preco de custo valido.');
    edtPrecoCusto.SetFocus;
    Exit;
  end;

  if not TryStrToCurr(Trim(edtPrecoVenda.Text), PrecoVenda) or
     (PrecoVenda < 0) then
  begin
    ShowMessage('Informe um preco de venda valido.');
    edtPrecoVenda.SetFocus;
    Exit;
  end;

  if not TryStrToInt(Trim(edtEstoqueAtual.Text), EstoqueAtual) or
     (EstoqueAtual < 0) then
  begin
    ShowMessage('Informe uma quantidade valida.');
    edtEstoqueAtual.SetFocus;
    Exit;
  end;

  if not TryStrToInt(Trim(edtEstoqueMinimo.Text), EstoqueMinimo) or
     (EstoqueMinimo < 0) then
  begin
    ShowMessage('Informe um estoque minimo valido.');
    edtEstoqueMinimo.SetFocus;
    Exit;
  end;

  IdCategoria := Integer(NativeInt(
    cmbCategoriaProduto.Items.Objects[cmbCategoriaProduto.ItemIndex]
  ));

  try
    qrySalvarProduto.Close;
    qrySalvarProduto.SQL.Text :=
      'INSERT INTO produtos (' +
      'id_categoria, nome, marca, modelo, ' +
      'codigo_barras, descricao, preco_custo, ' +
      'preco_venda, quantidade_estoque, ' +
      'estoque_minimo, ativo) ' +
      'VALUES (:categoria, :nome, :marca, :modelo, ' +
      ':codigo, :descricao, :custo, :venda, ' +
      ':estoque, :minimo, :ativo)';

    qrySalvarProduto.ParamByName('categoria').AsInteger := IdCategoria;
    qrySalvarProduto.ParamByName('nome').AsString := Trim(edtNomeProduto.Text);
    qrySalvarProduto.ParamByName('marca').AsString := Trim(edtMarcaProduto.Text);
    qrySalvarProduto.ParamByName('modelo').AsString := Trim(edtModeloProduto.Text);
    qrySalvarProduto.ParamByName('codigo').AsString := Trim(edtCodigoBarras.Text);
    qrySalvarProduto.ParamByName('descricao').AsString := memDescricaoProduto.Text;
    qrySalvarProduto.ParamByName('custo').AsCurrency := PrecoCusto;
    qrySalvarProduto.ParamByName('venda').AsCurrency := PrecoVenda;
    qrySalvarProduto.ParamByName('estoque').AsInteger := EstoqueAtual;
    qrySalvarProduto.ParamByName('minimo').AsInteger := EstoqueMinimo;
    qrySalvarProduto.ParamByName('ativo').AsBoolean := chkProdutoAtivo.Checked;

    qrySalvarProduto.ExecSQL;

    ShowMessage('Produto cadastrado com sucesso!');
    ModalResult := mrOk;

  except
    on E: Exception do
      ShowMessage('Erro ao cadastrar produto: ' + E.Message);
  end;
end;

end.
