unit UnConsultaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons;

type
  TfrmConsultaCliente = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edCodCliente: TEdit;
    edNomeCliente: TEdit;
    edCidade: TEdit;
    Panel2: TPanel;
    GradeConsulta: TDBGrid;
    edUF: TEdit;
    Label4: TLabel;
    btFiltrar: TBitBtn;
    btSelecionar: TBitBtn;
    btSair: TBitBtn;
    sqlCliente: TFDQuery;
    sqlClienteCLIENTE_CODIGO: TFDAutoIncField;
    sqlClienteCLIENTE_NOME: TStringField;
    sqlClienteCLIENTE_CIDADE: TStringField;
    sqlClienteCLIENTE_UF: TStringField;
    dsConsulta: TDataSource;
    procedure btFiltrarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GradeConsultaDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btSelecionarClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FCodigoClienteSelecionado: String;
    function fFitroSQLCodCliente: String;
    function fFitroSQLNomeCliente: String;
    function fFitroSQLCidade: String;
    function fFitroSQLUF: String;
    { Private declarations }
  public
    { Public declarations }
    property CodigoClienteSelecionado: String read FCodigoClienteSelecionado;
  end;

var
  frmConsultaCliente: TfrmConsultaCliente;

implementation

{$R *.dfm}

procedure TfrmConsultaCliente.btFiltrarClick(Sender: TObject);
begin
  sqlCliente.Close;
  sqlCliente.SQL.Text :=  ' SELECT             '+
                          ' CLIENTE_CODIGO,    '+
                          ' CLIENTE_NOME,      '+
                          ' CLIENTE_CIDADE,    '+
                          ' CLIENTE_UF         '+
                          ' FROM CLIENTE       '+
                          ' WHERE              '+
                          fFitroSQLCodCliente   +
                          fFitroSQLNomeCliente  +
                          fFitroSQLCidade       +
                          fFitroSQLUF;
    sqlCliente.Open;

    if sqlCliente.IsEmpty then
      ShowMessage('Cliente n�o encontrado');
end;

function TfrmConsultaCliente.fFitroSQLCodCliente : String;
var
  vSQLAndCodCli : String;
begin
  vSQLAndCodCli := '';

  if edCodCliente.Text <> '' then
    vSQLAndCodCli := ' CLIENTE_CODIGO = ' + Trim(edCodCliente.Text)
  else
    vSQLAndCodCli := 'CLIENTE_CODIGO IS NOT NULL';

  Result := vSQLAndCodCli;
end;

function TfrmConsultaCliente.fFitroSQLNomeCliente : String;
var
  vSQLAndNomeCli : String;
begin
  vSQLAndNomeCli := '';

  if edNomeCliente.Text <> '' then
    vSQLAndNomeCli := ' CLIENTE_NOME = ' + Trim(edNomeCliente.Text)
  else
    vSQLAndNomeCli := '';

  Result := vSQLAndNomeCli;
end;

procedure TfrmConsultaCliente.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultaCliente.btSelecionarClick(Sender: TObject);
begin
  FCodigoClienteSelecionado := sqlClienteCLIENTE_CODIGO.AsString;
  if FCodigoClienteSelecionado = '' then
  begin
    ShowMessage('Nenhum cliente selecionado!');
    Abort;
  end;
  ModalResult := mrOK;
end;

procedure TfrmConsultaCliente.GradeConsultaDblClick(Sender: TObject);
begin
  if not sqlCliente.IsEmpty then
    btSelecionar.Click;
end;

procedure TfrmConsultaCliente.GradeConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    GradeConsultaDblClick(Self);
end;

function TfrmConsultaCliente.fFitroSQLCidade : String;
var
  vSQLAndCidade : String;
begin
  vSQLAndCidade := '';

  if edCidade.Text <> '' then
    vSQLAndCidade := ' CLIENTE_CIDADE = ' + Trim(edCidade.Text)
  else
    vSQLAndCidade := '';

  Result := vSQLAndCidade;
end;

function TfrmConsultaCliente.fFitroSQLUF : String;
var
  vSQLAndUF : String;
begin
  vSQLAndUF := '';

  if edUF.Text <> '' then
    vSQLAndUF := ' CLIENTE_UF = ' + Trim(edUF.Text)
  else
    vSQLAndUF := '';

  Result := vSQLAndUF;
end;

procedure TfrmConsultaCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmConsultaCliente := nil;
end;

procedure TfrmConsultaCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F10 then
    btFiltrar.Click;

  if Key = VK_F12 then
    btSelecionar.Click;

  if Key = VK_ESCAPE then
    btSair.Click;
end;

procedure TfrmConsultaCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then //Faz o enter ter fun��o de TAB
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmConsultaCliente.FormShow(Sender: TObject);
begin
  btFiltrarClick(Self);
end;

end.
