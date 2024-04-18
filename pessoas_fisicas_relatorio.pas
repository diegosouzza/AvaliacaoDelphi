unit pessoas_fisicas_relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  Tpessoas_fisicas_relatorio_form = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRBand3: TQRBand;
    qr_sequencial: TQRDBText;
    qr_nome: TQRDBText;
    qr_cpf: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    procedure QRBand3AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    zebrado: boolean;
  public
    { Public declarations }
  end;

var
  pessoas_fisicas_relatorio_form: Tpessoas_fisicas_relatorio_form;

implementation

{$R *.dfm}

uses pessoas_fisicas;

procedure Tpessoas_fisicas_relatorio_form.FormCreate(Sender: TObject);
begin
   Self.Width := 0;
   Self.Height := 0;

   QuickRep1.DataSet := pessoas_fisicas_form.query;

   qr_sequencial.DataSet := pessoas_fisicas_form.query;
   qr_nome.DataSet       := pessoas_fisicas_form.query;
   qr_cpf.DataSet        := pessoas_fisicas_form.query;

   qr_sequencial.DataField := 'sequencial';
   qr_nome.DataField       := 'nome';
   qr_cpf.DataField        := 'cnpj';

   QuickRep1.Preview;
end;

procedure Tpessoas_fisicas_relatorio_form.QRBand3AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
   if zebrado then
      QRBand3.color := $00F4FFF0
   else
      QRBand3.color := clWhite;

   zebrado := not zebrado;
end;

end.
