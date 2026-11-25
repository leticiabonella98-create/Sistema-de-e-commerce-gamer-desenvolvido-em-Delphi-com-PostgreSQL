
unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    imgFundo: TImage;
    pnlLogin: TPanel;
    lblBemVinda: TLabel;
    lblSubtitulo: TLabel;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    pnlEntrar: TPanel;
    lblCadastrar: TPanel;

    procedure pnlEntrarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lblCadastrarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ClienteLogadoID: Integer = 0;

implementation

uses
  Unit10, Unit2, Unit13, Unit16;

{$R *.dfm}

// CENTRALIZAR O PAINEL DE LOGIN
procedure TForm1.FormResize(Sender: TObject);
begin
  pnlLogin.Left := ClientWidth - pnlLogin.Width - 80;
  pnlLogin.Top := (ClientHeight - pnlLogin.Height) div 2;
end;

// ABRIR CADASTRO DE CLIENTES
procedure TForm1.lblCadastrarClick(Sender: TObject);
begin
  Form10.Show;
  Self.Hide;
end;

// LOGIN DE CLIENTES E ADMINISTRADORES
procedure TForm1.pnlEntrarClick(Sender: TObject);
begin

  // VALIDAR E-MAIL VAZIO
  if Trim(edtEmail.Text) = '' then
  begin
    ShowMessage('Digite seu e-mail!');
    edtEmail.SetFocus;
    Exit;
  end;

  // VALIDAR FORMATO DO E-MAIL
  if (Pos('@', edtEmail.Text) = 0) or
     (Pos('.', edtEmail.Text) = 0) then
  begin
    ShowMessage('E-mail inválido!');
    edtEmail.SetFocus;
    Exit;
  end;

  // VALIDAR SENHA VAZIA
  if Trim(edtSenha.Text) = '' then
  begin
    ShowMessage('Digite sua senha!');
    edtSenha.SetFocus;
    Exit;
  end;

  try

    // CONECTAR AO POSTGRESQL
    if not dmBanco.conBanco.Connected then
      dmBanco.conBanco.Connected := True;

    // ======================================
    // 1 - VERIFICAR ADMINISTRADOR
    // ======================================

    dmBanco.qryProdutos.Close;

    dmBanco.qryProdutos.SQL.Text :=
      'SELECT id_usuario, nome, perfil ' +
      'FROM usuarios ' +
      'WHERE LOWER(email) = LOWER(:email) ' +
      'AND ativo = TRUE ' +
      'AND perfil = ''ADMINISTRADOR'' ' +
      'AND senha_hash = crypt(:senha, senha_hash)';

    dmBanco.qryProdutos.ParamByName('email').AsString :=
      Trim(edtEmail.Text);

    dmBanco.qryProdutos.ParamByName('senha').AsString :=
      edtSenha.Text;

    dmBanco.qryProdutos.Open;

    // ADMINISTRADOR ENCONTRADO
    if not dmBanco.qryProdutos.IsEmpty then
    begin

      ClienteLogadoID := 0;

      dmBanco.qryProdutos.Close;

      ShowMessage('Bem-vindo ao Painel Administrativo!');

      // ABRIR FORM16
      if not Assigned(Form16) then
        Form16 := TForm16.Create(Application);

      Form16.Show;

      Self.Hide;

      Exit;
    end;

    dmBanco.qryProdutos.Close;

    // ======================================
    // 2 - VERIFICAR CLIENTE
    // ======================================

    dmBanco.qryProdutos.SQL.Text :=
      'SELECT id_cliente, nome ' +
      'FROM clientes ' +
      'WHERE LOWER(email) = LOWER(:email) ' +
      'AND ativo = TRUE ' +
      'AND senha_hash = crypt(:senha, senha_hash)';

    dmBanco.qryProdutos.ParamByName('email').AsString :=
      Trim(edtEmail.Text);

    dmBanco.qryProdutos.ParamByName('senha').AsString :=
      edtSenha.Text;

    dmBanco.qryProdutos.Open;

    // CLIENTE ENCONTRADO
    if not dmBanco.qryProdutos.IsEmpty then
    begin

      ClienteLogadoID :=
        dmBanco.qryProdutos.FieldByName('id_cliente').AsInteger;

      dmBanco.qryProdutos.Close;

      ShowMessage('Login realizado com sucesso!');

      Form2.Show;

      Self.Hide;

    end
    else
    begin

      // LOGIN INCORRETO
      dmBanco.qryProdutos.Close;

      ShowMessage('E-mail ou senha incorretos!');

      edtSenha.Clear;
      edtSenha.SetFocus;

    end;

  except
    on E: Exception do
    begin
      dmBanco.qryProdutos.Close;
      ShowMessage('Erro ao realizar login: ' + E.Message);
    end;
  end;

end;

end.

