unit pessoas_fisicas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, grid, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, pessoas_fisicas_cad;

type
   TCadastro = class(Tpessoas_fisicas_cad_for);
   Tpessoas_fisicas_form = class(Tgrid_form)
      procedure FormCreate(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormDestroy(Sender: TObject);
      procedure bt_incluirClick(Sender: TObject);
      procedure bt_alterarClick(Sender: TObject);
      procedure bt_deletarClick(Sender: TObject);
    procedure bt_listarClick(Sender: TObject);
  private
    { Private declarations }
  public
    cadastro: TCadastro;
  end;

var
  pessoas_fisicas_form: Tpessoas_fisicas_form;

implementation

{$R *.dfm}

uses inicio, pessoas_fisicas_relatorio;

procedure Tpessoas_fisicas_form.bt_incluirClick(Sender: TObject);
begin
   cadastro := TCadastro.Create(self);
   cadastro.inciar_form(1);
   cadastro.Show;
   Self.Enabled := false;
end;

procedure Tpessoas_fisicas_form.bt_listarClick(Sender: TObject);
begin
   if not Assigned(pessoas_fisicas_relatorio_form) then
   begin
      pessoas_fisicas_relatorio_form := Tpessoas_fisicas_relatorio_form.Create(Self);
      FreeAndNil(pessoas_fisicas_relatorio_form)
   end;
end;

procedure Tpessoas_fisicas_form.bt_alterarClick(Sender: TObject);
begin
   cadastro := TCadastro.Create(self);
   cadastro.inciar_form(2);
   cadastro.Show;
   Self.Enabled := false;
end;

procedure Tpessoas_fisicas_form.bt_deletarClick(Sender: TObject);
begin
   cadastro := TCadastro.Create(self);
   cadastro.inciar_form(3);
   cadastro.Show;
   Self.Enabled := false;
end;

procedure Tpessoas_fisicas_form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   inherited;

   Inicio_form.act_cad_pessoas_fisicas.Enabled := true;
end;

procedure Tpessoas_fisicas_form.FormCreate(Sender: TObject);
begin
   inherited;

   sql := 'select sequencial,nome, cpf from pessoas_fisicas';

end;

procedure Tpessoas_fisicas_form.FormDestroy(Sender: TObject);
begin
   inherited;
   pessoas_fisicas_form := nil;
end;

end.
