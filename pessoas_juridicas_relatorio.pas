unit pessoas_juridicas_relatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  Tpessoas_juridicas_relatorio_form = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData2: TQRSysData;
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
    qr_cnpj: TQRDBText;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    procedure FormCreate(Sender: TObject);
    procedure QRBand3AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
  private
    zebrado: boolean;
  public
    { Public declarations }
  end;

var
  pessoas_juridicas_relatorio_form: Tpessoas_juridicas_relatorio_form;

implementation

{$R *.dfm}

uses pessoas_juridicas;

procedure Tpessoas_juridicas_relatorio_form.FormCreate(Sender: TObject);
begin
   Self.Width := 0;
   Self.Height := 0;
   zebrado := false;

   QuickRep1.DataSet := pessoas_juridicas_form.query;

   qr_sequencial.DataSet := pessoas_juridicas_form.query;
   qr_nome.DataSet       := pessoas_juridicas_form.query;
   qr_cnpj.DataSet       := pessoas_juridicas_form.query;

   qr_sequencial.DataField := 'sequencial';
   qr_nome.DataField       := 'nome';
   qr_cnpj.DataField       := 'cnpj';

   QuickRep1.Preview;
end;

procedure Tpessoas_juridicas_relatorio_form.QRBand3AfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
    if zebrado then
      QRBand3.color := $00F2F2FF
   else
      QRBand3.color := clWhite;

   zebrado := not zebrado;
end;

end.
