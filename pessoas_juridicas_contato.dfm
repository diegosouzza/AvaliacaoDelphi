inherited pessoas_juridicas_contato_form: Tpessoas_juridicas_contato_form
  Caption = 'Pessoas Jur'#237'dicas - Contato'
  ClientWidth = 378
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 384
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
    Left = 214
    ExplicitLeft = 214
  end
  inherited bt_cancelar: TButton
    Left = 295
    ExplicitLeft = 295
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 63
    Width = 362
    Height = 108
    HelpType = htKeyword
    HelpKeyword = 'pessoas_juridicas_contatos'
    TabOrder = 3
    object Label2: TLabel
      Left = 12
      Top = 3
      Width = 27
      Height = 13
      HelpType = htKeyword
      Caption = 'Nome'
    end
    object Label6: TLabel
      Left = 259
      Top = 3
      Width = 42
      Height = 13
      Caption = 'Telefone'
    end
    object Label3: TLabel
      Left = 159
      Top = 3
      Width = 33
      Height = 13
      Caption = 'Celular'
    end
    object Label4: TLabel
      Left = 12
      Top = 45
      Width = 24
      Height = 13
      HelpType = htKeyword
      Caption = 'Email'
    end
    object ed_nome: TEdit
      Left = 8
      Top = 18
      Width = 141
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|nome'
      MaxLength = 40
      TabOrder = 0
      OnExit = ed_nomeExit
    end
    object ed_telefone: TMaskEdit
      Left = 255
      Top = 18
      Width = 98
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|telefone'
      EditMask = '\(99\)9999-9999;9;'
      MaxLength = 13
      TabOrder = 2
      Text = '(  )    -    '
    end
    object ed_celular: TMaskEdit
      Left = 155
      Top = 18
      Width = 94
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|celular'
      EditMask = '\(99\)99999-9999;9;'
      MaxLength = 14
      TabOrder = 1
      Text = '(  )     -    '
      OnExit = ed_celularExit
    end
    object ed_email: TEdit
      Left = 8
      Top = 60
      Width = 241
      Height = 21
      HelpType = htKeyword
      HelpKeyword = '2|1|email'
      MaxLength = 40
      TabOrder = 3
      OnExit = ed_emailExit
    end
  end
end
