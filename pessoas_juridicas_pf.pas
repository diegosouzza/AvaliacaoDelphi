unit pessoas_juridicas_pf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cadastro, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  Tpessoas_juridicas_pf_form = class(Tcadastro_form)
    Label2: TLabel;
    ed_sequencial_pessoa_juridica: TMaskEdit;
    ed_nome_pj: TEdit;
    Label3: TLabel;
    ed_nome_pf: TEdit;
    Label4: TLabel;
    procedure bt_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_pesquisarClick(Sender: TObject);
    procedure ed_chaveExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
      function pessoa_fisica_vinculada: boolean;
  public
    { Public declarations }
  end;

var
  pessoas_juridicas_pf_form: Tpessoas_juridicas_pf_form;

implementation

{$R *.dfm}

uses data_module3, biblioteca, pessoas_juridicas;

procedure Tpessoas_juridicas_pf_form.bt_pesquisarClick(Sender: TObject);
begin
//
end;

procedure Tpessoas_juridicas_pf_form.bt_salvarClick(Sender: TObject);
var
   finalizado: boolean;
begin
   if executando then
      exit;
   executando := true;
   finalizado := false;
   try
      ValidarCampos(GroupBox1);
      case acao of
         1:
         if MessageDlg('Deseja vincular a Pessoa Física: "'+LimparString(ed_chave.Text)+'" com a Pessoa Jurídica: "'+LimparString(ed_sequencial_pessoa_juridica.Text)+'"?',mtInformation,[mbYes,mbNo],0) = 6 then
         begin
            ExecutarSQL('insert into pessoas_juridicas_pf (sequencial_pessoa_fisica,sequencial_pessoa_juridica) values ('+StringParaFirebird(ed_chave.Text)+','+StringParaFirebird(ed_sequencial_pessoa_juridica.Text)+')');
            MessageDlg('Pessoa Física vinculada com Sucesso.',mtInformation,[mbOK],0);
            finalizado := true;
         end;
         3:
         if MessageDlg('Deseja desvincular a Pessoa Física: "'+LimparString(ed_chave.Text)+'" com a Pessoa Jurídica: "'+LimparString(ed_sequencial_pessoa_juridica.Text)+'"?',mtInformation,[mbYes,mbNo],0) = 6 then
         begin
            ExecutarSQL('delete from pessoas_juridicas_pf where sequencial_pessoa_fisica = '+StringParaFirebird(ed_chave.Text)+' and sequencial_pessoa_juridica='+StringParaFirebird(ed_sequencial_pessoa_juridica.Text));
            MessageDlg('A Pessoa Física foi desvinculada com Sucesso.',mtInformation,[mbOK],0);
            finalizado := true;
         end;
      end;
   finally
      executando := false;
   end;
   if finalizado then
      close;
end;

procedure Tpessoas_juridicas_pf_form.ed_chaveExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;
   if acao = 3 then
      exit;

   if (LimparString(ed_chave.Text) = '') then
   begin
      MessageDlg('O Campo "Pessoa Física" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_chave.SetFocus;
      Abort;
   end;

   if not pessoa_fisica_vinculada then
   begin
      try
         with dm3.dataset do
         begin
            close;
            sql.Text := 'select nome from pessoas_fisicas where sequencial = '+StringParaFirebird(ed_chave.Text);
            open;

            if IsEmpty then
            begin
               MessageDlg('A "Pessoa Fisíca" não está cadastrada.',mtInformation,[mbOK],0);
               ed_chave.SetFocus;
               Abort;
            end;
            ed_nome_pf.Text := Fields[0].AsString;

            bt_salvar.SetFocus;
         end;
      finally
         dm3.dataset.Close;
      end;
   end;
end;

procedure Tpessoas_juridicas_pf_form.FormCreate(Sender: TObject);
begin
//
end;

procedure Tpessoas_juridicas_pf_form.FormDestroy(Sender: TObject);
begin
   inherited;
   pessoas_juridicas_form.cadastro.Enabled := true;
   pessoas_juridicas_form.cadastro.atualizar_grids;

   pessoas_juridicas_pf_form := nil;
end;

function Tpessoas_juridicas_pf_form.pessoa_fisica_vinculada: boolean;
begin
   result := false;
   try
      with dm3.dataset do
      begin
         close;
         sql.Text := 'select sequencial_pessoa_juridica from pessoas_juridicas_pf where sequencial_pessoa_fisica = '+StringParaFirebird(ed_chave.Text);
         open;

         result := not IsEmpty;

         if not IsEmpty then
         begin
            MessageDlg('A Pessoa Física "'+LimparString(ed_chave.Text)+'" está Vinculada a Pessoa Jurídica "'+Fields[0].AsString+'".',mtInformation,[mbOK],0);
            ed_chave.SetFocus;
            abort;
         end;
      end;
   finally
      dm3.dataset.Close;
   end;
end;

end.
