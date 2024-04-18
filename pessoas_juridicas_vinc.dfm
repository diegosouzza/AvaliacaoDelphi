inherited pessoas_juridicas_vinc_form: Tpessoas_juridicas_vinc_form
  Caption = 'Pessoas Juridicas - Vincular Pessoas Juridicas'
  ClientHeight = 134
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitHeight = 164
  PixelsPerInch = 101
  TextHeight = 13
  inherited GroupBox1: TGroupBox
    Width = 439
    Height = 89
    ExplicitWidth = 439
    ExplicitHeight = 89
    inherited Label1: TLabel
      Top = 45
      Width = 122
      Caption = 'Pessoa Jur'#237'dica a Vincular'
      ExplicitTop = 45
      ExplicitWidth = 122
    end
    inherited bt_pesquisar: TSpeedButton
      Left = -90
      Top = 59
      ExplicitLeft = -90
      ExplicitTop = 59
    end
    object Label2: TLabel [2]
      Tag = 1
      Left = 12
      Top = 3
      Width = 127
      Height = 13
      Caption = 'Sequencial Pessoa Jur'#237'dica'
      Enabled = False
    end
    object Label3: TLabel [3]
      Left = 148
      Top = 3
      Width = 27
      Height = 13
      Caption = 'Nome'
      Enabled = False
    end
    object Label4: TLabel [4]
      Left = 148
      Top = 45
      Width = 27
      Height = 13
      Caption = 'Nome'
      Enabled = False
    end
    inherited ed_chave: TMaskEdit
      Top = 60
      Width = 131
      ExplicitTop = 60
      ExplicitWidth = 131
    end
    object ed_sequencial_pessoa_juridica: TMaskEdit
      Tag = 1
      Left = 8
      Top = 18
      Width = 131
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '1|3|sequencial_pessoa_juridica'
      Enabled = False
      EditMask = '!99999;9;'
      MaxLength = 5
      TabOrder = 1
      Text = '     '
    end
    object ed_nome_pj: TEdit
      Left = 145
      Top = 18
      Width = 286
      Height = 21
      Enabled = False
      TabOrder = 2
    end
    object ed_nome_pjv: TEdit
      Left = 145
      Top = 60
      Width = 283
      Height = 21
      Enabled = False
      TabOrder = 3
    end
  end
  inherited bt_salvar: TButton
    Top = 103
    ExplicitTop = 103
  end
  inherited bt_cancelar: TButton
    Top = 103
    ExplicitTop = 103
  end
end
