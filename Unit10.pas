
unit Unit10;

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
  TForm10 = class(TForm)
    pnlFundo: TPanel;
    pnlCadastro: TPanel;
    lblTitulo: TLabel;
    lblSubtitulo: TLabel;
    lblCadastro: TLabel;
    lblNome: TLabel;
    edtNome: TEdit;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    lblConfirmarSenha: TLabel;
    edtConfirmarSenha: TEdit;
    pnlCadastrar: TPanel;
    pnlVoltar: TPanel;

    procedure pnlCadastrarClick(Sender: TObject);
    procedure pnlVoltarClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  Form10: TForm10;

implementation

uses
  Unit1,
  Unit13;

{$R *.dfm}


// ==========================================
// CADASTRAR NOVO USUARIO
// ==========================================

procedure TForm10.pnlCadastrarClick(Sender: TObject);
var
  QryCadastro: TFDQuery;
begin

  // ETAPA 1 - VALIDAR NOME

  if Trim(edtNome.Text) = '' then
  begin
    ShowMessage('Por favor, informe seu nome.');
    edtNome.SetFocus;
    Exit;
  end;


  // ETAPA 2 - VALIDAR E-MAIL

  if Trim(edtEmail.Text) = '' then
  begin
    ShowMessage('Por favor, informe seu e-mail.');
    edtEmail.SetFocus;
    Exit;
  end;

  if (Pos('@', edtEmail.Text) = 0) or
     (Pos('.', edtEmail.Text) = 0) or
     (Pos(' ', edtEmail.Text) > 0) then
  begin
    ShowMessage('Informe um e-mail valido.');
    edtEmail.SetFocus;
    Exit;
  end;


  // ETAPA 3 - VALIDAR SENHA

  if Trim(edtSenha.Text) = '' then
  begin
    ShowMessage('Por favor, informe sua senha.');
    edtSenha.SetFocus;
    Exit;
  end;

  if Length(edtSenha.Text) < 6 then
  begin
    ShowMessage(
      'A senha deve possuir pelo menos 6 caracteres.'
    );
    edtSenha.SetFocus;
    Exit;
  end;


  // ETAPA 4 - VALIDAR CONFIRMACAO

  if Trim(edtConfirmarSenha.Text) = '' then
  begin
    ShowMessage('Por favor, confirme sua senha.');
    edtConfirmarSenha.SetFocus;
    Exit;
  end;


  // ETAPA 5 - COMPARAR SENHAS

  if edtSenha.Text <> edtConfirmarSenha.Text then
  begin
    ShowMessage(
      'As senhas informadas nao correspondem.'
    );
    edtConfirmarSenha.SetFocus;
    Exit;
  end;


  // ETAPA 6 - CONECTAR AO POSTGRESQL

  try
    if not dmBanco.conBanco.Connected then
      dmBanco.conBanco.Connected := True;
  except
    on E: Exception do
    begin
      ShowMessage(
        'Erro ao conectar ao banco: ' + E.Message
      );
      Exit;
    end;
  end;


  // ETAPA 7 - CRIAR CONSULTA

  QryCadastro := TFDQuery.Create(nil);

  try

    QryCadastro.Connection := dmBanco.conBanco;

    // VERIFICAR SE O E-MAIL JA EXISTE

    QryCadastro.SQL.Text :=
      'SELECT id_cliente FROM clientes ' +
      'WHERE LOWER(email) = LOWER(:email)';

    QryCadastro.ParamByName('email').AsString :=
      Trim(edtEmail.Text);

    QryCadastro.Open;

    if not QryCadastro.IsEmpty then
    begin
      ShowMessage(
        'Este e-mail ja esta cadastrado. ' +
        'Utilize outro e-mail.'
      );
      edtEmail.SetFocus;
      Exit;
    end;

    QryCadastro.Close;


    // ETAPA 8 - SALVAR CLIENTE

    QryCadastro.SQL.Text :=
      'INSERT INTO clientes ' +
      '(nome, email, senha_hash, ativo) ' +
      'VALUES ' +
      '(:nome, :email, ' +
      'crypt(:senha, gen_salt(''bf'')), TRUE)';

    QryCadastro.ParamByName('nome').AsString :=
      Trim(edtNome.Text);

    QryCadastro.ParamByName('email').AsString :=
      Trim(edtEmail.Text);

    QryCadastro.ParamByName('senha').AsString :=
      edtSenha.Text;

    QryCadastro.ExecSQL;


    // ETAPA 9 - CADASTRO CONCLUIDO

    ShowMessage(
      'Cadastro realizado com sucesso!'
    );


    // ETAPA 10 - RETORNAR AO LOGIN

    Form1.edtEmail.Text :=
      Trim(edtEmail.Text);

    Form1.edtSenha.Clear;

    edtNome.Clear;
    edtEmail.Clear;
    edtSenha.Clear;
    edtConfirmarSenha.Clear;

    Form1.Show;
    Hide;

  except
    on E: Exception do
    begin
      ShowMessage(
        'Erro ao realizar cadastro: ' + E.Message
      );
    end;
  end;

  // LIBERAR A CONSULTA
  QryCadastro.Free;

end;


// ==========================================
// VOLTAR PARA TELA DE LOGIN
// ==========================================

procedure TForm10.pnlVoltarClick(Sender: TObject);
begin
  Form1.Show;
  Hide;
end;

end.

