inherited pessoas_fisicas_form: Tpessoas_fisicas_form
  Caption = 'Pessoas F'#237'sicas'
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
          FieldName = 'cpf'
          Title.Alignment = taCenter
          Title.Caption = 'CPF'
          Width = 120
          Visible = True
        end>
    end
  end
end
