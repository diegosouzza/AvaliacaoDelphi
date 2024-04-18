unit inicio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.StdStyleActnCtrls,
  Vcl.PlatformDefaultStyleActnCtrls;

type
  TInicio_form = class(TForm)
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    act_cad_pessoas_fisicas: TAction;
    act_cad_pessoas_juridicas: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure act_cad_pessoas_fisicasExecute(Sender: TObject);
    procedure act_cad_pessoas_juridicasExecute(Sender: TObject);
  private
    function conectar: boolean;
  public
    { Public declarations }
  end;

var
  Inicio_form: TInicio_form;

implementation

{$R *.dfm}

uses data_module3, pessoas_fisicas, pessoas_juridicas;

{ TInicio_form }

procedure TInicio_form.act_cad_pessoas_fisicasExecute(Sender: TObject);
begin
   act_cad_pessoas_fisicas.Enabled := false;
   pessoas_fisicas_form := Tpessoas_fisicas_form.Create(self);
   pessoas_fisicas_form.show;
end;

procedure TInicio_form.act_cad_pessoas_juridicasExecute(Sender: TObject);
begin
   act_cad_pessoas_juridicas.Enabled := false;
   pessoas_juridicas_form := Tpessoas_juridicas_form.Create(self);
   pessoas_juridicas_form.show;
end;

function TInicio_form.conectar: boolean;
begin

   dm3.conexao.Params.Database := ExtractFilePath(ParamStr(0))+'dados\avaliacao.fdb';
   dm3.conexao.Params.UserName := 'SYSDBA';
   dm3.conexao.Params.Password := 'masterkey';
   dm3.driver.VendorLib := ExtractFilePath(ParamStr(0))+'firebird\bin\fbclient.dll';

   try
      dm3.conexao.Open;
      result := dm3.conexao.Connected;
   except
      on e:Exception do
         MessageDlg('Erro ao connectar Banco de Dados. Mensagem: '+e.Message,mtInformation,[mbOK],0);
   end;
end;

procedure TInicio_form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   dm3.conexao.Connected := false;
end;

procedure TInicio_form.FormCreate(Sender: TObject);
begin
   if not conectar then
      Application.Terminate;
end;

end.
