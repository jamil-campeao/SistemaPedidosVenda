unit UnFuncoesBancoDados;

interface

uses
  FireDAC.Comp.Client, System.SysUtils;

type
  TConfigBancoDados = record
    Conexao: TFDConnection;
  end;

  TConfiguracao = class
    strict private
      class var vBancoDados: TConfigBancoDados;
      class function GetBancoDados: TConfigBancoDados; static;
    public
      class property BancoDados: TConfigBancoDados read GetBancoDados;
      class function ProximoRegistro(const cNomeTabela, sNomeCampo: string): Integer;
  end;

implementation

uses
  UnDM;

{ TConfiguracao }

class function TConfiguracao.GetBancoDados: TConfigBancoDados;
begin
  // Inicializa a conex�o sob demanda, caso ainda n�o esteja configurada
  if vBancoDados.Conexao = nil then
    vBancoDados.Conexao := Dm.ConexaoDB;

  Result := vBancoDados;
end;

class function TConfiguracao.ProximoRegistro(const cNomeTabela, sNomeCampo: string): Integer;
var
  vSQLQuery: TFDQuery;
  vSQL: string;
begin
  vSQLQuery := TFDQuery.Create(nil);
  try
    vSQLQuery.Connection := BancoDados.Conexao;

    vSQL := Format('SELECT MAX(%s) AS MaxValor FROM %s', [sNomeCampo, cNomeTabela]);
    vSQLQuery.SQL.Text := vSQL;
    vSQLQuery.Open;

    // Verifica se o campo MAX(<NomeCampo>) retornou nulo
    if vSQLQuery.FieldByName('MaxValor').IsNull then
      Result := 1 // Primeiro registro se ainda n�o houver nenhum
    else
      Result := vSQLQuery.FieldByName('MaxValor').AsInteger + 1;

  finally
    FreeAndNil(vSQLQuery);
  end;
end;

end.

