unit pessoas_fisicas_cad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cadastro, Vcl.StdCtrls, Vcl.Mask, biblioteca,
  Vcl.Buttons;

type
  Tpessoas_fisicas_cad_for = class(Tcadastro_form)
    GroupBox2: TGroupBox;
    Label2: TLabel;
    ed_nome: TMaskEdit;
    Label3: TLabel;
    ed_cpf: TMaskEdit;
    procedure FormDestroy(Sender: TObject);
    procedure ed_nomeExit(Sender: TObject);
    procedure ed_cpfExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pessoas_fisicas_cad_for: Tpessoas_fisicas_cad_for;

implementation

{$R *.dfm}

uses pessoas_fisicas;

procedure Tpessoas_fisicas_cad_for.ed_cpfExit(Sender: TObject);
begin
    if self.ActiveControl = bt_cancelar then
      exit;

   if (LimparString(ed_cpf.Text) = '') then
   begin
      MessageDlg('O Campo "CPF" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_cpf.SetFocus;
      Abort;
   end;

   if not ValidarCpf(ed_cpf.Text) then
   begin
      MessageDlg('O Campo "CPF" está inválido.',mtInformation,[mbOK],0);
      ed_cpf.SetFocus;
      Abort;
   end;

   bt_salvarClick(bt_salvar);
end;

procedure Tpessoas_fisicas_cad_for.ed_nomeExit(Sender: TObject);
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

procedure Tpessoas_fisicas_cad_for.FormCreate(Sender: TObject);
begin
   inherited;
   tabela := 'pessoas_fisicas';
   chave := 'sequencial';
end;

procedure Tpessoas_fisicas_cad_for.FormDestroy(Sender: TObject);
begin
   inherited;
   self := nil;
   pessoas_fisicas_form.atualizar_grid;
   pessoas_fisicas_form.Enabled := true;
end;

end.
