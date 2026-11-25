
unit Unit11;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm11 = class(TForm)

    // COMPONENTES EXISTENTES NO DESIGN
    pnlFundo: TPanel;
    lblTituloCarrinho: TLabel;
    scrCarrinho: TScrollBox;
    pnlListaProdutos: TPanel;

    // EVENTOS DO FORMULARIO
    procedure FormShow(Sender: TObject);
    procedure FormClose(
      Sender: TObject;
      var Action: TCloseAction
    );

  private

    // COMPONENTES CRIADOS PELO CODIGO
    pnlResumo: TPanel;
    btnVoltar: TButton;
    lblTotal: TLabel;

    // PROCEDIMENTOS DO CARRINHO
    procedure AtualizarCarrinho;
    procedure AlterarQuantidade(Sender: TObject);
    procedure RemoverProduto(Sender: TObject);
    procedure VoltarInicio(Sender: TObject);
    procedure FinalizarCompra(Sender: TObject);

  public
  end;

var
  Form11: TForm11;

implementation

uses
  UnitCarrinho, Unit2, Unit1, Unit13, Unit14;

{$R *.dfm}


// ==================================================
// FUNCAO AUXILIAR - CRIAR LABELS
// ==================================================
// Cria textos dinamicamente dentro dos paineis.
// Assim, nao precisamos desenhar cada label
// manualmente no formulario.

function NovoTexto(
  Pai: TWinControl;
  const Texto: string;
  X, Y, Tamanho: Integer;
  Cor: TColor;
  Negrito: Boolean = False
): TLabel;
begin
  Result := TLabel.Create(Pai);

  Result.Parent := Pai;
  Result.Left := X;
  Result.Top := Y;
  Result.Caption := Texto;

  Result.Font.Name := 'Segoe UI';
  Result.Font.Size := Tamanho;
  Result.Font.Color := Cor;

  if Negrito then
    Result.Font.Style := [fsBold];
end;


// ==================================================
// FUNCAO AUXILIAR - CRIAR BOTOES
// ==================================================
// Cria botoes e associa uma acao ao clique.
//
// A propriedade Tag guarda um numero utilizado
// para identificar o produto ou a operacao.

function NovoBotao(
  Pai: TWinControl;
  const Texto: string;
  X, Y, L, A, Codigo: Integer;
  Acao: TNotifyEvent
): TButton;
begin
  Result := TButton.Create(Pai);

  Result.Parent := Pai;
  Result.Caption := Texto;

  Result.SetBounds(X, Y, L, A);

  Result.Tag := Codigo;
  Result.OnClick := Acao;
end;


// ==================================================
// EVENTO - ABRIR O CARRINHO
// ==================================================
// Executado sempre que o Form11 aparece.
//
// Configura as cores e atualiza os produtos
// que foram adicionados pelas outras Units.

procedure TForm11.FormShow(Sender: TObject);
begin
  pnlFundo.Color := $00210D18;

  scrCarrinho.SetBounds(
    40,
    110,
    850,
    ClientHeight - 155
  );

  scrCarrinho.AutoScroll := True;
  scrCarrinho.VertScrollBar.Visible := True;

  pnlListaProdutos.Align := alTop;
  pnlListaProdutos.Color := $00321A29;

  lblTituloCarrinho.Font.Color := $00E88AC5;

  // RECONSTRUIR A LISTA DE PRODUTOS
  AtualizarCarrinho;
end;


// ==================================================
// PROCEDIMENTO - ATUALIZAR O CARRINHO
// ==================================================
// Percorre os produtos da UnitCarrinho.
//
// Para cada produto, cria um card com:
// - Imagem
// - Nome
// - Preco unitario
// - Quantidade
// - Subtotal
// - Botoes de adicionar, diminuir e remover

procedure TForm11.AtualizarCarrinho;
var
  I, Y: Integer;
  Item: TItemCarrinho;
  Card: TPanel;
  Foto: TImage;
  Subtotal: Currency;
begin

  // APAGAR OS CARDS ANTIGOS
  while pnlListaProdutos.ControlCount > 0 do
    pnlListaProdutos.Controls[0].Free;

  // APAGAR O RESUMO ANTERIOR
  if Assigned(pnlResumo) then
    FreeAndNil(pnlResumo);

  // APAGAR O BOTAO VOLTAR ANTERIOR
  if Assigned(btnVoltar) then
    FreeAndNil(btnVoltar);

  Y := 15;

  // MENSAGEM QUANDO O CARRINHO ESTIVER VAZIO
  if ItensCarrinho.Count = 0 then
  begin
    NovoTexto(
      pnlListaProdutos,
      'Seu carrinho esta vazio.',
      25, 30, 17,
      clWhite,
      True
    );

    NovoTexto(
      pnlListaProdutos,
      'Adicione produtos nas categorias para comecar.',
      25, 75, 11,
      clSilver
    );

    Y := 145;
  end;

  // PERCORRER TODOS OS PRODUTOS
  for I := 0 to ItensCarrinho.Count - 1 do
  begin

    Item := ItensCarrinho[I];

    // CRIAR O PAINEL DO PRODUTO
    Card := TPanel.Create(pnlListaProdutos);
    Card.Parent := pnlListaProdutos;

    Card.SetBounds(15, Y, 800, 125);
    Card.BevelOuter := bvNone;
    Card.ParentBackground := False;
    Card.Color := $00493252;

    // EXIBIR A IMAGEM DO PRODUTO
    Foto := TImage.Create(Card);
    Foto.Parent := Card;

    Foto.SetBounds(12, 12, 100, 100);
    Foto.Proportional := True;
    Foto.Center := True;

    if Assigned(Item.Foto.Graphic) then
      Foto.Picture.Assign(Item.Foto);

    // EXIBIR O NOME
    NovoTexto(
      Card,
      Item.Nome,
      130, 15, 12,
      clWhite,
      True
    );

    // EXIBIR O PRECO UNITARIO
    NovoTexto(
      Card,
      Dinheiro(Item.Preco),
      130, 48, 12,
      $00E88AC5,
      True
    );

    // CALCULAR O SUBTOTAL
    Subtotal := Item.Preco * Item.Quantidade;

    NovoTexto(
      Card,
      'Subtotal: ' + Dinheiro(Subtotal),
      130, 83, 10,
      clWhite
    );

    // BOTAO PARA DIMINUIR A QUANTIDADE
    NovoBotao(
      Card,
      '-',
      535, 40, 35, 32,
      I,
      AlterarQuantidade
    );

    // MOSTRAR QUANTIDADE ATUAL
    NovoTexto(
      Card,
      IntToStr(Item.Quantidade),
      582, 46, 11,
      clWhite,
      True
    );

    // BOTAO PARA AUMENTAR A QUANTIDADE
    // O VALOR 10000 IDENTIFICA A OPERACAO DE SOMA
    NovoBotao(
      Card,
      '+',
      620, 40, 35, 32,
      I + 10000,
      AlterarQuantidade
    );

    // BOTAO PARA REMOVER O PRODUTO
    NovoBotao(
      Card,
      'Remover',
      680, 40, 95, 32,
      I,
      RemoverProduto
    );

    // POSICAO DO PROXIMO CARD
    Inc(Y, 140);
  end;

  // AJUSTAR A ALTURA DA LISTA
  pnlListaProdutos.Height := Y + 15;


  // ================================================
  // CRIAR O PAINEL RESUMO DA COMPRA
  // ================================================

  pnlResumo := TPanel.Create(Self);
  pnlResumo.Parent := pnlFundo;

  pnlResumo.SetBounds(920, 110, 325, 260);

  pnlResumo.BevelOuter := bvNone;
  pnlResumo.ParentBackground := False;
  pnlResumo.Color := $00321A29;

  // TITULO DO RESUMO
  NovoTexto(
    pnlResumo,
    'RESUMO DA COMPRA',
    20, 20, 15,
    $00E88AC5,
    True
  );

  // QUANTIDADE DE PRODUTOS DIFERENTES
  NovoTexto(
    pnlResumo,
    'Itens: ' + IntToStr(ItensCarrinho.Count),
    20, 80, 11,
    clWhite
  );

  // VALOR TOTAL DO CARRINHO
  lblTotal := NovoTexto(
    pnlResumo,
    'Total: ' + Dinheiro(TotalCarrinho),
    20, 130, 14,
    $00E88AC5,
    True
  );

  // BOTAO FINALIZAR COMPRA
  NovoBotao(
    pnlResumo,
    'FINALIZAR COMPRA',
    20, 190, 280, 40,
    0,
    FinalizarCompra
  );

  // BOTAO VOLTAR PARA INICIO
  btnVoltar := NovoBotao(
    pnlFundo,
    'VOLTAR PARA INICIO',
    920, 390, 325, 40,
    0,
    VoltarInicio
  );
end;


// ==================================================
// PROCEDIMENTO - ALTERAR QUANTIDADE
// ==================================================
// Aumenta ou diminui a quantidade do produto.
//
// Se a quantidade chegar a zero,
// o produto sera removido do carrinho.

procedure TForm11.AlterarQuantidade(Sender: TObject);
var
  Indice: Integer;
begin
  Indice := (Sender as TButton).Tag;

  // AUMENTAR QUANTIDADE
  if Indice >= 10000 then
  begin
    Dec(Indice, 10000);

    if (Indice >= 0) and
       (Indice < ItensCarrinho.Count) then
      Inc(ItensCarrinho[Indice].Quantidade);
  end

  // DIMINUIR QUANTIDADE
  else if (Indice >= 0) and
          (Indice < ItensCarrinho.Count) then
  begin
    if ItensCarrinho[Indice].Quantidade > 1 then
      Dec(ItensCarrinho[Indice].Quantidade)
    else
      ItensCarrinho.Delete(Indice);
  end;

  // ATUALIZAR A TELA
  AtualizarCarrinho;
end;


// ==================================================
// PROCEDIMENTO - REMOVER PRODUTO
// ==================================================
// Remove o produto selecionado do carrinho.

procedure TForm11.RemoverProduto(Sender: TObject);
var
  Indice: Integer;
begin
  Indice := (Sender as TButton).Tag;

  if (Indice >= 0) and
     (Indice < ItensCarrinho.Count) then
    ItensCarrinho.Delete(Indice);

  AtualizarCarrinho;
end;


// ==================================================
// PROCEDIMENTO - VOLTAR PARA A PAGINA INICIAL
// ==================================================

procedure TForm11.VoltarInicio(Sender: TObject);
begin
  Form2.Show;
  Hide;
end;


// ==================================================
// EVENTO - FECHAR O FORMULARIO
// ==================================================
// Em vez de destruir o carrinho,
// o formulario sera apenas ocultado.

procedure TForm11.FormClose(
  Sender: TObject;
  var Action: TCloseAction
);
begin
  Action := caHide;
  Form2.Show;
end;


// ==================================================
// PROCEDIMENTO - FINALIZAR COMPRA
// ==================================================
// ETAPA ATUAL:
// 1. Verificar se existem produtos.
// 2. Verificar se o cliente realizou login.
//
// A gravacao nas tabelas vendas e itens_venda
// sera implementada na proxima etapa.

procedure TForm11.FinalizarCompra(Sender: TObject);
var
  I: Integer;
begin

  // VERIFICAR SE O CARRINHO ESTA VAZIO
  if ItensCarrinho.Count = 0 then
  begin
    ShowMessage(
      'Adicione pelo menos um produto ao carrinho.'
    );
    Exit;
  end;

  // VERIFICAR SE EXISTE CLIENTE LOGADO
  if ClienteLogadoID <= 0 then
  begin
    ShowMessage(
      'E necessario realizar o login para finalizar a compra.'
    );
    Exit;
  end;

  // VERIFICAR SE OS PRODUTOS POSSUEM ID VALIDO
  for I := 0 to ItensCarrinho.Count - 1 do
  begin
    if ItensCarrinho[I].IDProduto <= 0 then
    begin
      ShowMessage(
        'O produto "' + ItensCarrinho[I].Nome +
        '" nao possui um ID valido. Remova-o e adicione novamente.'
      );
      Exit;
    end;
  end;

  // ABRIR A TELA DE PAGAMENTO
  Form14.Show;

  // OCULTAR A TELA DO CARRINHO
  Form11.Hide;
end;

end.

