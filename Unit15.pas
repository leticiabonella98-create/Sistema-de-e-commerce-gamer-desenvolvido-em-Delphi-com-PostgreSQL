
unit Unit15;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  FireDAC.Comp.Client;

type
  TForm15 = class(TForm)

    // ========================================
    // 1. COMPONENTES DA TELA
    // ========================================

    // FUNDO DA TELA
    pnlFundoPedidos: TPanel;

    // TITULO
    lblTituloPedidos: TLabel;

    // LISTA DE PEDIDOS
    scrPedidos: TScrollBox;
    pnlListaPedidos: TPanel;

    // BOTAO VOLTAR
    pnlVoltarInicio: TPanel;

    // ========================================
    // 2. EVENTOS DO FORMULARIO
    // ========================================

    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlVoltarInicioClick(Sender: TObject);

  private

    // CARREGAR HISTORICO DE PEDIDOS
    procedure CarregarPedidos;

    // CONSULTAR PRODUTOS DO PEDIDO
    procedure VerDetalhesPedido(Sender: TObject);

    // CONFIGURAR BOTAO VOLTAR
    procedure ConfigurarBotaoVoltar;

  public
  end;

var
  Form15: TForm15;

implementation

uses
  Unit2,
  Unit1,
  Unit13,
  UnitCarrinho;

{$R *.dfm}


// ==========================================
// 3. FUNCAO AUXILIAR - CRIAR TEXTOS
// ==========================================

function CriarTextoPedido(
  Pai: TWinControl;
  const Conteudo: string;
  X, Y, Tamanho: Integer;
  Cor: TColor;
  Negrito: Boolean = False
): TLabel;
begin

  Result := TLabel.Create(Pai);
  Result.Parent := Pai;

  Result.Left := X;
  Result.Top := Y;

  Result.Caption := Conteudo;
  Result.AutoSize := True;
  Result.Transparent := True;

  Result.Font.Name := 'Segoe UI';
  Result.Font.Size := Tamanho;
  Result.Font.Color := Cor;

  if Negrito then
    Result.Font.Style := [fsBold];

end;


// ==========================================
// 4. CONFIGURAR BOTAO VOLTAR
// ==========================================

procedure TForm15.ConfigurarBotaoVoltar;
begin

  // GARANTIR QUE O BOTAO ESTEJA VISIVEL
  pnlVoltarInicio.Visible := True;
  pnlVoltarInicio.Enabled := True;

  // CONFIGURAR APARENCIA
  pnlVoltarInicio.ParentBackground := False;
  pnlVoltarInicio.Color := $00503049;
  pnlVoltarInicio.BevelOuter := bvNone;

  // CONFIGURAR TEXTO
  pnlVoltarInicio.Font.Name := 'Segoe UI';
  pnlVoltarInicio.Font.Size := 10;
  pnlVoltarInicio.Font.Style := [fsBold];
  pnlVoltarInicio.Font.Color := clWhite;

  // INDICAR QUE O PAINEL E CLICAVEL
  pnlVoltarInicio.Cursor := crHandPoint;

  // CONECTAR O EVENTO DO CLIQUE
  pnlVoltarInicio.OnClick := pnlVoltarInicioClick;

  // COLOCAR O BOTAO ACIMA DOS OUTROS PAINEIS
  pnlVoltarInicio.BringToFront;

end;


// ==========================================
// 5. EVENTO - ABRIR A TELA
// ==========================================

procedure TForm15.FormShow(Sender: TObject);
begin

  // CONFIGURAR FUNDO
  pnlFundoPedidos.ParentBackground := False;
  pnlFundoPedidos.Color := $00210D18;

  // CONFIGURAR TITULO
  lblTituloPedidos.Font.Name := 'Segoe UI';
  lblTituloPedidos.Font.Size := 24;
  lblTituloPedidos.Font.Style := [fsBold];
  lblTituloPedidos.Font.Color := $00E88AC5;

  // CONFIGURAR LISTA
  pnlListaPedidos.ParentBackground := False;
  pnlListaPedidos.Color := $00321A29;
  pnlListaPedidos.BevelOuter := bvNone;

  // CONFIGURAR BOTAO VOLTAR
  ConfigurarBotaoVoltar;

  // AJUSTAR TAMANHOS
  FormResize(Self);

  // CARREGAR PEDIDOS DO CLIENTE
  CarregarPedidos;

end;


// ==========================================
// 6. EVENTO - REDIMENSIONAR A TELA
// ==========================================

procedure TForm15.FormResize(Sender: TObject);
var
  I: Integer;
  Card: TPanel;
  LarguraCard: Integer;
  J: Integer;
begin

  if not Assigned(scrPedidos) then
    Exit;

  if not Assigned(pnlListaPedidos) then
    Exit;

  // AJUSTAR AREA DOS PEDIDOS
  scrPedidos.SetBounds(
    50,
    110,
    ClientWidth - 100,
    ClientHeight - 220
  );

  if scrPedidos.Width < 100 then
    scrPedidos.Width := 100;

  if scrPedidos.Height < 100 then
    scrPedidos.Height := 100;

  // AJUSTAR LARGURA DA LISTA
  pnlListaPedidos.Width :=
    scrPedidos.ClientWidth;

  // CALCULAR LARGURA DOS CARDS
  LarguraCard :=
    pnlListaPedidos.ClientWidth - 30;

  if LarguraCard < 100 then
    LarguraCard := 100;

  // REDIMENSIONAR OS CARDS
  for I := 0 to pnlListaPedidos.ControlCount - 1 do
  begin

    if pnlListaPedidos.Controls[I] is TPanel then
    begin

      Card := TPanel(pnlListaPedidos.Controls[I]);

      Card.Width := LarguraCard;

      // REPOSICIONAR BOTAO VER DETALHES
      for J := 0 to Card.ControlCount - 1 do
      begin

        if Card.Controls[J] is TPanel then
        begin

          if TPanel(Card.Controls[J]).Caption =
            'VER DETALHES' then
          begin

            TPanel(Card.Controls[J]).Left :=
              Card.ClientWidth - 190;

          end;

        end;

      end;

    end;

  end;

end;


// ==========================================
// 7. CONSULTAR HISTORICO DE PEDIDOS
// ==========================================

procedure TForm15.CarregarPedidos;
var
  QryPedidos: TFDQuery;

  Card: TPanel;
  Texto: TLabel;
  pnlDetalhes: TPanel;

  Y: Integer;
  LarguraCard: Integer;

  NumeroPedido: Integer;
  ValorPedido: Currency;
  FormaPagamento: string;
  StatusPedido: string;
  DataPedido: string;

begin

  // ======================================
  // 1. LIMPAR CARDS ANTERIORES
  // ======================================

  while pnlListaPedidos.ControlCount > 0 do
    pnlListaPedidos.Controls[0].Free;

  // ======================================
  // 2. VERIFICAR CLIENTE LOGADO
  // ======================================

  if ClienteLogadoID <= 0 then
  begin
    ShowMessage(
      'Cliente nao identificado. Faca login novamente.'
    );
    Exit;
  end;

  // ======================================
  // 3. VERIFICAR CONEXAO
  // ======================================

  if not dmBanco.conBanco.Connected then
  begin
    ShowMessage('Banco de dados desconectado.');
    Exit;
  end;

  // ======================================
  // 4. CRIAR CONSULTA
  // ======================================

  QryPedidos := TFDQuery.Create(nil);

  try
    try

      QryPedidos.Connection :=
        dmBanco.conBanco;

      // CONSULTAR PEDIDOS DO CLIENTE
      QryPedidos.SQL.Text :=
        'SELECT id_venda, data_venda, valor_total, ' +
        'forma_pagamento, status ' +
        'FROM vendas ' +
        'WHERE id_cliente = :cliente ' +
        'ORDER BY data_venda DESC, id_venda DESC';

      QryPedidos.ParamByName('cliente').AsInteger :=
        ClienteLogadoID;

      QryPedidos.Open;

      // ======================================
      // 5. CONFIGURAR PAINEL
      // ======================================

      pnlListaPedidos.Align := alTop;
      pnlListaPedidos.ParentBackground := False;
      pnlListaPedidos.Color := $00321A29;

      LarguraCard :=
        pnlListaPedidos.ClientWidth - 30;

      if LarguraCard < 100 then
        LarguraCard := 100;

      // ======================================
      // 6. VERIFICAR PEDIDOS
      // ======================================

      if QryPedidos.IsEmpty then
      begin

        CriarTextoPedido(
          pnlListaPedidos,
          'Voce ainda nao realizou nenhuma compra.',
          30, 40, 15, clWhite, True
        );

        CriarTextoPedido(
          pnlListaPedidos,
          'Explore nossos produtos e realize seu primeiro pedido!',
          30, 85, 11, clSilver
        );

        pnlListaPedidos.Height := 170;

        Exit;

      end;

      // ======================================
      // 7. CRIAR CARDS DOS PEDIDOS
      // ======================================

      Y := 15;

      QryPedidos.First;

      while not QryPedidos.Eof do
      begin

        // RECUPERAR INFORMACOES
        NumeroPedido :=
          QryPedidos.FieldByName('id_venda').AsInteger;

        ValorPedido :=
          QryPedidos.FieldByName('valor_total').AsCurrency;

        FormaPagamento :=
          QryPedidos.FieldByName('forma_pagamento').AsString;

        StatusPedido :=
          QryPedidos.FieldByName('status').AsString;

        // FORMATAR DATA DA COMPRA
        if QryPedidos.FieldByName('data_venda').IsNull then
          DataPedido := 'Data nao informada'
        else
          DataPedido :=
            FormatDateTime(
              'dd/mm/yyyy "as" hh:nn',
              QryPedidos.FieldByName('data_venda').AsDateTime
            );

        // ======================================
        // CRIAR CARD DO PEDIDO
        // ======================================

        Card := TPanel.Create(pnlListaPedidos);
        Card.Parent := pnlListaPedidos;

        Card.SetBounds(
          15,
          Y,
          LarguraCard,
          190
        );

        Card.BevelOuter := bvNone;
        Card.ParentBackground := False;
        Card.Color := $00493252;

        // ======================================
        // NUMERO DO PEDIDO
        // ======================================

        CriarTextoPedido(
          Card,
          'PEDIDO #' + IntToStr(NumeroPedido),
          25, 18, 15, clWhite, True
        );

        // ======================================
        // DATA DA COMPRA
        // ======================================

        CriarTextoPedido(
          Card,
          'Data da compra: ' + DataPedido,
          25, 55, 10, clSilver
        );

        // ======================================
        // FORMA DE PAGAMENTO
        // ======================================

        CriarTextoPedido(
          Card,
          'Pagamento: ' + FormaPagamento,
          25, 90, 11, clWhite
        );

        // ======================================
        // STATUS DO PEDIDO
        // ======================================

        Texto := CriarTextoPedido(
          Card,
          'Status: ' + StatusPedido,
          25, 130, 11, clWhite, True
        );

        if SameText(StatusPedido, 'CONCLUIDA') then
          Texto.Font.Color := $0080FF80;

        // ======================================
        // VALOR TOTAL
        // ======================================

        Texto := CriarTextoPedido(
          Card,
          Dinheiro(ValorPedido),
          0, 90, 16, $00E88AC5, True
        );

        Texto.Anchors := [akTop, akRight];

        Texto.Left :=
          Card.ClientWidth - Texto.Width - 30;

        // ======================================
        // BOTAO VER DETALHES
        // ======================================

        pnlDetalhes := TPanel.Create(Card);
        pnlDetalhes.Parent := Card;

        pnlDetalhes.Caption := 'VER DETALHES';

        pnlDetalhes.SetBounds(
          Card.ClientWidth - 190,
          135,
          160,
          38
        );

        pnlDetalhes.Anchors := [akTop, akRight];

        pnlDetalhes.BevelOuter := bvNone;
        pnlDetalhes.ParentBackground := False;
        pnlDetalhes.Color := $00503049;

        pnlDetalhes.Font.Name := 'Segoe UI';
        pnlDetalhes.Font.Size := 10;
        pnlDetalhes.Font.Style := [fsBold];
        pnlDetalhes.Font.Color := clWhite;

        pnlDetalhes.Cursor := crHandPoint;

        // IDENTIFICAR O PEDIDO
        pnlDetalhes.Tag := NumeroPedido;

        // ASSOCIAR O CLIQUE
        pnlDetalhes.OnClick := VerDetalhesPedido;

        // ======================================
        // PROXIMO CARD
        // ======================================

        Inc(Y, 205);

        QryPedidos.Next;

      end;

      // AJUSTAR ALTURA DA LISTA
      pnlListaPedidos.Height := Y + 15;

    except
      on E: Exception do
        ShowMessage(
          'Erro ao carregar os pedidos: ' + E.Message
        );
    end;

  finally
    // LIBERAR CONSULTA DO BANCO
    QryPedidos.Free;
  end;

end;


// ==========================================
// 8. CONSULTAR PRODUTOS DO PEDIDO
// ==========================================

procedure TForm15.VerDetalhesPedido(Sender: TObject);
var
  NumeroPedido: Integer;
  QryItens: TFDQuery;
  Detalhes: string;
begin

  // IDENTIFICAR PEDIDO CLICADO
  NumeroPedido := (Sender as TPanel).Tag;

  // VERIFICAR CLIENTE LOGADO
  if ClienteLogadoID <= 0 then
  begin
    ShowMessage('Realize o login novamente.');
    Exit;
  end;

  // VERIFICAR CONEXAO
  if not dmBanco.conBanco.Connected then
  begin
    ShowMessage('Banco de dados desconectado.');
    Exit;
  end;

  // CRIAR CONSULTA
  QryItens := TFDQuery.Create(nil);

  try
    try

      QryItens.Connection := dmBanco.conBanco;

      QryItens.SQL.Text :=
        'SELECT iv.id_produto, iv.quantidade, ' +
        'iv.preco_unitario, iv.subtotal ' +
        'FROM itens_venda iv ' +
        'INNER JOIN vendas v ON v.id_venda = iv.id_venda ' +
        'WHERE iv.id_venda = :venda ' +
        'AND v.id_cliente = :cliente';

      QryItens.ParamByName('venda').AsInteger :=
        NumeroPedido;

      QryItens.ParamByName('cliente').AsInteger :=
        ClienteLogadoID;

      QryItens.Open;

      // VERIFICAR SE EXISTEM ITENS
      if QryItens.IsEmpty then
      begin

        ShowMessage(
          'Nenhum item encontrado para este pedido.'
        );

        Exit;

      end;

      // MONTAR DETALHES
      Detalhes :=
        'PEDIDO #' + IntToStr(NumeroPedido) +
        sLineBreak + sLineBreak;

      while not QryItens.Eof do
      begin

        Detalhes := Detalhes +
          'Produto ID: ' +
          QryItens.FieldByName('id_produto').AsString +
          sLineBreak +

          'Quantidade: ' +
          QryItens.FieldByName('quantidade').AsString +
          sLineBreak +

          'Preco unitario: ' +
          Dinheiro(
            QryItens.FieldByName(
              'preco_unitario').AsCurrency
          ) +
          sLineBreak +

          'Subtotal: ' +
          Dinheiro(
            QryItens.FieldByName(
              'subtotal').AsCurrency
          ) +
          sLineBreak + sLineBreak;

        QryItens.Next;

      end;

      // EXIBIR PRODUTOS
      ShowMessage(Detalhes);

    except
      on E: Exception do
        ShowMessage(
          'Erro ao consultar os itens: ' + E.Message
        );
    end;

  finally

    QryItens.Free;

  end;

end;


// ==========================================
// 9. VOLTAR PARA A PAGINA INICIAL
// ==========================================

procedure TForm15.pnlVoltarInicioClick(Sender: TObject);
begin

  // EXIBIR TELA INICIAL
  Form2.Show;

  // OCULTAR TELA DE MEUS PEDIDOS
  Form15.Hide;

end;

end.

