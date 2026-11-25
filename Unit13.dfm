object dmBanco: TdmBanco
  Height = 633
  Width = 1002
  object conBanco: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'Server=127.0.0.1'
      'Port=5432'
      'Database=nexus_gaming_atualizado'
      'User_Name=postgres'
      'Password=aluno')
    ConnectedStoredUsage = [auRunTime]
    LoginPrompt = False
    Left = 232
    Top = 208
  end
  object qryProdutos: TFDQuery
    Connection = conBanco
    SQL.Strings = (
      'SELECT id_produto, nome, preco_venda'
      'FROM produtos'
      'WHERE LOWER(nome) LIKE '#39'%teclado%'#39
      'ORDER BY id_produto;')
    Left = 384
    Top = 320
  end
  object dsProdutos: TDataSource
    DataSet = qryProdutos
    Left = 416
    Top = 208
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\caina\Downloads\postgresql-16.16-2-windows-x64-binaries' +
      '\pgsql\pgAdmin 4\runtime\libpq.dll'
    Left = 192
    Top = 304
  end
end
