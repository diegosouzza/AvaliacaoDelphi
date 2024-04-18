unit pessoas_juridicas_vinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cadastro, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  Tpessoas_juridicas_vinc_form = class(Tcadastro_form)
    Label2: TLabel;
    Label3: TLabel;
    ed_sequencial_pessoa_juridica: TMaskEdit;
    ed_nome_pj: TEdit;
    Label4: TLabel;
    ed_nome_pjv: TEdit;
    procedure ed_chaveExit(Sender: TObject);
    procedure bt_salvarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function pessoa_juridica_vinculada: boolean;
  public
    { Public declarations }
  end;

var
  pessoas_juridicas_vinc_form: Tpessoas_juridicas_vinc_form;

implementation

{$R *.dfm}

uses data_module3, pessoas_juridicas, biblioteca;

procedure Tpessoas_juridicas_vinc_form.bt_salvarClick(Sender: TObject);
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
         if MessageDlg('Deseja vincular a Pessoa Juridica: "'+LimparString(ed_chave.Text)+'" com a Pessoa Jurídica: "'+LimparString(ed_sequencial_pessoa_juridica.Text)+'"?',mtInformation,[mbYes,mbNo],0) = 6 then
         begin
            ExecutarSQL('insert into pessoas_juridicas_vinculadas (sequencial_pessoa_juridica_vinc,sequencial_pessoa_juridica) values ('+StringParaFirebird(ed_chave.Text)+','+StringParaFirebird(ed_sequencial_pessoa_juridica.Text)+')');
            MessageDlg('A Pessoa Jurídica foi vinculada com Sucesso.',mtInformation,[mbOK],0);
            finalizado := true;
         end;
         3:
         if MessageDlg('Deseja desvincular a Pessoa Juridica: "'+LimparString(ed_chave.Text)+'" com a Pessoa Jurídica: "'+LimparString(ed_sequencial_pessoa_juridica.Text)+'"?',mtInformation,[mbYes,mbNo],0) = 6 then
         begin
            ExecutarSQL('delete from pessoas_juridicas_pf where sequencial_pessoa_juridica_vinc = '+StringParaFirebird(ed_chave.Text)+' and sequencial_pessoa_juridica='+StringParaFirebird(ed_sequencial_pessoa_juridica.Text));
            MessageDlg('A Pessoa Jurídica foi desvinculada com Sucesso.',mtInformation,[mbOK],0);
            finalizado := true;
         end;
      end;
   finally
      executando := false;
   end;

   if finalizado then
      Close;
end;

procedure Tpessoas_juridicas_vinc_form.ed_chaveExit(Sender: TObject);
begin
   if self.ActiveControl = bt_cancelar then
      exit;
   if acao = 3 then
      exit;

   if (LimparString(ed_chave.Text) = '') then
   begin
      MessageDlg('O Campo "Pessoa Jurídica a Vincular" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_chave.SetFocus;
      Abort;
   end;

   if LimparString(ed_chave.Text) = LimparString(ed_sequencial_pessoa_juridica.Text) then
   begin
      MessageDlg('O Campo "Pessoa Jurídica a Vincular" não pode ser o mesmo "Sequencial Pessoa Jurídica".',mtInformation,[mbOK],0);
      ed_chave.SetFocus;
      Abort;
   end;

   if not pessoa_juridica_vinculada then
   begin
      try
         with dm3.dataset do
         begin
            close;
            sql.Text := 'select nome from pessoas_juridicas where sequencial = '+StringParaFirebird(ed_chave.Text);
            open;

            if IsEmpty then
            begin
               MessageDlg('A "Pessoa Jurídica a Vincular" não está cadastrada.',mtInformation,[mbOK],0);
               ed_chave.SetFocus;
               Abort;
            end;

            ed_nome_pjv.Text := Fields[0].AsString;

            bt_salvar.SetFocus;
         end;
      finally
         dm3.dataset.Close;
      end;
   end;
end;

procedure Tpessoas_juridicas_vinc_form.FormCreate(Sender: TObject);
begin
//
end;

procedure Tpessoas_juridicas_vinc_form.FormDestroy(Sender: TObject);
begin
  inherited;

   pessoas_juridicas_form.cadastro.Enabled := true;
   pessoas_juridicas_form.cadastro.atualizar_grids;

   pessoas_juridicas_vinc_form := nil;
end;

function Tpessoas_juridicas_vinc_form.pessoa_juridica_vinculada: boolean;
var
   vinculada: string;
begin
   result := false;
   try
      with dm3.dataset do
      begin
         close;
         sql.Text := 'select * from pessoas_juridicas_vinculadas where sequencial_pessoa_juridica = '+StringParaFirebird(ed_chave.Text)+' or sequencial_pessoa_juridica_vinc = '+StringParaFirebird(ed_chave.Text);
         open;

         result := not IsEmpty;

         if not IsEmpty then
         begin
            if LimparString(ed_chave.Text) = FieldByName('sequencial_pessoa_juridica').AsString then
               vinculada := FieldByName('sequencial_pessoa_juridica_vinc').AsString
            else
               vinculada := FieldByName('sequencial_pessoa_juridica').AsString;

            MessageDlg('A Pessoa Jurídica "'+LimparString(ed_chave.Text)+'" está Vinculada a Pessoa Jurídica "'+vinculada+'".',mtInformation,[mbOK],0);
            ed_chave.SetFocus;
            abort;
         end;
      end;
   finally
      dm3.dataset.Close;
   end;
end;

end.
