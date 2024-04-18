unit pessoas_juridicas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, grid, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, pessoas_juridicas_cad;

type
   TCadastro = class(Tpessoas_juridicas_cad_form);
   Tpessoas_juridicas_form = class(Tgrid_form)
    procedure bt_incluirClick(Sender: TObject);
    procedure bt_alterarClick(Sender: TObject);
    procedure bt_deletarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bt_listarClick(Sender: TObject);
  private
    { Private declarations }
  public
    cadastro: TCadastro;
  end;

var
  pessoas_juridicas_form: Tpessoas_juridicas_form;

implementation

{$R *.dfm}

uses inicio, pessoas_juridicas_relatorio;

procedure Tpessoas_juridicas_form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   inherited;

   Inicio_form.act_cad_pessoas_juridicas.Enabled := true;
end;

procedure Tpessoas_juridicas_form.FormCreate(Sender: TObject);
begin
   inherited;
   sql := 'select sequencial, nome, cnpj from pessoas_juridicas';
end;

procedure Tpessoas_juridicas_form.FormDestroy(Sender: TObject);
begin
   inherited;
   pessoas_juridicas_form := nil;
end;

procedure Tpessoas_juridicas_form.bt_incluirClick(Sender: TObject);
begin
   cadastro := TCadastro.Create(self);
   cadastro.inciar_form(1);
   cadastro.Show;
   Self.Enabled := false;
end;

procedure Tpessoas_juridicas_form.bt_listarClick(Sender: TObject);
begin
   if not Assigned(pessoas_juridicas_relatorio_form) then
   begin
      pessoas_juridicas_relatorio_form := Tpessoas_juridicas_relatorio_form.Create(Self);
      FreeAndNil(pessoas_juridicas_relatorio_form);
   end;
end;

procedure Tpessoas_juridicas_form.bt_alterarClick(Sender: TObject);
begin
   cadastro := TCadastro.Create(self);
   cadastro.inciar_form(2);
   cadastro.Show;
   Self.Enabled := false;
end;

procedure Tpessoas_juridicas_form.bt_deletarClick(Sender: TObject);
begin
   cadastro := TCadastro.Create(self);
   cadastro.inciar_form(3);
   cadastro.Show;
   Self.Enabled := false;
end;

end.
