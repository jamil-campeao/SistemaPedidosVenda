unit UnDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Forms, System.IniFiles, Vcl.Dialogs,
  System.IOUtils;

type
  TDM = class(TDataModule)
    ConexaoDB: TFDConnection;
    mysqlLink: TFDPhysMySQLDriverLink;
    waitCursor: TFDGUIxWaitCursor;
    sqlPedido: TFDQuery;
    sqlPedidoPEDIDO_NUMERO: TIntegerField;
    sqlPedidoCLIENTE_CODIGO: TIntegerField;
    sqlPedidoPEDIDO_DATAEMISSAO: TDateField;
    sqlPedidoPEDIDO_VALORTOTAL: TBCDField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  vServer, vUser, vSenha, vLIB, vDatabase, vIniPath: String;
  vPorta: Integer;
  vCONF: TIniFile;
begin
  // Define o caminho do arquivo .ini no diret�rio do execut�vel
  vIniPath := ExtractFilePath(Application.ExeName) + 'conf.ini';

  {$REGION 'CRIA INI'}
  if not FileExists(vIniPath) then
  begin
    vCONF := TIniFile.Create(vIniPath);
    try
      vCONF.WriteString('banco', 'server', 'localhost');
      vCONF.WriteString('banco', 'user', 'root');
      vCONF.WriteString('banco', 'senha', 'Admin100%');
      vCONF.WriteInteger('banco', 'porta', 3306);
      vCONF.WriteString('banco', 'database', 'sistema');
      vCONF.WriteString('banco', 'dll_path', ExtractFilePath(Application.ExeName) + 'libmysql.dll');
      ShowMessage('Arquivo conf.ini criado com valores padr�o no diret�rio: ' + vIniPath);
    finally
      vCONF.Free;
    end;
  end;
  {$ENDREGION}

  {$REGION 'L� O INI'}
  vCONF := TIniFile.Create(vIniPath);
  try
    vLIB     := vCONF.ReadString('banco', 'dll_path', ExtractFilePath(Application.ExeName) + '');
    vServer  := vCONF.ReadString('banco', 'server', '');
    vUser    := vCONF.ReadString('banco', 'user', '');
    vSenha   := vCONF.ReadString('banco', 'senha', '');
    vPorta   := vCONF.ReadInteger('banco', 'porta', 0);
    vDatabase := vCONF.ReadString('banco', 'database', '');

    // Verifica se o nome do banco de dados foi carregado
    if vDatabase = '' then
    begin
      ShowMessage('Erro: Nome do banco de dados n�o encontrado no arquivo conf.ini.');
      Exit;
    end;
  finally
    vCONF.Free;
  end;
  {$ENDREGION}


  {$REGION 'VALIDA��ES'}
  // Verifica se o arquivo da biblioteca MySQL est� presente
  if not FileExists(vLIB) then
  begin
    ShowMessage('Erro: A biblioteca libmysql.dll n�o foi encontrada no diret�rio especificado: ' + vLIB);
    Exit;
  end;
  {$ENDREGION}

  {$REGION 'CONFIGURA��ES E CONEX�O'}
  try
    mysqlLink.DriverID := 'MySQL';
    mysqlLink.VendorLib := vLIB;

    ConexaoDB.Params.Clear;
    ConexaoDB.Params.DriverID             := 'MySQL';
    ConexaoDB.DriverName                  := 'MySQL';
    ConexaoDB.Params.Values['Server']     := vServer;
    ConexaoDB.Params.Values['User_Name']  := vUser;
    ConexaoDB.Params.Values['Password']   := vSenha;
    ConexaoDB.Params.Values['Port']       := IntToStr(vPorta);
    ConexaoDB.Params.Values['Database']   := vDatabase;

    ConexaoDB.Connected := True;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao conectar ao banco de dados: ' + E.Message);
      Application.Terminate;
    end;

  end;

  {$ENDREGION}
end;


end.
