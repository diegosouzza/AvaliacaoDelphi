unit pessoas_juridicas_endereco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cadastro, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  Tpessoas_juridicas_endereco_form = class(Tcadastro_form)
    ed_pessoa_juridica: TMaskEdit;
    GroupBox2: TGroupBox;
    ed_logradouro: TEdit;
    Logradouro: TLabel;
    Label2: TLabel;
    ed_numero: TMaskEdit;
    ed_bairro: TEdit;
    Label3: TLabel;
    ed_cidade: TEdit;
    Label4: TLabel;
    ed_uf: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    ed_cep: TMaskEdit;
    ed_complemento: TEdit;
    Label7: TLabel;
    procedure ed_cepExit(Sender: TObject);
    procedure ed_logradouroExit(Sender: TObject);
    procedure ed_bairroExit(Sender: TObject);
    procedure ed_cidadeExit(Sender: TObject);
    procedure ed_ufExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_pesquisarClick(Sender: TObject);
    procedure ed_chaveKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pessoas_juridicas_endereco_form: Tpessoas_juridicas_endereco_form;

implementation

{$R *.dfm}

uses data_module3, pessoas_juridicas, biblioteca;

procedure Tpessoas_juridicas_endereco_form.bt_pesquisarClick(Sender: TObject);
begin
   case acao  of
      1:
      begin
         ed_chave.Text := buscar_sequencial(copy(ed_chave.HelpKeyword,5,length(ed_chave.HelpKeyword)-4),tabela,' where sequencial_pessoa_juridica = '+StringParaFirebird(ed_pessoa_juridica.Text));
      end;
   end;
end;

procedure Tpessoas_juridicas_endereco_form.ed_bairroExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;

   if (LimparString(ed_bairro.Text) = '') then
   begin
      MessageDlg('O Campo "Bairro" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_bairro.SetFocus;
      Abort;
   end;

end;

procedure Tpessoas_juridicas_endereco_form.ed_cepExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;

   if (LimparString(ed_cep.Text) = '') then
   begin
      MessageDlg('O Campo "CEP" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_cep.SetFocus;
      Abort;
   end;

   if (ed_uf.ItemIndex < 0) then
   begin
      MessageDlg('O Campo "UF" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_uf.SetFocus;
      Abort;
   end;

   if not ValidarCEP(ed_uf.Text, ed_cep.Text) then
   begin
      MessageDlg('O Campo "CEP" deve está inválido.',mtInformation,[mbOK],0);
      ed_cep.SetFocus;
   end;

end;

procedure Tpessoas_juridicas_endereco_form.ed_chaveKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   case key of
      vk_return:
      begin
         if trim(ed_chave.Text) = '' then
            bt_cancelarClick(bt_cancelar)
         else
            bt_salvar.SetFocus;
      end;
      vk_f3: bt_pesquisarClick(bt_pesquisar);
   end;
end;

procedure Tpessoas_juridicas_endereco_form.ed_cidadeExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;

   if (LimparString(ed_cidade.Text) = '') then
   begin
      MessageDlg('O Campo "Cidade" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_cidade.SetFocus;
      Abort;
   end;
end;

procedure Tpessoas_juridicas_endereco_form.ed_logradouroExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;

   if (LimparString(ed_logradouro.Text) = '') then
   begin
      MessageDlg('O Campo "Logradouro" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_logradouro.SetFocus;
      Abort;
   end;

end;

procedure Tpessoas_juridicas_endereco_form.ed_ufExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;

   if (ed_uf.ItemIndex < 0) then
   begin
      MessageDlg('O Campo "UF" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_uf.SetFocus;
      Abort;
   end;

end;

procedure Tpessoas_juridicas_endereco_form.FormCreate(Sender: TObject);
begin
   inherited;

   tabela := 'pessoas_juridicas_enderecos';
   chave := 'sequencial, sequencial_pessoa_juridica';
end;

procedure Tpessoas_juridicas_endereco_form.FormDestroy(Sender: TObject);
begin
   inherited;

   pessoas_juridicas_form.cadastro.Enabled := true;
   pessoas_juridicas_form.cadastro.atualizar_grids;
   pessoas_juridicas_endereco_form := nil;
end;

end.
