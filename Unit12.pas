unit Unit12;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TForm12 = class(TForm)
    scrPerfil: TScrollBox;
    pnlConteudoPerfil: TPanel;
    lblTituloPerfil: TLabel;
    pnlDadosPessoais: TPanel;
    lblDadosPessoais: TLabel;
    lblNomePerfil: TLabel;
    edtNomePerfil: TEdit;
    lblEmailPerfil: TLabel;
    edtEmailPerfil: TEdit;
    pnlSalvarPerfil: TPanel;
    pnlEndereco: TPanel;
    lblTituloEndereco: TLabel;
    lblCEP: TLabel;
    mskCEP: TMaskEdit;
    lblRua: TLabel;
    edtRua: TEdit;
    lblNumero: TLabel;
    edtNumero: TEdit;
    lblBairro: TLabel;
    edtBairro: TEdit;
    lblCidade: TLabel;
    edtCidade: TEdit;
    lblEstado: TLabel;
    cmbEstado: TComboBox;
    lblComplemento: TLabel;
    edtComplemento: TEdit;
    pnlSalvarEndereco: TPanel;
    pnlVoltar: TPanel;
    procedure pnlVoltarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlSalvarPerfilClick(Sender: TObject);
    procedure pnlSalvarEnderecoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

Uses
Unit2;
{$R *.dfm}

procedure TForm12.FormResize(Sender: TObject);
begin
 pnlVoltar.Left := ClientWidth - pnlVoltar.Width - 15;
  pnlVoltar.Top := 10;
  pnlVoltar.BringToFront;
end;

procedure TForm12.pnlSalvarEnderecoClick(Sender: TObject);

var
  CEP: string;
  I: Integer;

  begin
  // Remove o hífen e os espaços da máscara
  CEP := StringReplace(mskCEP.Text, '-', '', [rfReplaceAll]);
  CEP := StringReplace(CEP, ' ', '', [rfReplaceAll]);

  // Verifica se o CEP possui 8 dígitos
  if Length(CEP) <> 8 then
  begin
    ShowMessage('Por favor, informe um CEP válido.');
    mskCEP.SetFocus;
    Exit;
  end;

  // Verifica se todos os caracteres do CEP são números
  for I := 1 to Length(CEP) do
  begin
    if not (CEP[I] in ['0'..'9']) then
    begin
      ShowMessage('O CEP deve conter apenas números.');
      mskCEP.SetFocus;
      Exit;
    end;
  end;

  // Validação da rua
  if Trim(edtRua.Text) = '' then
  begin
    ShowMessage('Por favor, informe a rua.');
    edtRua.SetFocus;
    Exit;
  end;

  // Validação do número
  if Trim(edtNumero.Text) = '' then
  begin
    ShowMessage('Por favor, informe o número.');
    edtNumero.SetFocus;
    Exit;
  end;

  // Validação do bairro
  if Trim(edtBairro.Text) = '' then
  begin
    ShowMessage('Por favor, informe o bairro.');
    edtBairro.SetFocus;
    Exit;
  end;

  // Validação da cidade
  if Trim(edtCidade.Text) = '' then
  begin
    ShowMessage('Por favor, informe a cidade.');
    edtCidade.SetFocus;
    Exit;
  end;

  // Validação do estado
  if cmbEstado.ItemIndex = -1 then
  begin
    ShowMessage('Por favor, selecione o estado.');
    cmbEstado.SetFocus;
    Exit;
  end;

  // Todos os campos obrigatórios foram preenchidos
  ShowMessage('Endereço validado com sucesso!');
end;

procedure TForm12.pnlSalvarPerfilClick(Sender: TObject);
begin
var
  Nome, Email: string;
begin
  Nome := Trim(edtNomePerfil.Text);
  Email := Trim(edtEmailPerfil.Text);

  if Nome = '' then
  begin
    ShowMessage('Por favor, informe seu nome completo.');
    edtNomePerfil.SetFocus;
    Exit;
  end;

  if (Pos('@', Email) <= 1) or
     (Pos('.', Email) = 0) or
     (Pos(' ', Email) > 0) then
  begin
    ShowMessage('Por favor, informe um e-mail válido.');
    edtEmailPerfil.SetFocus;
    Exit;
  end;

  ShowMessage('Dados validados com sucesso!');
end;
end;

procedure TForm12.pnlVoltarClick(Sender: TObject);
begin
 Form2.Show;
  Self.Hide;
end;

end.
