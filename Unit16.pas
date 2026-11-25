
unit Unit16;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBGrids, Vcl.Grids,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TForm16 = class(TForm)
    pnlMenuAdmin: TPanel;
    scrMenuAdmin: TScrollBox;
    pnlFundoMenu: TPanel;
    lblLogoAdmin: TLabel;

    pnlVisaoGeral: TPanel;
    pnlClientes: TPanel;
    pnlProdutos: TPanel;
    pnlFornecedores: TPanel;
    pnlFuncionarios: TPanel;
    pnlEstoque: TPanel;
    pnlVendas: TPanel;
    pnlPagamentos: TPanel;
    pnlSairAdmin: TPanel;

    pnlConteudoAdmin: TPanel;
    scrAdmin: TScrollBox;
    pnlPrincipalAdmin: TPanel;

    lblTituloAdmin: TLabel;
    lblDescricaoAdmin: TLabel;

    pnlTotalClientes: TPanel;
    pnlTotalProdutos: TPanel;
    pnlTotalVendas: TPanel;
    pnlTotalEstoque: TPanel;

    lblCardClientes: TLabel;
    lblValorClientes: TLabel;
    lblCardProdutos: TLabel;
    lblValorProdutos: TLabel;
    lblValorVendas: TLabel;
    lblCardEstoque: TLabel;
    lblValorEstoque: TLabel;

    pnlConsultas: TPanel;
    lblTituloConsulta: TLabel;
    edtPesquisarAdmin: TEdit;
    pnlPesquisarAdmin: TPanel;
    dbgConsultasAdmin: TDBGrid;

    pnlNovoAdmin: TPanel;
    pnlEditarAdmin: TPanel;
    pnlExcluirAdmin: TPanel;
    pnlAtualizarAdmin: TPanel;

    qryAdmin: TFDQuery;
    dsAdmin: TDataSource;

    procedure FormCreate(Sender: TObject);

    procedure pnlVisaoGeralClick(Sender: TObject);
    procedure pnlClientesClick(Sender: TObject);
    procedure pnlProdutosClick(Sender: TObject);
    procedure pnlFornecedoresClick(Sender: TObject);
    procedure pnlFuncionariosClick(Sender: TObject);
    procedure pnlEstoqueClick(Sender: TObject);
    procedure pnlVendasClick(Sender: TObject);
    procedure pnlPagamentosClick(Sender: TObject);
    procedure pnlSairAdminClick(Sender: TObject);

    procedure pnlPesquisarAdminClick(Sender: TObject);
    procedure pnlNovoAdminClick(Sender: TObject);
    procedure pnlEditarAdminClick(Sender: TObject);
    procedure pnlExcluirAdminClick(Sender: TObject);
    procedure pnlAtualizarAdminClick(Sender: TObject);

  private
    FSecaoAtual: string;

    procedure PrepararConexao;
    procedure ExecutarConsulta(const ASQL: string);
    procedure AbrirSecao(
      const ASecao, ATitulo, ASQL: string);
    procedure CarregarIndicadores;
    procedure AtualizarSecao;
    procedure OrganizarBotoes;
    procedure ConsultarTotal(
      const ASQL: string; ADestino: TLabel);

  public
  end;

var
  Form16: TForm16;

implementation

uses
  Unit1, Unit13, Unit17;

{$R *.dfm}

// ========================================
// INICIALIZACAO
// ========================================

procedure TForm16.FormCreate(Sender: TObject);
begin
  FSecaoAtual := 'GERAL';

  qryAdmin.Connection := dmBanco.conBanco;
  dsAdmin.DataSet := qryAdmin;
  dbgConsultasAdmin.DataSource := dsAdmin;
  dbgConsultasAdmin.ReadOnly := True;

  lblTituloAdmin.Caption :=
    'Painel Administrativo';

  lblTituloConsulta.Caption :=
    'Visao Geral';

  OrganizarBotoes;

  try
    CarregarIndicadores;
  except
    on E: Exception do
      ShowMessage(
        'Erro ao carregar indicadores: ' +
        E.Message);
  end;
end;

// ========================================
// ORGANIZAR BOTOES ADMINISTRATIVOS
// ========================================

procedure TForm16.OrganizarBotoes;
var
  PosicaoY: Integer;
begin
  // Os botoes ficam abaixo da tabela.
  // Todos pertencem ao pnlConsultas.

  dbgConsultasAdmin.Align := alNone;

  PosicaoY :=
    dbgConsultasAdmin.Top +
    dbgConsultasAdmin.Height + 15;

  pnlNovoAdmin.Align := alNone;
  pnlEditarAdmin.Align := alNone;
  pnlExcluirAdmin.Align := alNone;
  pnlAtualizarAdmin.Align := alNone;

  pnlNovoAdmin.SetBounds(
    20, PosicaoY, 150, 45);

  pnlEditarAdmin.SetBounds(
    190, PosicaoY, 150, 45);

  pnlExcluirAdmin.SetBounds(
    360, PosicaoY, 150, 45);

  pnlAtualizarAdmin.SetBounds(
    530, PosicaoY, 150, 45);

  pnlNovoAdmin.Visible := True;
  pnlEditarAdmin.Visible := True;
  pnlExcluirAdmin.Visible := True;
  pnlAtualizarAdmin.Visible := True;

  pnlNovoAdmin.Enabled := True;
  pnlEditarAdmin.Enabled := True;
  pnlExcluirAdmin.Enabled := True;
  pnlAtualizarAdmin.Enabled := True;

  pnlNovoAdmin.BringToFront;
  pnlEditarAdmin.BringToFront;
  pnlExcluirAdmin.BringToFront;
  pnlAtualizarAdmin.BringToFront;

  if pnlConsultas.Height < PosicaoY + 65 then
    pnlConsultas.Height := PosicaoY + 65;

  if pnlPrincipalAdmin.Height <
     pnlConsultas.Top + pnlConsultas.Height + 20 then
    pnlPrincipalAdmin.Height :=
      pnlConsultas.Top + pnlConsultas.Height + 20;
end;

// ========================================
// CONEXAO COM POSTGRESQL
// ========================================

procedure TForm16.PrepararConexao;
begin
  if not Assigned(dmBanco) then
    raise Exception.Create(
      'O DataModule do banco nao foi criado.');

  if not dmBanco.conBanco.Connected then
    dmBanco.conBanco.Connected := True;

  if qryAdmin.Active then
    qryAdmin.Close;

  qryAdmin.Connection := dmBanco.conBanco;
end;

// ========================================
// EXECUTAR CONSULTA
// ========================================

procedure TForm16.ExecutarConsulta(
  const ASQL: string);
begin
  PrepararConexao;

  qryAdmin.SQL.Text := ASQL;
  qryAdmin.Open;
end;

// ========================================
// ABRIR SECAO
// ========================================

procedure TForm16.AbrirSecao(
  const ASecao, ATitulo, ASQL: string);
begin
  try
    ExecutarConsulta(ASQL);

    FSecaoAtual := ASecao;

    lblTituloAdmin.Caption := ATitulo;
    lblTituloConsulta.Caption :=
      'Consulta de ' + ATitulo;

    edtPesquisarAdmin.Clear;

    OrganizarBotoes;

  except
    on E: Exception do
      ShowMessage(
        'Erro ao abrir ' + ATitulo +
        ': ' + E.Message);
  end;
end;

// ========================================
// CONSULTAR INDICADORES
// ========================================

procedure TForm16.ConsultarTotal(
  const ASQL: string; ADestino: TLabel);
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := dmBanco.conBanco;
    Q.SQL.Text := ASQL;
    Q.Open;

    ADestino.Caption :=
      Q.FieldByName('total').AsString;

  finally
    Q.Free;
  end;
end;

procedure TForm16.CarregarIndicadores;
begin
  if not dmBanco.conBanco.Connected then
    dmBanco.conBanco.Connected := True;

  ConsultarTotal(
    'SELECT COUNT(*) AS total FROM clientes',
    lblValorClientes);

  ConsultarTotal(
    'SELECT COUNT(*) AS total FROM produtos',
    lblValorProdutos);

  ConsultarTotal(
    'SELECT COUNT(*) AS total FROM vendas',
    lblValorVendas);

  ConsultarTotal(
    'SELECT COALESCE(' +
    'SUM(quantidade_estoque), 0) AS total ' +
    'FROM produtos',
    lblValorEstoque);
end;

// ========================================
// VISAO GERAL
// ========================================

procedure TForm16.pnlVisaoGeralClick(
  Sender: TObject);
begin
  try
    CarregarIndicadores;

    FSecaoAtual := 'GERAL';

    lblTituloAdmin.Caption :=
      'Painel Administrativo';

    lblTituloConsulta.Caption :=
      'Visao Geral';

    edtPesquisarAdmin.Clear;
    qryAdmin.Close;

    OrganizarBotoes;

  except
    on E: Exception do
      ShowMessage(
        'Erro ao carregar indicadores: ' +
        E.Message);
  end;
end;

// ========================================
// CLIENTES
// ========================================

procedure TForm16.pnlClientesClick(
  Sender: TObject);
begin
  AbrirSecao(
    'CLIENTES',
    'Clientes',
    'SELECT id_cliente, nome, email, ativo ' +
    'FROM clientes ORDER BY id_cliente');
end;

// ========================================
// PRODUTOS
// ========================================

procedure TForm16.pnlProdutosClick(
  Sender: TObject);
begin
  AbrirSecao(
    'PRODUTOS',
    'Produtos',
    'SELECT id_produto, nome, marca, modelo, ' +
    'preco_venda, quantidade_estoque, ativo ' +
    'FROM produtos ORDER BY id_produto');
end;

// ========================================
// FORNECEDORES
// ========================================

procedure TForm16.pnlFornecedoresClick(
  Sender: TObject);
begin
  AbrirSecao(
    'FORNECEDORES',
    'Fornecedores',
    'SELECT * FROM fornecedores');
end;

// ========================================
// FUNCIONARIOS
// ========================================

procedure TForm16.pnlFuncionariosClick(
  Sender: TObject);
begin
  AbrirSecao(
    'FUNCIONARIOS',
    'Funcionarios',
    'SELECT id_funcionario, nome, cpf, ' +
    'email, telefone, cargo, salario, ' +
    'data_admissao, ativo ' +
    'FROM funcionarios ORDER BY id_funcionario');
end;

// ========================================
// ESTOQUE
// ========================================

procedure TForm16.pnlEstoqueClick(
  Sender: TObject);
begin
  AbrirSecao(
    'ESTOQUE',
    'Estoque',
    'SELECT id_produto, nome, marca, ' +
    'quantidade_estoque, estoque_minimo ' +
    'FROM produtos ORDER BY nome');
end;

// ========================================
// VENDAS
// ========================================

procedure TForm16.pnlVendasClick(
  Sender: TObject);
begin
  AbrirSecao(
    'VENDAS',
    'Vendas',
    'SELECT * FROM vendas');
end;

// ========================================
// PAGAMENTOS
// ========================================

procedure TForm16.pnlPagamentosClick(
  Sender: TObject);
begin
  AbrirSecao(
    'PAGAMENTOS',
    'Pagamentos',
    'SELECT * FROM pagamentos');
end;

// ========================================
// PESQUISAR
// ========================================

procedure TForm16.pnlPesquisarAdminClick(
  Sender: TObject);
var
  TextoPesquisa: string;
begin
  TextoPesquisa := Trim(edtPesquisarAdmin.Text);

  if TextoPesquisa = '' then
  begin
    AtualizarSecao;
    Exit;
  end;

  try
    PrepararConexao;

    if FSecaoAtual = 'CLIENTES' then
    begin
      qryAdmin.SQL.Text :=
        'SELECT id_cliente, nome, email, ativo ' +
        'FROM clientes ' +
        'WHERE nome ILIKE :pesquisa ' +
        'OR email ILIKE :pesquisa ' +
        'ORDER BY id_cliente';
    end

    else if FSecaoAtual = 'PRODUTOS' then
    begin
      qryAdmin.SQL.Text :=
        'SELECT id_produto, nome, marca, modelo, ' +
        'preco_venda, quantidade_estoque, ativo ' +
        'FROM produtos ' +
        'WHERE nome ILIKE :pesquisa ' +
        'OR marca ILIKE :pesquisa ' +
        'OR modelo ILIKE :pesquisa ' +
        'ORDER BY id_produto';
    end

    else if FSecaoAtual = 'FUNCIONARIOS' then
    begin
      qryAdmin.SQL.Text :=
        'SELECT id_funcionario, nome, cpf, ' +
        'email, telefone, cargo, salario, ' +
        'data_admissao, ativo ' +
        'FROM funcionarios ' +
        'WHERE nome ILIKE :pesquisa ' +
        'OR cargo ILIKE :pesquisa ' +
        'ORDER BY id_funcionario';
    end

    else if FSecaoAtual = 'ESTOQUE' then
    begin
      qryAdmin.SQL.Text :=
        'SELECT id_produto, nome, marca, ' +
        'quantidade_estoque, estoque_minimo ' +
        'FROM produtos ' +
        'WHERE nome ILIKE :pesquisa ' +
        'ORDER BY nome';
    end

    else
    begin
      ShowMessage(
        'Pesquisa ainda nao configurada ' +
        'para esta secao.');
      Exit;
    end;

    qryAdmin.ParamByName('pesquisa').AsString :=
      '%' + TextoPesquisa + '%';

    qryAdmin.Open;

  except
    on E: Exception do
      ShowMessage(
        'Erro ao pesquisar: ' + E.Message);
  end;
end;

// ========================================
// ATUALIZAR SECAO
// ========================================

procedure TForm16.AtualizarSecao;
begin
  if FSecaoAtual = 'CLIENTES' then
    pnlClientesClick(nil)

  else if FSecaoAtual = 'PRODUTOS' then
    pnlProdutosClick(nil)

  else if FSecaoAtual = 'FORNECEDORES' then
    pnlFornecedoresClick(nil)

  else if FSecaoAtual = 'FUNCIONARIOS' then
    pnlFuncionariosClick(nil)

  else if FSecaoAtual = 'ESTOQUE' then
    pnlEstoqueClick(nil)

  else if FSecaoAtual = 'VENDAS' then
    pnlVendasClick(nil)

  else if FSecaoAtual = 'PAGAMENTOS' then
    pnlPagamentosClick(nil)

  else
    pnlVisaoGeralClick(nil);
end;

procedure TForm16.pnlAtualizarAdminClick(
  Sender: TObject);
begin
  AtualizarSecao;
end;

// ========================================
// ADICIONAR PRODUTO
// ========================================

procedure TForm16.pnlNovoAdminClick(
  Sender: TObject);
begin
  if FSecaoAtual = 'PRODUTOS' then
  begin
    with TForm17.Create(Self) do
    try
      if ShowModal = mrOk then
      begin
        AtualizarSecao;
        CarregarIndicadores;
      end;
    finally
      Free;
    end;
  end
  else
  begin
    ShowMessage(
      'O cadastro de ' + FSecaoAtual +
      ' sera implementado na proxima etapa.');
  end;
end;

// ========================================
// EDITAR
// ========================================

procedure TForm16.pnlEditarAdminClick(
  Sender: TObject);
begin
  ShowMessage(
    'A edicao de ' + FSecaoAtual +
    ' sera implementada na proxima etapa.');
end;

// ========================================
// EXCLUIR
// ========================================

procedure TForm16.pnlExcluirAdminClick(
  Sender: TObject);
begin
  ShowMessage(
    'A exclusao de ' + FSecaoAtual +
    ' sera implementada na proxima etapa.');
end;

// ========================================
// SAIR DO SISTEMA
// ========================================

procedure TForm16.pnlSairAdminClick(
  Sender: TObject);
begin
  qryAdmin.Close;

  ClienteLogadoID := 0;

  Form1.edtSenha.Clear;
  Form1.edtEmail.Clear;

  Form1.Show;
  Self.Hide;
end;

end.

