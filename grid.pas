unit grid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, cadastro;

type
   Tgrid_form = class(TForm)
      GroupBox1: TGroupBox;
      grid: TDBGrid;
      Panel1: TPanel;
      bt_incluir: TSpeedButton;
      bt_alterar: TSpeedButton;
      bt_deletar: TSpeedButton;
    bt_listar: TSpeedButton;
      bt_sair: TSpeedButton;
      ds: TDataSource;
      query: TFDQuery;
      procedure bt_sairClick(Sender: TObject);
      procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
      { Private declarations }
  public

    sql: string;
    executando: boolean;

    procedure atualizar_grid;
  end;

var
  grid_form: Tgrid_form;

implementation

{$R *.dfm}

procedure Tgrid_form.atualizar_grid;
begin
   query.Close;
   query.SQL.Text := sql;
   query.Open;
end;

procedure Tgrid_form.bt_sairClick(Sender: TObject);
begin
   close;
end;

procedure Tgrid_form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   query.Close;
end;

procedure Tgrid_form.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose := (not executando);
end;

procedure Tgrid_form.FormShow(Sender: TObject);
begin
   atualizar_grid;
end;

end.
