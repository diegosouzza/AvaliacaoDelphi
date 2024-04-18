inherited pessoas_juridicas_form: Tpessoas_juridicas_form
  Caption = 'Pessoas Jur'#237'dicas'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 101
  TextHeight = 13
  inherited Panel1: TPanel
    inherited bt_incluir: TSpeedButton
      OnClick = bt_incluirClick
    end
    inherited bt_alterar: TSpeedButton
      OnClick = bt_alterarClick
    end
    inherited bt_deletar: TSpeedButton
      OnClick = bt_deletarClick
    end
    inherited bt_listar: TSpeedButton
      OnClick = bt_listarClick
    end
  end
  inherited GroupBox1: TGroupBox
    inherited grid: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'sequencial'
          Title.Alignment = taCenter
          Title.Caption = 'Sequencial'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Alignment = taCenter
          Title.Caption = 'Nome'
          Width = 220
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cnpj'
          Title.Alignment = taCenter
          Title.Caption = 'CNPJ'
          Width = 120
          Visible = True
        end>
    end
  end
end
