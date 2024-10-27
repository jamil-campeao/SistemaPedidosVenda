unit UnConsultaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmConsultaPedido = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edCodPedido: TEdit;
    btFiltrar: TBitBtn;
    GradeConsulta: TDBGrid;
    Panel2: TPanel;
    btSelecionar: TBitBtn;
    btSair: TBitBtn;
    sqlConsultaPedido: TFDQuery;
    dsConsulta: TDataSource;
    sqlConsultaPedidoPEDIDO_NUMERO: TIntegerField;
    sqlConsultaPedidoCLIENTE_CODIGO: TIntegerField;
    sqlConsultaPedidoCLIENTE_NOME: TStringField;
    sqlConsultaPedidoPEDIDO_DATAEMISSAO: TDateField;
    sqlConsultaPedidoPEDIDO_VALORTOTAL: TBCDField;
    procedure btFiltrarClick(Sender: TObject);
    procedure GradeConsultaDblClick(Sender: TObject);
    procedure btSelecionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GradeConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  FCodigoPedidoSelecionado  : String;
  FCodigoClienteSelecionado : String;
    function fFitroSQLCodPedido: String;
    { Private declarations }
  public
    { Public declarations }
    property CodigoPedidoSelecionado : String read FCodigoPedidoSelecionado;
    property CodigoClienteSelecionado: String read FCodigoClienteSelecionado;
  end;

var
  frmConsultaPedido: TfrmConsultaPedido;

implementation

uses
 UnDM;

{$R *.dfm}

procedure TfrmConsultaPedido.btFiltrarClick(Sender: TObject);
begin
  sqlConsultaPedido.Close;
  sqlConsultaPedido.SQL.Text := ' SELECT                                                      '+
                                ' P.PEDIDO_NUMERO,                                            '+
                                ' P.CLIENTE_CODIGO,                                           '+
                                ' C.CLIENTE_NOME,                                             '+
                                ' P.PEDIDO_DATAEMISSAO,                                       '+
                                ' P.PEDIDO_VALORTOTAL                                         '+
                                ' FROM PEDIDOS P                                              '+
                                ' INNER JOIN CLIENTE C ON C.CLIENTE_CODIGO = P.CLIENTE_CODIGO '+
                                ' WHERE                                                       '+
                                fFitroSQLCodPedido;
  sqlConsultaPedido.Open;

  if sqlConsultaPedido.IsEmpty then
    ShowMessage('Pedido n�o encontrado!');

end;

procedure TfrmConsultaPedido.btSelecionarClick(Sender: TObject);
begin
  FCodigoPedidoSelecionado  := sqlConsultaPedidoPEDIDO_NUMERO.AsString;
  FCodigoClienteSelecionado := sqlConsultaPedidoCLIENTE_CODIGO.AsString;
  if FCodigoPedidoSelecionado = '' then
  begin
    ShowMessage('Nenhum pedido selecionado!');
    Abort;
  end;
  ModalResult := mrOK;
end;

procedure TfrmConsultaPedido.GradeConsultaDblClick(Sender: TObject);
begin
  if not sqlConsultaPedido.IsEmpty then
    btSelecionar.Click;
end;

procedure TfrmConsultaPedido.GradeConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    GradeConsultaDblClick(Self);
end;

function TfrmConsultaPedido.fFitroSQLCodPedido : String;
var
  vSQLAndCodPedido : String;
begin
  vSQLAndCodPedido := '';

  if edCodPedido.Text <> '' then
    vSQLAndCodPedido := ' PEDIDO_NUMERO = ' + Trim(edCodPedido.Text)
  else
    vSQLAndCodPedido := ' PEDIDO_NUMERO IS NOT NULL';

  Result := vSQLAndCodPedido;
end;

procedure TfrmConsultaPedido.FormShow(Sender: TObject);
begin
  btFiltrarClick(Self);
end;

end.
