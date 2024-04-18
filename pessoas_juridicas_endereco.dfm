inherited pessoas_juridicas_endereco_form: Tpessoas_juridicas_endereco_form
  Caption = 'Pessoas Juridicas - Endere'#231'os'
  ClientHeight = 192
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitHeight = 222
  PixelsPerInch = 101
  TextHeight = 13
  inherited GroupBox1: TGroupBox
    inherited ed_chave: TMaskEdit
      HelpType = htKeyword
      HelpKeyword = '1|3|sequencial'
    end
    object ed_pessoa_juridica: TMaskEdit
      Tag = 1
      Left = 208
      Top = 18
      Width = 14
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '1|3|SEQUENCIAL_PESSOA_JURIDICA'
      TabStop = False
      Enabled = False
      EditMask = '!99999;9;'
      MaxLength = 5
      TabOrder = 1
      Text = '     '
      Visible = False
      OnExit = ed_chaveExit
      OnKeyDown = ed_chaveKeyDown
    end
  end
  inherited bt_salvar: TButton
    Top = 159
    ExplicitTop = 159
  end
  inherited bt_cancelar: TButton
    Top = 159
    ExplicitTop = 159
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 63
    Width = 439
    Height = 90
    HelpType = htKeyword
    HelpKeyword = 'pessoas_juridicas_enderecos'
    TabOrder = 3
    object Logradouro: TLabel
      Left = 12
      Top = 3
      Width = 55
      Height = 13
      HelpType = htKeyword
      HelpKeyword = '2|1|logradouro'
      Caption = 'Logradouro'
    end
    object Label2: TLabel
      Left = 238
      Top = 3
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object Label3: TLabel
      Left = 294
      Top = 3
      Width = 28
      Height = 13
      HelpType = htKeyword
      Caption = 'Bairro'
    end
    object Label4: TLabel
      Left = 12
      Top = 45
      Width = 33
      Height = 13
      HelpType = htKeyword
      Caption = 'Cidade'
    end
    object Label5: TLabel
      Left = 158
      Top = 45
      Width = 13
      Height = 13
      HelpType = htKeyword
      Caption = 'UF'
    end
    object Label6: TLabel
      Left = 205
      Top = 45
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object Label7: TLabel
      Left = 294
      Top = 45
      Width = 65
      Height = 13
      HelpType = htKeyword
      Caption = 'Complemento'
    end
    object ed_logradouro: TEdit
      Left = 8
      Top = 18
      Width = 220
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|logradouro'
      MaxLength = 100
      TabOrder = 0
      OnExit = ed_logradouroExit
    end
    object ed_numero: TMaskEdit
      Left = 234
      Top = 18
      Width = 50
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|3|numero'
      EditMask = '!99999;9;'
      MaxLength = 5
      TabOrder = 1
      Text = '     '
    end
    object ed_bairro: TEdit
      Left = 290
      Top = 18
      Width = 141
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|bairro'
      MaxLength = 90
      TabOrder = 2
      OnExit = ed_bairroExit
    end
    object ed_cidade: TEdit
      Left = 8
      Top = 60
      Width = 141
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|cidade'
      MaxLength = 80
      TabOrder = 3
      OnExit = ed_cidadeExit
    end
    object ed_uf: TComboBox
      Left = 155
      Top = 60
      Width = 40
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|uf'
      Style = csOwnerDrawFixed
      ItemHeight = 15
      TabOrder = 4
      OnExit = ed_ufExit
      Items.Strings = (
        'AC'
        'AL'
        'AP'
        'AM'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MT'
        'MS'
        'MG'
        'PA'
        'PB'
        'PR'
        'PE'
        'PI'
        'RJ'
        'RN'
        'RS'
        'RO'
        'RR'
        'SC'
        'SP'
        'SE'
        'TO'
        '')
    end
    object ed_cep: TMaskEdit
      Left = 201
      Top = 60
      Width = 79
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|cep'
      EditMask = '99\.999\-999;0'
      MaxLength = 10
      TabOrder = 5
      Text = ''
      OnExit = ed_cepExit
    end
    object ed_complemento: TEdit
      Left = 290
      Top = 60
      Width = 141
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|complemento'
      MaxLength = 80
      TabOrder = 6
    end
  end
end
