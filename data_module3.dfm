object dm3: Tdm3
  OldCreateOrder = False
  Height = 150
  Width = 215
  object conexao: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 16
    Top = 24
  end
  object transacao: TFDTransaction
    Options.DisconnectAction = xdNone
    Connection = conexao
    Left = 136
    Top = 24
  end
  object driver: TFDPhysFBDriverLink
    Left = 96
    Top = 24
  end
  object query: TFDQuery
    Connection = conexao
    FetchOptions.AssignedValues = [evRecordCountMode]
    FetchOptions.RecordCountMode = cmTotal
    Left = 56
    Top = 24
  end
  object dataset: TFDQuery
    Connection = conexao
    Left = 176
    Top = 24
  end
end
