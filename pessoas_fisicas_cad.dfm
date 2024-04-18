inherited pessoas_fisicas_cad_for: Tpessoas_fisicas_cad_for
  Caption = 'Pessoas Fisicas'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 101
  TextHeight = 13
  inherited GroupBox1: TGroupBox
    inherited ed_chave: TMaskEdit
      HelpType = htKeyword
      HelpKeyword = '1|3|SEQUENCIAL'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 63
    Width = 439
    Height = 108
    HelpType = htKeyword
    HelpKeyword = 'pessoas_fisicas'
    TabOrder = 3
    object Label2: TLabel
      Left = 12
      Top = 3
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 198
      Top = 3
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object ed_nome: TMaskEdit
      Left = 8
      Top = 18
      Width = 180
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|NOME'
      MaxLength = 80
      TabOrder = 0
      Text = ''
      OnExit = ed_nomeExit
    end
    object ed_cpf: TMaskEdit
      Left = 194
      Top = 18
      Width = 95
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|CPF'
      EditMask = '000\.000\.000\-00;0;_'
      MaxLength = 14
      TabOrder = 1
      Text = ''
      OnExit = ed_cpfExit
    end
  end
end
