
unit Unit14;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  FireDAC.Comp.Client;

type
  TForm14 = class(TForm)

    // PAINEL PRINCIPAL
    pnlFundoPagamento: TPanel;

    // FORMAS DE PAGAMENTO
    pnlFormaPagamento: TPanel;
    lblTituloFormaPagamento: TLabel;
    rbPix: TRadioButton;
    rbCredito: TRadioButton;
    rbDebito: TRadioButton;

    // BOTOES
    pnlAprovarPagamento: TPanel;
    pnlRecusarPagamento: TPanel;

    // RESUMO DO PEDIDO
    pnlResumoPagamento: TPanel;
    lblTituloResumo: TLabel;
    lblQuantidadePagamento: TLabel;
    lblTotalPagamento: TLabel;

    // EVENTOS
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlAprovarPagamentoClick(Sender: TObject);
    procedure pnlRecusarPagamentoClick(Sender: TObject);

  private

  public

  end;

var
  Form14: TForm14;

implementation

uses
  UnitCarrinho,
  Unit1,
  Unit13,
  Unit11;

{$R *.dfm}


// ==========================================
// EXIBIR RESUMO DO PAGAMENTO
// ==========================================

procedure TForm14.FormShow(Sender: TObject);
var
  I: Integer;
  QuantidadeTotal: Integer;
begin

  lblTotalPagamento.Caption :=
    'Total: ' + Dinheiro(TotalCarrinho);

  QuantidadeTotal := 0;

  for I := 0 to ItensCarrinho.Count - 1 do
  begin
    QuantidadeTotal :=
      QuantidadeTotal + ItensCarrinho[I].Quantidade;
  end;

  lblQuantidadePagamento.Caption :=
    'Quantidade de produtos: ' +
    IntToStr(QuantidadeTotal);

end;


// ==========================================
// AJUSTAR PAINEIS AO TAMANHO DA TELA
// ==========================================

procedure TForm14.FormResize(Sender: TObject);
var
  Margem: Integer;
  Espaco: Integer;
  LarguraPainel: Integer;
  AlturaPainel: Integer;
begin

  Margem := 50;
  Espaco := 25;

  LarguraPainel :=
    (pnlFundoPagamento.ClientWidth -
    2 * Margem - Espaco) div 2;

  AlturaPainel :=
    pnlFundoPagamento.ClientHeight - 230;

  if LarguraPainel < 1 then
    LarguraPainel := 1;

  if AlturaPainel < 1 then
    AlturaPainel := 1;

  pnlFormaPagamento.SetBounds(
    Margem,
    150,
    LarguraPainel,
    AlturaPainel
  );

  pnlResumoPagamento.SetBounds(
    Margem + LarguraPainel + Espaco,
    150,
    LarguraPainel,
    AlturaPainel
  );

end;


// ==========================================
// BOTAO RECUSAR PAGAMENTO
// ==========================================

procedure TForm14.pnlRecusarPagamentoClick(
  Sender: TObject);
begin

  ShowMessage(
    'PAGAMENTO RECUSADO!' + sLineBreak +
    sLineBreak +
    'A operacao nao foi autorizada.' +
    sLineBreak +
    'Selecione outra forma de pagamento ' +
    'e tente novamente.'
  );

  // NAO ALTERAR O BANCO DE DADOS
  // NAO DIMINUIR O ESTOQUE
  // NAO LIMPAR O CARRINHO

end;


// ==========================================
// BOTAO APROVAR PAGAMENTO
// ==========================================

procedure TForm14.pnlAprovarPagamentoClick(
  Sender: TObject);
var
  FormaPagamento: string;

  QryVenda: TFDQuery;
  QryEstoque: TFDQuery;
  QryItens: TFDQuery;
  QryAtualizarEstoque: TFDQuery;
  QryPagamento: TFDQuery;

  IDVenda: Integer;
  I: Integer;
  TotalCarrinhoVenda: Currency;
  VendaConfirmada: Boolean;

begin

  // ======================================
  // 1. VERIFICAR O CARRINHO
  // ======================================

  if ItensCarrinho.Count = 0 then
  begin
    ShowMessage('O carrinho esta vazio.');
    Exit;
  end;

  // ======================================
  // 2. VERIFICAR O CLIENTE
  // ======================================

  if ClienteLogadoID <= 0 then
  begin
    ShowMessage(
      'Cliente nao identificado. Faca login novamente.'
    );
    Exit;
  end;

  // ======================================
  // 3. IDENTIFICAR FORMA DE PAGAMENTO
  // ======================================

  if rbPix.Checked then
    FormaPagamento := 'PIX'
  else if rbCredito.Checked then
    FormaPagamento := 'CREDITO'
  else if rbDebito.Checked then
    FormaPagamento := 'DEBITO'
  else
  begin
    ShowMessage('Selecione uma forma de pagamento.');
    Exit;
  end;

  // ======================================
  // 4. VERIFICAR CONEXAO
  // ======================================

  if not dmBanco.conBanco.Connected then
  begin
    ShowMessage('Banco de dados desconectado.');
    Exit;
  end;

  // ======================================
  // 5. PREPARAR DADOS DA VENDA
  // ======================================

  TotalCarrinhoVenda := TotalCarrinho;

  QryVenda := nil;
  QryEstoque := nil;
  QryItens := nil;
  QryAtualizarEstoque := nil;
  QryPagamento := nil;

  IDVenda := 0;
  VendaConfirmada := False;

  try
    try

      // ======================================
      // 6. INICIAR TRANSACAO
      // ======================================

      dmBanco.conBanco.StartTransaction;

      // ======================================
      // 7. VERIFICAR ESTOQUE
      // ======================================

      QryEstoque := TFDQuery.Create(nil);
      QryEstoque.Connection := dmBanco.conBanco;

      QryEstoque.SQL.Text :=
        'SELECT quantidade_estoque ' +
        'FROM produtos ' +
        'WHERE id_produto = :id_produto ' +
        'FOR UPDATE';

      for I := 0 to ItensCarrinho.Count - 1 do
      begin

        if ItensCarrinho[I].IDProduto <= 0 then
          raise Exception.Create(
            'Produto com ID invalido: ' +
            ItensCarrinho[I].Nome
          );

        if ItensCarrinho[I].Quantidade <= 0 then
          raise Exception.Create(
            'Quantidade invalida: ' +
            ItensCarrinho[I].Nome
          );

        QryEstoque.Close;

        QryEstoque.ParamByName('id_produto').AsInteger :=
          ItensCarrinho[I].IDProduto;

        QryEstoque.Open;

        if QryEstoque.IsEmpty then
          raise Exception.Create(
            'Produto nao encontrado: ' +
            ItensCarrinho[I].Nome
          );

        if QryEstoque.FieldByName(
          'quantidade_estoque').AsInteger <
          ItensCarrinho[I].Quantidade then
        begin
          raise Exception.Create(
            'Estoque insuficiente para: ' +
            ItensCarrinho[I].Nome
          );
        end;

      end;

      QryEstoque.Close;

      // ======================================
      // 8. REGISTRAR VENDA
      // ======================================

      QryVenda := TFDQuery.Create(nil);
      QryVenda.Connection := dmBanco.conBanco;

      QryVenda.SQL.Text :=
        'INSERT INTO vendas ' +
        '(id_cliente, valor_total, forma_pagamento, status) ' +
        'VALUES (:cliente, :total, :forma, :status) ' +
        'RETURNING id_venda';

      QryVenda.ParamByName('cliente').AsInteger :=
        ClienteLogadoID;

      QryVenda.ParamByName('total').AsCurrency :=
        TotalCarrinhoVenda;

      QryVenda.ParamByName('forma').AsString :=
        FormaPagamento;

      QryVenda.ParamByName('status').AsString :=
        'CONCLUIDA';

      QryVenda.Open;

      if QryVenda.IsEmpty then
        raise Exception.Create(
          'Nao foi possivel recuperar o numero da venda.'
        );

      IDVenda :=
        QryVenda.FieldByName('id_venda').AsInteger;

      QryVenda.Close;

      // ======================================
      // 9. REGISTRAR ITENS DA VENDA
      // ======================================

      QryItens := TFDQuery.Create(nil);
      QryItens.Connection := dmBanco.conBanco;

      QryItens.SQL.Text :=
        'INSERT INTO itens_venda ' +
        '(id_venda, id_produto, quantidade, ' +
        'preco_unitario, subtotal) ' +
        'VALUES (:venda, :produto, :quantidade, ' +
        ':preco, :subtotal)';

      for I := 0 to ItensCarrinho.Count - 1 do
      begin

        QryItens.ParamByName('venda').AsInteger :=
          IDVenda;

        QryItens.ParamByName('produto').AsInteger :=
          ItensCarrinho[I].IDProduto;

        QryItens.ParamByName('quantidade').AsInteger :=
          ItensCarrinho[I].Quantidade;

        QryItens.ParamByName('preco').AsCurrency :=
          ItensCarrinho[I].Preco;

        QryItens.ParamByName('subtotal').AsCurrency :=
          ItensCarrinho[I].Preco *
          ItensCarrinho[I].Quantidade;

        QryItens.ExecSQL;

      end;

      // ======================================
      // 10. ATUALIZAR ESTOQUE
      // ======================================

      QryAtualizarEstoque := TFDQuery.Create(nil);
      QryAtualizarEstoque.Connection := dmBanco.conBanco;

      QryAtualizarEstoque.SQL.Text :=
        'UPDATE produtos ' +
        'SET quantidade_estoque = quantidade_estoque - :quantidade ' +
        'WHERE id_produto = :produto ' +
        'AND quantidade_estoque >= :quantidade';

      for I := 0 to ItensCarrinho.Count - 1 do
      begin

        QryAtualizarEstoque.ParamByName('produto').AsInteger :=
          ItensCarrinho[I].IDProduto;

        QryAtualizarEstoque.ParamByName('quantidade').AsInteger :=
          ItensCarrinho[I].Quantidade;

        QryAtualizarEstoque.ExecSQL;

        if QryAtualizarEstoque.RowsAffected <> 1 then
          raise Exception.Create(
            'Nao foi possivel atualizar o estoque de: ' +
            ItensCarrinho[I].Nome
          );

      end;

      // ======================================
      // 11. REGISTRAR PAGAMENTO SIMULADO
      // ======================================

      QryPagamento := TFDQuery.Create(nil);
      QryPagamento.Connection := dmBanco.conBanco;

      QryPagamento.SQL.Text :=
        'INSERT INTO pagamentos ' +
        '(id_venda, forma_pagamento, valor, status, observacao) ' +
        'VALUES (:venda, :forma, :valor, :status, :observacao)';

      QryPagamento.ParamByName('venda').AsInteger :=
        IDVenda;

      QryPagamento.ParamByName('forma').AsString :=
        FormaPagamento;

      QryPagamento.ParamByName('valor').AsCurrency :=
        TotalCarrinhoVenda;

      QryPagamento.ParamByName('status').AsString :=
        'APROVADO';

      QryPagamento.ParamByName('observacao').AsString :=
        'Pagamento aprovado em simulacao academica.';

      QryPagamento.ExecSQL;

      // ======================================
      // 12. CONFIRMAR VENDA NO BANCO
      // ======================================

      dmBanco.conBanco.Commit;

      VendaConfirmada := True;

    except
      on E: Exception do
      begin

        if dmBanco.conBanco.InTransaction then
          dmBanco.conBanco.Rollback;

        ShowMessage(
          'Erro ao processar a venda: ' +
          E.Message
        );

      end;
    end;

  finally

    // ======================================
    // 13. LIBERAR CONSULTAS
    // ======================================

    QryPagamento.Free;
    QryAtualizarEstoque.Free;
    QryItens.Free;
    QryEstoque.Free;
    QryVenda.Free;

  end;

  // ======================================
  // 14. FINALIZAR COMPRA
  // ======================================

  if VendaConfirmada then
  begin

    // LIMPAR O CARRINHO APOS O COMMIT
    ItensCarrinho.Clear;

    // ATUALIZAR RESUMO VISUAL
    lblQuantidadePagamento.Caption :=
      'Quantidade de produtos: 0';

    lblTotalPagamento.Caption :=
      'Total: ' + Dinheiro(TotalCarrinho);

    // EXIBIR CONFIRMACAO
    ShowMessage(
      'COMPRA FINALIZADA COM SUCESSO!' + sLineBreak +
      sLineBreak +
      'Numero do pedido: ' + IntToStr(IDVenda) +
      sLineBreak +
      'Forma de pagamento: ' + FormaPagamento +
      sLineBreak +
      'Total: ' + Dinheiro(TotalCarrinhoVenda) +
      sLineBreak + sLineBreak +
      'Pagamento simulado aprovado!' +
      sLineBreak +
      'Obrigado por comprar na Nexus Gaming!'
    );

    // ======================================
    // 15. RETORNAR AO CARRINHO VAZIO
    // ======================================

    // O FormShow DO FORM11 JA CHAMA AtualizarCarrinho
    Form11.Show;

    // OCULTAR A TELA DE PAGAMENTO
    Hide;

  end;

end;

end.

