unit cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, biblioteca;

type
  Tcadastro_form = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ed_chave: TMaskEdit;
    bt_pesquisar: TSpeedButton;
    bt_salvar: TButton;
    bt_cancelar: TButton;
    procedure bt_cancelarClick(Sender: TObject);
    procedure bt_salvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure ed_chaveExit(Sender: TObject);
    procedure ed_chaveKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bt_pesquisarClick(Sender: TObject);
  private
    vCampos: aCampos;

    procedure cadastrar_chave;
    procedure exluir_chave;
  public
    executando: boolean;
    cadastrado: boolean;
    tabela: string;
    chave: string;

    acao: integer; // 1- Incluir; 2- Alterar; 3-Deletar
    procedure inciar_form(n: integer);
    procedure atualizar_grids; overload;
  end;

var
  cadastro_form: Tcadastro_form;

implementation

{$R *.dfm}

uses data_module3;

procedure Tcadastro_form.atualizar_grids;
begin

end;

procedure Tcadastro_form.bt_cancelarClick(Sender: TObject);
begin
   close;
end;

procedure Tcadastro_form.bt_pesquisarClick(Sender: TObject);
begin
   case acao  of
      1:
      begin
         ed_chave.Text := buscar_sequencial(copy(ed_chave.HelpKeyword,5,length(ed_chave.HelpKeyword)-4),tabela,'');
      end;
   end;
end;

procedure Tcadastro_form.bt_salvarClick(Sender: TObject);
var
   tem_blob: boolean;
   sql, tempStr, valores: string;
   i, j, c: Integer;
begin
   if executando then
      exit;
   executando := true;
   try
      bt_salvar.SetFocus;

      if (ActiveControl.Tag <> 3) then
         Abort;

      if ed_chave.Enabled then
      begin
         ValidarCampos(GroupBox1);

         case acao of
            1: cadastrar_chave;
            2,3:
            begin
               with dm3.dataset do
               begin
                  close;
                  sql.Text := 'select * from '+tabela+MontarChaves(GroupBox1,2);
                  try
                     Open;
                     if IsEmpty then
                     begin
                        MessageDlg(Label1.Caption+' não encontrado.',mtInformation,[mbOK],0);
                        ed_chave.SetFocus;
                     end
                     else
                     begin
                        PreencherCampos(self,dm3.dataset);

                        HabilitarCampos(self,1,false);
                        if acao = 2 then
                           HabilitarCampos(self,0,true);
                     end;
                  finally
                     close;
                  end;
               end;
            end;
         end;

         atualizar_grids;
         exit;
      end
      else
      case acao of
         1, 2:
         begin
            ValidarCampos(Self);
            valores := '';
            SetLength(vCampos,0);
            vCampos := MontarCampos(self);

            for j := 0 to high(vCampos) do
            begin
               if (LowerCase(vCampos[j].tabela) = tabela) then
               begin
                  valores := valores+vCampos[j].nome+'=';
                  if (vCampos[j].tipo = 1) then
                     valores := valores+StringParaFirebird(vCampos[j].valor)+','
                  else
                  if (vCampos[j].tipo = 2) then
                     valores := valores+StringParaFirebird(vCampos[j].valor)+','
                  else
                  if (vCampos[j].tipo = 3) then
                     valores := valores+vCampos[j].valor+',';
               end;
            end;

            valores := StringReplace(copy(valores,1,length(valores)-1),QuotedStr('#$1F'),'',[rfReplaceAll]);

            if (trim(valores) <> '') then
            begin
               sql := 'update '+tabela+' set '+valores+' '+MontarChaves(GroupBox1,2);
               ExecutarSQL(sql)
            end;

            case acao of
               1: MessageDlg('Cadastrado com sucesso!',mtInformation,[mbOK],0);
               2: MessageDlg('Alterado com sucesso!',mtInformation,[mbOK],0);
            end;

            cadastrado := true;
         end;
         3:
         begin
            if MessageDlg('Deseja Deletar este '+Label1.Caption+'?',mtInformation,[mbYes,mbNo],0) = 6 then
            begin
               exluir_chave;
               MessageDlg('Deletado com sucesso!',mtInformation,[mbOK],0)
            end;
         end;
      end;

      LimparCampos(self);
      HabilitarCampos(self,0,false);
      HabilitarCampos(self,1,true);

      SetLength(vCampos,0);

      ed_chave.SetFocus;
   finally
      executando := false;
   end;
end;

procedure Tcadastro_form.cadastrar_chave;
var
   resultado: string;
begin
    resultado := ExecutarSQL('insert into '+tabela+MontarChaves(GroupBox1,1));

    if resultado = '' then
    begin
      cadastrado := true;

      HabilitarCampos(self,1,false);
      HabilitarCampos(self,0,true);
    end
    else
    begin
      if pos('violation of PRIMARY or UNIQUE KEY',resultado) > 0 then
      begin
         MessageDlg(Label1.Caption+' já está cadastrado.',mtError,[mbOK],0);
         ed_chave.SetFocus;
         Abort;
      end
      else
      begin
         MessageDlg('Erro ao cadastrar '+Label1.Caption+'.'+#13+'Mensagem: '+resultado,mtError,[mbOK],0);
         ed_chave.SetFocus;
         Abort;
      end;
    end;
end;

procedure Tcadastro_form.ed_chaveExit(Sender: TObject);
begin
   if executando then
      exit;
   if self.ActiveControl = bt_cancelar then
      exit;

   if trim(ed_chave.Text) <> '' then
      bt_salvarClick(bt_salvar)
   else
      bt_cancelarClick(bt_cancelar);
end;

procedure Tcadastro_form.ed_chaveKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure Tcadastro_form.exluir_chave;
var
   i: Integer;
   sql_condicao: string;
begin
   ExecutarSQL('delete from '+tabela+MontarChaves(GroupBox1,2));
end;

procedure Tcadastro_form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if (cadastrado) and (not ed_chave.Enabled) then
   begin
      exluir_chave;
   end;

   Action := caFree;
end;

procedure Tcadastro_form.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose := not executando;
end;

procedure Tcadastro_form.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = 13 then
   begin
      if Self.ActiveControl = ed_chave then
         exit;

      key := 0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure Tcadastro_form.inciar_form(n: integer);
begin
   acao := n;
   HabilitarCampos(Self,0,false);
   case acao of
      1: Caption := Caption+' - Incluir';
      2: Caption := Caption+' - Alterar';
      3: Caption := Caption+' - Deletar';
   end;

end;

end.

// ********** HELPKEYWORD **********
// --- CAMPOS ---
// CHAVE(1- SIM; 2-NÃO)|TIPO|CAMPO_NOME
// --- GROUPBOX ---
// TABELA
// ********** TAG - COMPONENTS **********
// 0 - CAMPOS
// 1 - CHAVES
