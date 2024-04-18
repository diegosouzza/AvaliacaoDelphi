unit pessoas_juridicas_cad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cadastro, Vcl.StdCtrls, Vcl.Mask, biblioteca,
  Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tpessoas_juridicas_cad_form = class(Tcadastro_form)
    GroupBox2: TGroupBox;
    Label2: TLabel;
    ed_nome: TMaskEdit;
    Label3: TLabel;
    ed_cnpj: TMaskEdit;
    GroupBox3: TGroupBox;
    PageControl1: TPageControl;
    tab_enderecos: TTabSheet;
    tab_contatos: TTabSheet;
    tab_pessoas_fisicas: TTabSheet;
    Panel1: TPanel;
    bt_incluir_endereco: TSpeedButton;
    bt_alterar_enderecos: TSpeedButton;
    bt_deletar_enderecos: TSpeedButton;
    grid_pessoas_fisicas: TDBGrid;
    Panel2: TPanel;
    bt_incluir_pessoas_fisicas: TSpeedButton;
    bt_deletar_pessoas_fisicas: TSpeedButton;
    grid_enderecos: TDBGrid;
    grid_contatos: TDBGrid;
    Panel3: TPanel;
    bt_incluir_contatos: TSpeedButton;
    bt_alterar_contatos: TSpeedButton;
    bt_deletar_contatos: TSpeedButton;
    bt_i: TSpeedButton;
    bt_a: TSpeedButton;
    bt_d: TSpeedButton;
    ds_enderecos: TDataSource;
    ds_contatos: TDataSource;
    ds_pessoas_fisicas: TDataSource;
    query_enderecos: TFDQuery;
    query_contatos: TFDQuery;
    query_pessoas_fisicas: TFDQuery;
    tb_pessoa_juridica: TTabSheet;
    grid_pessoa_juridica: TDBGrid;
    Panel4: TPanel;
    bt_Incluir_pessoa_juridica: TSpeedButton;
    bt_deletar_pessoa_juridica: TSpeedButton;
    ds_pessoa_juridica: TDataSource;
    query_pessoa_juridica: TFDQuery;
    procedure ed_nomeExit(Sender: TObject);
    procedure ed_cnpjExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bt_iClick(Sender: TObject);
    procedure bt_dClick(Sender: TObject);
    procedure bt_aClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bt_salvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ed_chaveExit(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    procedure excluir_tabelas_vinculadas(chave_anterior:string);
  public
    procedure atualizar_grids; overload;
  end;

var
  pessoas_juridicas_cad_form: Tpessoas_juridicas_cad_form;

implementation

{$R *.dfm}

uses data_module3, pessoas_juridicas, pessoas_juridicas_contato,
  pessoas_juridicas_endereco, pessoas_juridicas_pf, pessoas_juridicas_vinc;

procedure Tpessoas_juridicas_cad_form.atualizar_grids;
begin
   case PageControl1.TabIndex of
      0:
      begin
         query_enderecos.Close;
         query_enderecos.SQL.Text := 'select * from pessoas_juridicas_enderecos where sequencial_pessoa_juridica = '+trim(ed_chave.Text);
         query_enderecos.Open;
      end;
      1:
      begin
         query_contatos.Close;
         query_contatos.SQL.Text := 'select * from pessoas_juridicas_contatos where sequencial_pessoa_juridica = '+trim(ed_chave.Text);
         query_contatos.Open;
      end;
      2:
      begin
         query_pessoas_fisicas.Close;
         query_pessoas_fisicas.SQL.Text := 'select pjf.sequencial_pessoa_fisica, pf.nome, pf.cpf from pessoas_juridicas_pf pjf left join pessoas_fisicas pf on (pf.sequencial = pjf.sequencial_pessoa_fisica) where pjf.sequencial_pessoa_juridica = '+trim(ed_chave.Text);
         query_pessoas_fisicas.Open;
      end;
      3:
      begin
         query_pessoa_juridica.Close;
         query_pessoa_juridica.SQL.Text := 'select pjv.sequencial_pessoa_juridica_vinc, pj.nome, pj.cnpj from pessoas_juridicas_vinculadas pjv left join pessoas_juridicas pj on (pjv.sequencial_pessoa_juridica_vinc = pj.sequencial) where pjv.sequencial_pessoa_juridica = '+trim(ed_chave.Text);
         query_pessoa_juridica.Open;
      end;
   end;

end;

procedure Tpessoas_juridicas_cad_form.bt_aClick(Sender: TObject);
begin
   case PageControl1.TabIndex of
      0:
      begin
         pessoas_juridicas_endereco_form := Tpessoas_juridicas_endereco_form.Create(self);
         pessoas_juridicas_endereco_form.inciar_form(2);
         pessoas_juridicas_endereco_form.ed_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_endereco_form.ed_chave.Text := query_enderecos.FieldByName('sequencial').AsString;
         pessoas_juridicas_endereco_form.Show;

         Self.Enabled := false;
      end;
      1:
      begin
         pessoas_juridicas_contato_form := Tpessoas_juridicas_contato_form.Create(self);
         pessoas_juridicas_contato_form.inciar_form(2);
         pessoas_juridicas_contato_form.ed_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_contato_form.ed_chave.Text := query_contatos.FieldByName('sequencial').AsString;
         pessoas_juridicas_contato_form.Show;

         Self.Enabled := false;
      end;
   end;
end;

procedure Tpessoas_juridicas_cad_form.bt_dClick(Sender: TObject);
begin
   case PageControl1.TabIndex of
      0:
      begin
         pessoas_juridicas_endereco_form := Tpessoas_juridicas_endereco_form.Create(self);
         pessoas_juridicas_endereco_form.inciar_form(3);
         pessoas_juridicas_endereco_form.ed_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_endereco_form.ed_chave.Text := query_enderecos.FieldByName('sequencial').AsString;
         pessoas_juridicas_endereco_form.Show;

         Self.Enabled := false;
      end;
      1:
      begin
         pessoas_juridicas_contato_form := Tpessoas_juridicas_contato_form.Create(self);
         pessoas_juridicas_contato_form.inciar_form(3);
         pessoas_juridicas_contato_form.ed_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_contato_form.ed_chave.Text := query_contatos.FieldByName('sequencial').AsString;
         pessoas_juridicas_contato_form.Show;

         Self.Enabled := false;
      end;
      2:
      begin
         pessoas_juridicas_pf_form := Tpessoas_juridicas_pf_form.Create(self);
         pessoas_juridicas_pf_form.inciar_form(3);
         pessoas_juridicas_pf_form.ed_sequencial_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_pf_form.ed_nome_pj.Text := ed_nome.Text;
         pessoas_juridicas_pf_form.ed_chave.Text := query_pessoas_fisicas.FieldByName('sequencial_pessoa_fisica').AsString;
         pessoas_juridicas_pf_form.ed_chave.Enabled := false;
         pessoas_juridicas_pf_form.ed_nome_pf.Text := query_pessoas_fisicas.FieldByName('nome').AsString;
         pessoas_juridicas_pf_form.Show;

         Self.Enabled := false;
      end;
      3:
      begin
         pessoas_juridicas_vinc_form := Tpessoas_juridicas_vinc_form.Create(self);
         pessoas_juridicas_vinc_form.inciar_form(3);
         pessoas_juridicas_vinc_form.ed_sequencial_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_vinc_form.ed_nome_pj.Text := ed_nome.Text;
         pessoas_juridicas_vinc_form.ed_chave.Text := query_pessoa_juridica.FieldByName('sequencial_pessoa_juridica_vinc').AsString;
         pessoas_juridicas_vinc_form.ed_chave.Enabled := false;
         pessoas_juridicas_vinc_form.ed_nome_pjv.Text := query_pessoa_juridica.FieldByName('nome').AsString;
         pessoas_juridicas_vinc_form.Show;

         Self.Enabled := false;
      end;
   end;
end;

procedure Tpessoas_juridicas_cad_form.bt_iClick(Sender: TObject);
begin
   case PageControl1.TabIndex of
      0:
      begin
         pessoas_juridicas_endereco_form := Tpessoas_juridicas_endereco_form.Create(self);
         pessoas_juridicas_endereco_form.ed_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_endereco_form.inciar_form(1);
         pessoas_juridicas_endereco_form.Show;

         Self.Enabled := false;
      end;
      1:
      begin
         pessoas_juridicas_contato_form := Tpessoas_juridicas_contato_form.Create(self);
         pessoas_juridicas_contato_form.ed_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_contato_form.inciar_form(1);
         pessoas_juridicas_contato_form.Show;

         Self.Enabled := false;
      end;
      2:
      begin
         pessoas_juridicas_pf_form := Tpessoas_juridicas_pf_form.Create(self);
         pessoas_juridicas_pf_form.ed_sequencial_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_pf_form.ed_nome_pj.Text := ed_nome.Text;
         pessoas_juridicas_pf_form.inciar_form(1);
         pessoas_juridicas_pf_form.Show;

         Self.Enabled := false;
      end;
      3:
      begin
         pessoas_juridicas_vinc_form := Tpessoas_juridicas_vinc_form.Create(self);
         pessoas_juridicas_vinc_form.ed_sequencial_pessoa_juridica.Text := ed_chave.Text;
         pessoas_juridicas_vinc_form.ed_nome_pj.Text := ed_nome.Text;
         pessoas_juridicas_vinc_form.inciar_form(1);
         pessoas_juridicas_vinc_form.Show;

         Self.Enabled := false;
      end;
   end;
end;

procedure Tpessoas_juridicas_cad_form.bt_salvarClick(Sender: TObject);
var
   chave_anterior: string;
begin
   chave_anterior := ed_chave.Text;

   inherited;

   case acao of
      3:
      begin
         if (trim(chave_anterior) <> '') and ed_chave.Enabled then
            excluir_tabelas_vinculadas(chave_anterior);
      end;
   end;
end;

procedure Tpessoas_juridicas_cad_form.ed_chaveExit(Sender: TObject);
begin
   inherited;
   if not ed_chave.Enabled then
      atualizar_grids;
end;

procedure Tpessoas_juridicas_cad_form.ed_cnpjExit(Sender: TObject);
begin
   if Self.ActiveControl = bt_cancelar then
      exit;

   if (LimparString(ed_cnpj.Text) = '') then
   begin
      MessageDlg('O Campo "CNPJ" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_cnpj.SetFocus;
      Abort;
   end;

   if not ValidarCNPJ(ed_cnpj.Text) then
   begin
      MessageDlg('O Campo "CNPJ" está inválido.',mtInformation,[mbOK],0);
      ed_cnpj.SetFocus;
      Abort;
   end;

end;

procedure Tpessoas_juridicas_cad_form.ed_nomeExit(Sender: TObject);
begin
   if Self.ActiveControl = bt_cancelar then
      exit;

   if (LimparString(ed_nome.Text) = '') then
   begin
      MessageDlg('O Campo "Nome" deve ser preenchido.',mtInformation,[mbOK],0);
      ed_nome.SetFocus;
      Abort;
   end;
end;

procedure Tpessoas_juridicas_cad_form.excluir_tabelas_vinculadas(chave_anterior:string);
begin
   ExecutarSQL('delete from pessoas_juridicas_contatos where sequencial_pessoa_juridica = '+StringParaFirebird(chave_anterior));
   ExecutarSQL('delete from pessoas_juridicas_enderecos where sequencial_pessoa_juridica = '+StringParaFirebird(chave_anterior));
   ExecutarSQL('delete from pessoas_juridicas_pf where sequencial_pessoa_juridica = '+StringParaFirebird(chave_anterior));
   ExecutarSQL('delete from pessoas_juridicas_vinculadas where sequencial_pessoa_juridica = '+StringParaFirebird(chave_anterior)+' or sequencial_pessoa_juridica_vinc = '+StringParaFirebird(chave_anterior));
end;

procedure Tpessoas_juridicas_cad_form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   inherited;
   if (cadastrado) and (not ed_chave.Enabled) then
   begin
      excluir_tabelas_vinculadas(ed_chave.Text);
   end;
end;

procedure Tpessoas_juridicas_cad_form.FormCreate(Sender: TObject);
begin
   inherited;

   tabela := 'pessoas_juridicas';
   chave := 'sequencial';
end;

procedure Tpessoas_juridicas_cad_form.FormDestroy(Sender: TObject);
begin
   inherited;
   pessoas_juridicas_form.Enabled := true;
   pessoas_juridicas_form.atualizar_grid;
   pessoas_juridicas_cad_form := nil;
end;

procedure Tpessoas_juridicas_cad_form.FormShow(Sender: TObject);
begin
   inherited;

   PageControl1.TabIndex := 0;
end;

procedure Tpessoas_juridicas_cad_form.PageControl1Change(Sender: TObject);
begin
   atualizar_grids;
end;

end.
