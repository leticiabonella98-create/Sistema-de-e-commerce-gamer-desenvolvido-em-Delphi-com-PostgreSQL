
unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Skia;

type
  TForm2 = class(TForm)

    // ========================================
    // MENU PRINCIPAL
    // ========================================

    mnuInicio: TMainMenu;
    inicio: TMenuItem;
    mnuProdutos: TMenuItem;
    mnuPerfil: TMenuItem;
    mnuCarrinho: TMenuItem;
    mnuControles: TMenuItem;
    mnuFones: TMenuItem;
    mnuTeclados: TMenuItem;
    mnuMouses: TMenuItem;
    mnuCadeiras: TMenuItem;
    mnuHardware: TMenuItem;
    mnuMonitores: TMenuItem;

    // ========================================
    // ESTRUTURA DA PAGINA
    // ========================================

    scrInicio: TScrollBox;
    pnlPaginaInicio: TPanel;

    // BANNER PRINCIPAL
    pnlBannerPrincipal: TPanel;
    imgBannerPrincipal: TImage;

    // SECAO EXPLORAR
    pnlExplorar: TPanel;
    lblTituloExplorar: TLabel;

    // CARD FONES
    pnlCardFones: TPanel;
    imgCardFones: TImage;
    lblCardFonesTitulo: TLabel;
    lblCardFonesExplorar: TLabel;

    // CARD TECLADOS
    pnlCardTeclados: TPanel;
    imgCardTeclados: TImage;
    lblCardTecladosTitulo: TLabel;
    Label1: TLabel;

    // CARD MONITORES
    pnlCardMonitores: TPanel;
    imgCardMonitores: TImage;
    lblCardMonitoresTitulo: TLabel;
    Label2: TLabel;

    // PROMOCOES
    pnlPromocoes: TPanel;
    lblTituloPromocoes: TLabel;
    imgBannerOferta: TImage;

    // RODAPE
    pnlRodape: TPanel;
    lblRodapeLogo: TPanel;
    lblRodapeFrase: TLabel;
    lblRodapeCopyright: TLabel;

    mnuMeusPedidos: TMenuItem;

    // ========================================
    // EVENTOS DO FORMULARIO
    // ========================================

    procedure FormClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormMouseWheel(
      Sender: TObject;
      Shift: TShiftState;
      WheelDelta: Integer;
      MousePos: TPoint;
      var Handled: Boolean);

    // ========================================
    // EVENTOS DOS MENUS E CARDS
    // ========================================

    procedure inicioClick(Sender: TObject);
    procedure mnuTecladosClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure imgBannerOfertaClick(Sender: TObject);
    procedure mnuCadeirasClick(Sender: TObject);
    procedure mnuControlesClick(Sender: TObject);
    procedure mnuFonesClick(Sender: TObject);
    procedure mnuMousesClick(Sender: TObject);
    procedure mnuHardwareClick(Sender: TObject);
    procedure mnuMonitoresClick(Sender: TObject);
    procedure imgCardFonesClick(Sender: TObject);
    procedure imgCardTecladosClick(Sender: TObject);
    procedure imgCardMonitoresClick(Sender: TObject);
    procedure mnuCarrinhoClick(Sender: TObject);
    procedure mnuPerfilClick(Sender: TObject);
    procedure mnuMeusPedidosClick(Sender: TObject);

  private
    FCarrinho: TStringList;
    procedure AbrirTeclados;

  public
    procedure AdicionarAoCarrinho(const Produto: string);
  end;

var
  Form2: TForm2;

implementation

uses
  Unit3, Unit4, Unit5, Unit6, Unit7,
  Unit8, Unit9, Unit11, Unit12, Unit15;

{$R *.dfm}


// ==========================================
// 1. CARRINHO
// ==========================================

procedure TForm2.AdicionarAoCarrinho(
  const Produto: string);
begin
  if not Assigned(FCarrinho) then
    FCarrinho := TStringList.Create;

  FCarrinho.Add(Produto);
end;


// ==========================================
// 2. CRIACAO DO FORMULARIO
// ==========================================

procedure TForm2.FormCreate(Sender: TObject);
begin
  FCarrinho := TStringList.Create;

  // EXECUTAR A CORRECAO SEMPRE QUE
  // A TELA INICIAL FOR EXIBIDA
  OnShow := FormShow;

  // CONFIGURAR ROLAGEM
  scrInicio.AutoScroll := True;
  scrInicio.Align := alClient;
  scrInicio.HorzScrollBar.Visible := False;

  // PAINEIS POSICIONADOS POR CODIGO
  pnlPaginaInicio.Align := alNone;
  pnlBannerPrincipal.Align := alNone;
  pnlExplorar.Align := alNone;
  pnlPromocoes.Align := alNone;
  pnlRodape.Align := alNone;

  // CONFIGURAR CARDS
  pnlCardFones.Align := alNone;
  pnlCardTeclados.Align := alNone;
  pnlCardMonitores.Align := alNone;

  pnlCardFones.Anchors := [akLeft, akTop];
  pnlCardTeclados.Anchors := [akLeft, akTop];
  pnlCardMonitores.Anchors := [akLeft, akTop];

  // CONFIGURAR BANNER PRINCIPAL
  imgBannerPrincipal.Align := alClient;
  imgBannerPrincipal.Stretch := True;
  imgBannerPrincipal.Proportional := False;

  // CONFIGURAR IMAGEM FONES
  imgCardFones.Align := alClient;
  imgCardFones.Stretch := True;
  imgCardFones.Proportional := True;
  imgCardFones.Center := True;

  // CONFIGURAR IMAGEM TECLADOS
  imgCardTeclados.Align := alClient;
  imgCardTeclados.Stretch := True;
  imgCardTeclados.Proportional := True;
  imgCardTeclados.Center := True;

  // CONFIGURAR IMAGEM MONITORES
  imgCardMonitores.Align := alClient;
  imgCardMonitores.Stretch := True;
  imgCardMonitores.Proportional := True;
  imgCardMonitores.Center := True;

  // CONFIGURAR BANNER PROMOCIONAL
  imgBannerOferta.Align := alNone;
  imgBannerOferta.Stretch := True;
  imgBannerOferta.Proportional := False;

  imgBannerOferta.Cursor := crHandPoint;
  Label1.Cursor := crHandPoint;

  // ORGANIZAR TELA
  FormResize(Self);
end;


// ==========================================
// 3. DESTRUIR FORMULARIO
// ==========================================

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCarrinho);
end;


// ==========================================
// 4. REDIMENSIONAMENTO DA TELA
// ==========================================

procedure TForm2.FormResize(Sender: TObject);
var
  LarguraPagina: Integer;
  LarguraCard: Integer;
  AlturaCard: Integer;
  Margem: Integer;
  Espacamento: Integer;
  AlturaBanner: Integer;
  AlturaOferta: Integer;
begin
  if not Assigned(scrInicio) then
    Exit;

  LarguraPagina := scrInicio.ClientWidth;

  if LarguraPagina <= 0 then
    Exit;

  Margem := 48;
  Espacamento := 26;

  // ========================================
  // PAGINA PRINCIPAL
  // ========================================

  pnlPaginaInicio.Left := 0;
  pnlPaginaInicio.Top := 0;
  pnlPaginaInicio.Width := LarguraPagina;

  // ========================================
  // BANNER PRINCIPAL
  // ========================================

  AlturaBanner :=
    Round(LarguraPagina * 480 / 1289);

  pnlBannerPrincipal.SetBounds(
    0, 0, LarguraPagina, AlturaBanner);

  // ========================================
  // SECAO EXPLORAR
  // ========================================

  pnlExplorar.Left := 0;
  pnlExplorar.Top := AlturaBanner;
  pnlExplorar.Width := LarguraPagina;

  // ========================================
  // TRES CARDS PROPORCIONAIS
  // ========================================

  LarguraCard :=
    (LarguraPagina - (2 * Margem) -
    (2 * Espacamento)) div 3;

  if LarguraCard < 100 then
    LarguraCard := 100;

  AlturaCard :=
    Round(LarguraCard * 200 / 340);

  // CARD FONES
  pnlCardFones.SetBounds(
    Margem,
    110,
    LarguraCard,
    AlturaCard);

  // CARD TECLADOS
  pnlCardTeclados.SetBounds(
    Margem + LarguraCard + Espacamento,
    110,
    LarguraCard,
    AlturaCard);

  // CARD MONITORES
  pnlCardMonitores.SetBounds(
    Margem + 2 * (LarguraCard + Espacamento),
    110,
    LarguraCard,
    AlturaCard);

  // ALTURA DA SECAO EXPLORAR
  pnlExplorar.Height :=
    110 + AlturaCard + 70;

  // ========================================
  // PROMOCOES ESPECIAIS
  // ========================================

  pnlPromocoes.Left := 0;

  pnlPromocoes.Top :=
    pnlExplorar.Top + pnlExplorar.Height;

  pnlPromocoes.Width := LarguraPagina;

  // BANNER DE PROMOCAO
  imgBannerOferta.Left := Margem;
  imgBannerOferta.Top := 90;

  imgBannerOferta.Width :=
    LarguraPagina - (2 * Margem);

  AlturaOferta :=
    Round(imgBannerOferta.Width * 320 / 1184);

  imgBannerOferta.Height := AlturaOferta;

  pnlPromocoes.Height :=
    imgBannerOferta.Top + AlturaOferta + 40;

  // ========================================
  // RODAPE
  // ========================================

  pnlRodape.Left := 0;

  pnlRodape.Top :=
    pnlPromocoes.Top + pnlPromocoes.Height;

  pnlRodape.Width := LarguraPagina;
  pnlRodape.Height := 160;

  // ========================================
  // ALTURA TOTAL DA PAGINA
  // ========================================

  pnlPaginaInicio.Height :=
    pnlRodape.Top + pnlRodape.Height;
end;


// ==========================================
// 5. RESTAURAR TELA INICIAL AO RETORNAR
// ==========================================

procedure TForm2.FormShow(Sender: TObject);
begin
  // VOLTAR A ROLAGEM PARA O TOPO
  scrInicio.VertScrollBar.Position := 0;

  // REORGANIZAR BANNER, CARDS E RODAPE
  FormResize(Self);

  // GARANTIR QUE A PAGINA COMECE NO TOPO
  pnlPaginaInicio.Top := 0;

  // RESTAURAR NOVAMENTE A ROLAGEM
  scrInicio.VertScrollBar.Position := 0;
end;


// ==========================================
// 6. MENU INICIO
// ==========================================

procedure TForm2.inicioClick(Sender: TObject);
begin
  // UTILIZAR A MESMA CORRECAO DO FORMSHOW
  FormShow(Self);
end;


// ==========================================
// 7. ROLAGEM DO MOUSE
// ==========================================

procedure TForm2.FormMouseWheel(
  Sender: TObject;
  Shift: TShiftState;
  WheelDelta: Integer;
  MousePos: TPoint;
  var Handled: Boolean);
begin
  if not Assigned(scrInicio) then
    Exit;

  scrInicio.VertScrollBar.Position :=
    scrInicio.VertScrollBar.Position -
    (WheelDelta div 120) * 60;

  Handled := True;
end;


// ==========================================
// 8. MENU TECLADOS
// ==========================================

procedure TForm2.mnuTecladosClick(Sender: TObject);
begin
  AbrirTeclados;
end;


// ==========================================
// 9. EXPLORAR TECLADOS
// ==========================================

procedure TForm2.Label1Click(Sender: TObject);
begin
  AbrirTeclados;
end;


// ==========================================
// 10. BANNER DE PROMOCAO
// ==========================================

procedure TForm2.imgBannerOfertaClick(Sender: TObject);
begin
  AbrirTeclados;
end;


// ==========================================
// 11. CARD FONES
// ==========================================

procedure TForm2.imgCardFonesClick(Sender: TObject);
begin
  Form5.Show;
  Form2.Hide;
end;


// ==========================================
// 12. CARD MONITORES
// ==========================================

procedure TForm2.imgCardMonitoresClick(Sender: TObject);
begin
  Form9.Show;
  Form2.Hide;
end;


// ==========================================
// 13. CARD TECLADOS
// ==========================================

procedure TForm2.imgCardTecladosClick(Sender: TObject);
begin
  Form3.Show;
  Form2.Hide;
end;


// ==========================================
// 14. ABRIR CATEGORIA TECLADOS
// ==========================================

procedure TForm2.AbrirTeclados;
begin
  if not Assigned(Form3) then
    Form3 := TForm3.Create(Application);

  Form3.lblCategoriaProdutos.Caption :=
    'Teclados Gamers';

  Form3.Show;
  Form3.BringToFront;
end;


// ==========================================
// 15. CLIQUE NO FORMULARIO
// ==========================================

procedure TForm2.FormClick(Sender: TObject);
begin
  ShowMessage('Bem-vindo(a) a Nexus Gaming!');
end;


// ==========================================
// 16. MENU CONTROLES
// ==========================================

procedure TForm2.mnuControlesClick(Sender: TObject);
begin
  if not Assigned(Form4) then
    Form4 := TForm4.Create(Application);

  Form4.Show;
  Form4.BringToFront;
end;


// ==========================================
// 17. MENU FONES
// ==========================================

procedure TForm2.mnuFonesClick(Sender: TObject);
begin
  if not Assigned(Form5) then
    Form5 := TForm5.Create(Application);

  Form5.Show;
  Form5.BringToFront;
end;


// ==========================================
// 18. MENU MOUSES
// ==========================================

procedure TForm2.mnuMousesClick(Sender: TObject);
begin
  if not Assigned(Form6) then
    Form6 := TForm6.Create(Application);

  Form6.Show;
  Form6.BringToFront;
end;


// ==========================================
// 19. MENU PERFIL
// ==========================================

procedure TForm2.mnuPerfilClick(Sender: TObject);
begin
  Form12.Show;
  Form2.Hide;
end;


// ==========================================
// 20. MENU CADEIRAS GAMERS
// ==========================================

procedure TForm2.mnuCadeirasClick(Sender: TObject);
begin
  if not Assigned(Form7) then
    Form7 := TForm7.Create(Application);

  Form7.Show;
  Form7.BringToFront;
end;


// ==========================================
// 21. MENU CARRINHO
// ==========================================

procedure TForm2.mnuCarrinhoClick(Sender: TObject);
begin
  Form11.Show;
  Form2.Hide;
end;


// ==========================================
// 22. MENU HARDWARE
// ==========================================

procedure TForm2.mnuHardwareClick(Sender: TObject);
begin
  Form8.Show;
  Form2.Hide;
end;


// ==========================================
// 23. MENU MEUS PEDIDOS
// ==========================================

procedure TForm2.mnuMeusPedidosClick(Sender: TObject);
begin
  Form15.Show;
  Form2.Hide;
end;


// ==========================================
// 24. MENU MONITORES
// ==========================================

procedure TForm2.mnuMonitoresClick(Sender: TObject);
begin
  Form9.Show;
  Form2.Hide;
end;

end.

