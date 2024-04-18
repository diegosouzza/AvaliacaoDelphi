unit pessoas_juridicas_contato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cadastro, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  Tpessoas_juridicas_contato_form = class(Tcadastro_form)
    ed_pessoa_juridica: TMaskEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    ed_nome: TEdit;
    ed_telefone: TMaskEdit;
    Label6: TLabel;
    ed_celular: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    ed_email: TEdit;
    procedure ed_nomeExit(Sender: TObject);
    procedure ed_celularExit(Sender: TObject);
    procedure ed_emailExit(Sender: TObject);
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
  pessoas_juridicas_contato_form: Tpessoas_juridicas_contato_form;

implementation

{$R *.dfm}

uses biblioteca, pessoas_juridicas;

procedure Tpessoas_juridicas_contato_form.bt_pesquisarClick(Sender: TObject);
begin
   case acao  of
      1:
      begin
         ed_chave.Text := buscar_sequencial(copy(ed_chave.HelpKeyword,5,length(ed_chave.HelpKeyword)-4),tabela,' where sequencial_pessoa_juridica = '+StringParaFirebird(ed_pessoa_juridica.Text));
      end;
   end;
end;

procedure Tpessoas_juridicas_contato_form.ed_celularExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;

   if (LimparString(ed_email.Text) = '') and (LimparMascara(ed_celular.Text,ed_celular.EditMask) = '') then
   begin
      MessageDlg('Preencha o campo "Celular" ou o campo "Email".',mtInformation,[mbOK],0);
   end;
end;

procedure Tpessoas_juridicas_contato_form.ed_chaveKeyDown(Sender: TObject;
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

procedure Tpessoas_juridicas_contato_form.ed_emailExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;

   if (LimparMascara(ed_celular.Text,ed_celular.EditMask) = '') and (LimparString(ed_email.Text) = '') then
   begin
      MessageDlg('Preencha o campo "Email" ou o campo "Celular" deve ser preenchido.',mtInformation,[mbOK],0);
      Abort;
   end;

   if (LimparString(ed_email.Text) <> '') and (not ValidarEmail(ed_email.text)) then
   begin
      MessageDlg('O Campo "Email" está inválido.',mtInformation,[mbOK],0);
      ed_email.SetFocus;
      Abort;
   end;
end;

procedure Tpessoas_juridicas_contato_form.ed_nomeExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;

   if (LimparString(ed_nome.Text) = '') then
   begin
      MessageDlg('O Campo "Nome" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_nome.SetFocus;
      Abort;
   end;
end;

procedure Tpessoas_juridicas_contato_form.FormCreate(Sender: TObject);
begin
   inherited;

   tabela := 'pessoas_juridicas_contatos';
   chave := 'sequencial, sequencial_pessoa_juridica';
end;

procedure Tpessoas_juridicas_contato_form.FormDestroy(Sender: TObject);
begin
   inherited;

   pessoas_juridicas_form.cadastro.Enabled := true;
   pessoas_juridicas_form.cadastro.atualizar_grids;

   pessoas_juridicas_contato_form := nil;
end;

end.
