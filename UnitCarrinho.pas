
unit UnitCarrinho;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.ExtCtrls;

type
  TItemCarrinho = class
  public
    IDProduto: Integer;
    Nome: string;
    Preco: Currency;
    Quantidade: Integer;
    Foto: TPicture;

    constructor Create;
    destructor Destroy; override;
  end;

var
  ItensCarrinho: TObjectList<TItemCarrinho>;

// FUNCOES DO CARRINHO
function ValorDoPreco(const Texto: string): Currency;
function Dinheiro(Valor: Currency): string;

procedure AdicionarProduto(
  const Nome, PrecoTexto: string;
  Imagem: TImage;
  IDProduto: Integer = 0
);

function TotalCarrinho: Currency;

implementation

// ======================================
// CRIAR ITEM DO CARRINHO
// ======================================

constructor TItemCarrinho.Create;
begin
  inherited Create;

  IDProduto := 0;
  Nome := '';
  Preco := 0;
  Quantidade := 1;

  Foto := TPicture.Create;
end;

// ======================================
// DESTRUIR ITEM DO CARRINHO
// ======================================

destructor TItemCarrinho.Destroy;
begin
  Foto.Free;
  inherited Destroy;
end;

// ======================================
// CONVERTER TEXTO EM PRECO
// ======================================

function ValorDoPreco(const Texto: string): Currency;
var
  S: string;
  C: Char;
  F: TFormatSettings;
begin
  S := '';

  for C in Texto do
  begin
    if CharInSet(C, ['0'..'9', ',', '.']) then
      S := S + C;
  end;

  S := StringReplace(
    S, '.', '', [rfReplaceAll]
  );

  F := TFormatSettings.Create;
  F.DecimalSeparator := ',';

  if not TryStrToCurr(S, Result, F) then
    Result := 0;
end;

// ======================================
// FORMATAR VALORES EM REAIS
// ======================================

function Dinheiro(Valor: Currency): string;
var
  F: TFormatSettings;
begin
  F := TFormatSettings.Create;

  F.DecimalSeparator := ',';
  F.ThousandSeparator := '.';

  Result := 'R$ ' +
    FormatCurr('#,##0.00', Valor, F);
end;

// ======================================
// ADICIONAR PRODUTO AO CARRINHO
// ======================================

procedure AdicionarProduto(
  const Nome, PrecoTexto: string;
  Imagem: TImage;
  IDProduto: Integer
);
var
  Item: TItemCarrinho;
begin

  // VERIFICAR SE O PRODUTO JA EXISTE
  for Item in ItensCarrinho do
  begin
    if ((IDProduto > 0) and
        (Item.IDProduto = IDProduto)) or
       ((IDProduto = 0) and
        (Item.IDProduto = 0) and
        SameText(Item.Nome, Nome)) then
    begin
      Inc(Item.Quantidade);
      Exit;
    end;
  end;

  // CRIAR NOVO PRODUTO
  Item := TItemCarrinho.Create;

  try
    // ARMAZENAR INFORMACOES
    Item.IDProduto := IDProduto;
    Item.Nome := Nome;
    Item.Preco := ValorDoPreco(PrecoTexto);

    // ARMAZENAR IMAGEM
    if Assigned(Imagem) then
    begin
      if Assigned(Imagem.Picture.Graphic) then
        Item.Foto.Assign(Imagem.Picture);
    end;

    // ADICIONAR NA LISTA
    ItensCarrinho.Add(Item);

  except
    Item.Free;
    raise;
  end;

end;

// ======================================
// CALCULAR TOTAL DO CARRINHO
// ======================================

function TotalCarrinho: Currency;
var
  Item: TItemCarrinho;
begin
  Result := 0;

  for Item in ItensCarrinho do
  begin
    Result := Result +
      (Item.Preco * Item.Quantidade);
  end;
end;

// ======================================
// INICIALIZAR LISTA DO CARRINHO
// ======================================

initialization
  ItensCarrinho :=
    TObjectList<TItemCarrinho>.Create(True);

// ======================================
// LIBERAR MEMORIA
// ======================================

finalization
  ItensCarrinho.Free;

end.

