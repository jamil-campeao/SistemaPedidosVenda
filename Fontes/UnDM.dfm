object DM: TDM
  OnCreate = DataModuleCreate
  Height = 398
  Width = 742
  object ConexaoDB: TFDConnection
    Params.Strings = (
      'Database=sistema'
      'User_Name=root'
      'Password=Admin100%'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 96
    Top = 80
  end
  object mysqlLink: TFDPhysMySQLDriverLink
    DriverID = 'MySQL'
    Left = 504
    Top = 64
  end
  object waitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 600
    Top = 112
  end
  object sqlPedido: TFDQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'SELECT * FROM PEDIDOS'
      'WHERE PEDIDO_NUMERO = :PEDIDO_NUMERO')
    Left = 184
    Top = 160
    ParamData = <
      item
        Position = 1
        Name = 'PEDIDO_NUMERO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object sqlPedidoPEDIDO_NUMERO: TIntegerField
      FieldName = 'PEDIDO_NUMERO'
    end
    object sqlPedidoCLIENTE_CODIGO: TIntegerField
      FieldName = 'CLIENTE_CODIGO'
    end
    object sqlPedidoPEDIDO_DATAEMISSAO: TDateField
      FieldName = 'PEDIDO_DATAEMISSAO'
    end
    object sqlPedidoPEDIDO_VALORTOTAL: TBCDField
      FieldName = 'PEDIDO_VALORTOTAL'
      DisplayFormat = '0.00'
      currency = True
      Precision = 15
      Size = 2
    end
  end
end
