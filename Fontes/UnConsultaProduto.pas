unit UnConsultaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons;

type
  TfrmConsultaProduto = class(TForm)
    Panel1: TPanel;
    edCodProduto: TEdit;
    Label1: TLabel;
    edNomeProduto: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edValorVenda: TEdit;
    Panel2: TPanel;
    sqlProduto: TFDQuery;
    dsConsulta: TDataSource;
    GradeConsulta: TDBGrid;
    sqlProdutoPRODUTO_CODIGO: TFDAutoIncField;
    sqlProdutoPRODUTO_DESCRICAO: TStringField;
    sqlProdutoPRODUTO_PRECOVENDA: TBCDField;
    btFiltrar: TBitBtn;
    btSair: TBitBtn;
    btSelecionar: TBitBtn;
    procedure btFiltrarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeConsultaDblClick(Sender: TObject);
    procedure btSelecionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GradeConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edValorVendaKeyPress(Sender: TObject; var Key: Char);
  private
    FCodigoProdutoSelecionado: String;
    function fFitroSQLCodProduto: String;
    function fFitroSQLNomeProduto: String;
    function fFitroSQLValorVenda: String;
    { Private declarations }
  public
    { Public declarations }
    property CodigoProdutoSelecionado: String read FCodigoProdutoSelecionado;
  end;

var
  frmConsultaProduto: TfrmConsultaProduto;

implementation

{$R *.dfm}

uses UnDM, UnFuncoes;

procedure TfrmConsultaProduto.btFiltrarClick(Sender: TObject);
begin
  sqlProduto.Close;
  sqlProduto.SQL.Text :=  ' SELECT             '+
                          ' PRODUTO_CODIGO,    '+
                          ' PRODUTO_DESCRICAO, '+
                          ' PRODUTO_PRECOVENDA '+
                          ' FROM PRODUTO       '+
                          ' WHERE              '+
                          fFitroSQLCodProduto   +
                          fFitroSQLNomeProduto  +
                          fFitroSQLValorVenda;
    sqlProduto.Open;

    if sqlProduto.IsEmpty then
      ShowMessage('Produto n�o encontrado');
end;

procedure TfrmConsultaProduto.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultaProduto.btSelecionarClick(Sender: TObject);
begin
  FCodigoProdutoSelecionado := sqlProdutoPRODUTO_CODIGO.AsString;
  if FCodigoProdutoSelecionado = '' then
  begin
    ShowMessage('Nenhum produto selecionado!');
    Abort;
  end;
  ModalResult := mrOK;
end;

procedure TfrmConsultaProduto.edValorVendaKeyPress(Sender: TObject;
  var Key: Char);
begin
  TFuncao.Numero.DigitarComPonto(Key);
end;

procedure TfrmConsultaProduto.GradeConsultaDblClick(Sender: TObject);
begin
  if not sqlProduto.IsEmpty then
    btSelecionarClick(Self);
end;

procedure TfrmConsultaProduto.GradeConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    GradeConsultaDblClick(Self);
end;

function TfrmConsultaProduto.fFitroSQLCodProduto : String;
var
  vSQLAndCodProd : String;
begin
  vSQLAndCodProd := '';

  if edCodProduto.Text <> '' then
    vSQLAndCodProd := ' PRODUTO_CODIGO = ' + Trim(edCodProduto.Text)
  else
    vSQLAndCodProd := 'PRODUTO_CODIGO IS NOT NULL';

  Result := vSQLAndCodProd;
end;

function TfrmConsultaProduto.fFitroSQLNomeProduto : String;
var
  vSQLAndNomeProd : String;
begin
  vSQLAndNomeProd := '';

  if edNomeProduto.Text <> '' then
    vSQLAndNomeProd := ' AND PRODUTO_DESCRICAO LIKE ' + '''%'+ Trim(edNomeProduto.Text) + '%''';

  Result := vSQLAndNomeProd;
end;

function TfrmConsultaProduto.fFitroSQLValorVenda : String;
var
  vSQLAndValorVenda : String;
begin
  vSQLAndValorVenda := '';

  if edValorVenda.Text <> '' then
    vSQLAndValorVenda := ' AND PRODUTO_PRECOVENDA = ' +  Trim(edValorVenda.Text);

  Result := vSQLAndValorVenda;
end;

procedure TfrmConsultaProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmConsultaProduto := nil;
end;

procedure TfrmConsultaProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F10 then
    btFiltrar.Click;

  if Key = VK_F12 then
    btSelecionar.Click;

  if Key = VK_ESCAPE then
    btSair.Click;

end;

procedure TfrmConsultaProduto.FormShow(Sender: TObject);
begin
  btFiltrarClick(Self);
end;

end.
