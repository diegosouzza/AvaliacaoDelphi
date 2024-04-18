program AvaliacaoDelphi;

uses
  Vcl.Forms,
  inicio in 'inicio.pas' {Inicio_form},
  Vcl.Themes,
  Vcl.Styles,
  grid in 'grid.pas' {grid_form},
  data_module3 in 'data_module3.pas' {dm3: TDataModule},
  cadastro in 'cadastro.pas' {cadastro_form},
  pessoas_fisicas in 'pessoas_fisicas.pas' {pessoas_fisicas_form},
  pessoas_fisicas_cad in 'pessoas_fisicas_cad.pas' {pessoas_fisicas_cad_for},
  pessoas_juridicas in 'pessoas_juridicas.pas' {pessoas_juridicas_form},
  pessoas_juridicas_cad in 'pessoas_juridicas_cad.pas' {pessoas_juridicas_cad_form},
  pessoas_juridicas_endereco in 'pessoas_juridicas_endereco.pas' {pessoas_juridicas_endereco_form},
  pessoas_juridicas_contato in 'pessoas_juridicas_contato.pas' {pessoas_juridicas_contato_form},
  pessoas_juridicas_pf in 'pessoas_juridicas_pf.pas' {pessoas_juridicas_pf_form},
  pessoas_juridicas_vinc in 'pessoas_juridicas_vinc.pas' {pessoas_juridicas_vinc_form},
  pessoas_fisicas_relatorio in 'pessoas_fisicas_relatorio.pas' {pessoas_fisicas_relatorio_form},
  pessoas_juridicas_relatorio in 'pessoas_juridicas_relatorio.pas' {pessoas_juridicas_relatorio_form};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm3, dm3);
  Application.CreateForm(TInicio_form, Inicio_form);
  Application.Run;
end.
