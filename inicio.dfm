object Inicio_form: TInicio_form
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Pessoas'
  ClientHeight = 388
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 101
  TextHeight = 13
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 682
    Height = 27
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Spacing = 0
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = act_cad_pessoas_fisicas
              end
              item
                Action = act_cad_pessoas_juridicas
              end>
            Caption = '&Arquivos'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Left = 128
    Top = 64
    StyleName = 'Platform Default'
    object act_cad_pessoas_fisicas: TAction
      Category = 'Arquivo'
      Caption = 'Pessoas &F'#237'sicas'
      OnExecute = act_cad_pessoas_fisicasExecute
    end
    object act_cad_pessoas_juridicas: TAction
      Category = 'Arquivo'
      Caption = 'Pessoas &Jur'#237'dicas'
      OnExecute = act_cad_pessoas_juridicasExecute
    end
  end
end
