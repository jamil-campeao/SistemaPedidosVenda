unit UnInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids, Datasnap.Provider, Math,
  Vcl.Buttons;

type
  TfrmInicial = class(TForm)
    Panel2: TPanel;
    tbControlGeral: TTabControl;
    pnlCliente: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblCidade: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edCodCliente: TEdit;
    GradeProdutos: TDBGrid;
    Label10: TLabel;
    sqlCliente: TFDQuery;
    dsCliente: TDataSource;
    sqlClienteCLIENTE_CODIGO: TFDAutoIncField;
    sqlClienteCLIENTE_NOME: TStringField;
    sqlClienteCLIENTE_CIDADE: TStringField;
    sqlClienteCLIENTE_UF: TStringField;
    edNomeCliente: TDBEdit;
    edCidade: TDBEdit;
    edUF: TDBEdit;
    sqlProduto: TFDQuery;
    sqlProdutoPRODUTO_CODIGO: TFDAutoIncField;
    sqlProdutoPRODUTO_DESCRICAO: TStringField;
    sqlProdutoPRODUTO_PRECOVENDA: TBCDField;
    dsProduto: TDataSource;
    pnlProduto: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dsPedidoProduto: TDataSource;
    sqlPedidoProduto: TFDQuery;
    sqlPedidoProdutoPEDIDO_CODIGOITEM: TFDAutoIncField;
    sqlPedidoProdutoPEDIDO_NUMERO: TIntegerField;
    sqlPedidoProdutoPRODUTO_CODIGO: TIntegerField;
    sqlPedidoProdutoPEDIDOPRODUTO_VLRUNIT: TBCDField;
    sqlPedidoProdutoPEDIDOPRODUTO_VLRTOTAL: TBCDField;
    Label12: TLabel;
    dsPedidoCabecalho: TDataSource;
    cdsPedidoProduto: TClientDataSet;
    cdsPedidoProdutoPEDIDO_NUMERO: TIntegerField;
    cdsPedidoProdutoPRODUTO_CODIGO: TIntegerField;
    cdsPedidoProdutoPEDIDOPRODUTO_VLRUNIT: TBCDField;
    cdsPedidoProdutoPEDIDOPRODUTO_VLRTOTAL: TBCDField;
    Label13: TLabel;
    dsLigacao: TDataSource;
    dspCabecalho: TDataSetProvider;
    cdsCabecalho: TClientDataSet;
    cdsCabecalhoPEDIDO_NUMERO: TIntegerField;
    cdsCabecalhoCLIENTE_CODIGO: TIntegerField;
    cdsCabecalhoPEDIDO_DATAEMISSAO: TDateField;
    cdsCabecalhoPEDIDO_VALORTOTAL: TBCDField;
    cdsCabecalhosqlPedidoProduto: TDataSetField;
    DBEdit1: TDBEdit;
    edNumeroPedido: TDBEdit;
    cdsPedidoProdutoPEDIDO_CODIGOITEM: TIntegerField;
    sqlPedidoProdutoPEDIDOPRODUTO_QUANT: TBCDField;
    cdsPedidoProdutoPEDIDOPRODUTO_QUANT: TBCDField;
    edQuantidade: TEdit;
    edTotalProduto: TEdit;
    edCodProd: TEdit;
    edPrecoVenda: TEdit;
    edNomeProduto: TEdit;
    sqlPedidoProdutoPRODUTO_DESCRICAO: TStringField;
    cdsPedidoProdutoPRODUTO_DESCRICAO: TStringField;
    Panel4: TPanel;
    Label11: TLabel;
    DBEdit2: TDBEdit;
    btIncluir: TBitBtn;
    btExcluir: TBitBtn;
    btIncluirPedido: TBitBtn;
    btGravar: TBitBtn;
    btSair: TBitBtn;
    btPesquisarCliente: TBitBtn;
    btPesquisarProduto: TBitBtn;
    btCarregarPedidos: TBitBtn;
    btExcluirPed: TBitBtn;
    procedure btSairClick(Sender: TObject);
    procedure btPesquisarClienteClick(Sender: TObject);
    procedure edCodClienteExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edCodProdExit(Sender: TObject);
    procedure edCodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPesquisarProdutoClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btIncluirPedidoClick(Sender: TObject);
    procedure GradeProdutosDblClick(Sender: TObject);
    procedure edQuantidadeExit(Sender: TObject);
    procedure edPrecoVendaExit(Sender: TObject);
    procedure edCodProdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edPrecoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure GradeProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsPedidoCabecalhoDataChange(Sender: TObject; Field: TField);
    procedure btCarregarPedidosClick(Sender: TObject);
    procedure btExcluirPedClick(Sender: TObject);
  private
    bEditando   : Boolean;
    bCancelando : Boolean;
    procedure ControlaBotoes(bBtIncluir, bBtExcluir: Boolean);
    procedure fValidacoesIncluirProduto;
    procedure fLimpaCamposProduto;
    procedure fAtualizarSubtotal;
    procedure fControlaTela(bBloqueiaTela: Boolean);
    procedure fLimpaCamposCliente;
    procedure fValidacoesGravar;
    procedure fCancelarPedido(const vPedidoNumero: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

  resourcestring
  sForm_Caption       = 'Pedido de Venda';
  sForm_CaptionCons   = 'Pedido de Venda';

var
  frmInicial: TfrmInicial;

implementation

{$R *.dfm}

uses UnDM, UnConsultaCliente, UnConsultaProduto, UnFuncoesBancoDados, UnFuncoes, UnConsultaPedido;

procedure TfrmInicial.btPesquisarProdutoClick(Sender: TObject);
var
  vFM : TfrmConsultaProduto;
begin
  vFM := TfrmConsultaProduto.Create(nil);
  try
    if vFM.ShowModal = mrOK then
    begin
      edCodProd.Text := vFm.CodigoProdutoSelecionado;
      if edCodProd.Text <> '' then
        edCodProdExit(Self);
    end;

  finally
    FreeAndNil(vFM);
  end;
end;

procedure TfrmInicial.btSairClick(Sender: TObject);
begin
   if MessageDlg('Deseja sair do sistema?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Close;
end;

procedure TfrmInicial.btCarregarPedidosClick(Sender: TObject);
var
  vFM        : TfrmConsultaPedido;
  vSQLSelect : TFDQuery;
begin
  vFM        := TfrmConsultaPedido.Create(nil); // Abre tela consulta
  vSQLSelect := TFDQuery.Create(nil); // Query tempor�ria para consulta
  try
    vSQLSelect.Connection := TConfiguracao.BancoDados.Conexao;

    if vFM.ShowModal = mrOK then
    begin
      cdsCabecalho.Close;
      cdsPedidoProduto.Close;

      // Carrega o cabe�alho do pedido
      cdsCabecalho.Params[0].AsInteger := StrToInt(vFM.CodigoPedidoSelecionado);
      cdsCabecalho.Open;
      cdsCabecalho.Edit;

      edCodCliente.Text := vFm.CodigoClienteSelecionado;
      edCodClienteExit(Self);

      vSQLSelect.SQL.Text := ' SELECT PP.*, P.PRODUTO_DESCRICAO                       ' +
                             ' FROM PEDIDOS_PRODUTOS PP                               ' +
                             ' JOIN PRODUTO P ON PP.PRODUTO_CODIGO = P.PRODUTO_CODIGO ' +
                             ' WHERE PP.PEDIDO_NUMERO = :PEDIDO_NUMERO                ';

      vSQLSelect.ParamByName('PEDIDO_NUMERO').AsInteger := cdsCabecalhoPEDIDO_NUMERO.AsInteger;
      vSQLSelect.Open;

      {$REGION 'TRANSFERE OS DADOS PARA O CABECALHO'}
      cdsPedidoProduto.DisableControls;
      try
        cdsPedidoProduto.EmptyDataSet;
        while not vSQLSelect.Eof do
        begin
          cdsPedidoProduto.Append;
          cdsPedidoProduto.FieldByName('PEDIDO_CODIGOITEM').AsInteger     := vSQLSelect.FieldByName('PEDIDO_CODIGOITEM').AsInteger;
          cdsPedidoProduto.FieldByName('PEDIDO_NUMERO').AsInteger         := vSQLSelect.FieldByName('PEDIDO_NUMERO').AsInteger;
          cdsPedidoProduto.FieldByName('PRODUTO_CODIGO').AsInteger        := vSQLSelect.FieldByName('PRODUTO_CODIGO').AsInteger;
          cdsPedidoProduto.FieldByName('PEDIDOPRODUTO_QUANT').AsFloat     := vSQLSelect.FieldByName('PEDIDOPRODUTO_QUANT').AsFloat;
          cdsPedidoProduto.FieldByName('PEDIDOPRODUTO_VLRUNIT').AsFloat   := vSQLSelect.FieldByName('PEDIDOPRODUTO_VLRUNIT').AsFloat;
          cdsPedidoProduto.FieldByName('PEDIDOPRODUTO_VLRTOTAL').AsFloat  := vSQLSelect.FieldByName('PEDIDOPRODUTO_VLRTOTAL').AsFloat;
          cdsPedidoProduto.FieldByName('PRODUTO_DESCRICAO').AsString      := vSQLSelect.FieldByName('PRODUTO_DESCRICAO').AsString;
          cdsPedidoProduto.Post;

          vSQLSelect.Next;
        end;
      finally
        cdsPedidoProduto.EnableControls;
      end;
      {$ENDREGION}


      {$REGION 'CANCELAMENTO DE PEDIDO'}
      if bCancelando then
      begin
        if MessageDlg('Deseja Cancelar o Pedido N� ' + cdsCabecalhoPEDIDO_NUMERO.AsString + ' ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          fCancelarPedido(cdsCabecalhoPEDIDO_NUMERO.AsInteger);
          fLimpaCamposCliente;
          cdsCabecalho.Close;
        end;
      end;
      {$ENDREGION'}

      fControlaTela(True);
    end;
  finally
    vSQLSelect.Free;
    FreeAndNil(vFM);
  end;
end;


procedure TfrmInicial.btExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o produto da rela��o?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    cdsPedidoProduto.Delete;
    fAtualizarSubtotal;
  end;
end;

procedure TfrmInicial.btExcluirPedClick(Sender: TObject);
begin
  bCancelando := True;
  btCarregarPedidosClick(Self);
end;

procedure TfrmInicial.btGravarClick(Sender: TObject);
var
  vSQLInsertCabecalho: TFDQuery;
  vSQLInsertDetalhe: TFDQuery;
begin

  fValidacoesGravar;

  vSQLInsertCabecalho := TFDQuery.Create(nil);
  vSQLInsertDetalhe   := TFDQuery.Create(nil);

  try
    vSQLInsertCabecalho.Connection := TConfiguracao.BancoDados.Conexao;
    vSQLInsertDetalhe.Connection   := TConfiguracao.BancoDados.Conexao;

    // Inicia a transa��o
    TConfiguracao.BancoDados.Conexao.StartTransaction;

    {$REGION 'INSERT CABECALHO'}
    // Insere o cabe�alho do pedido
    vSQLInsertCabecalho.SQL.Text :=   ' INSERT INTO PEDIDOS ' +
                                      ' (PEDIDO_NUMERO, CLIENTE_CODIGO, PEDIDO_DATAEMISSAO, PEDIDO_VALORTOTAL)     ' +
                                      ' VALUES                                                                     ' +
                                      ' (:PEDIDO_NUMERO, :CLIENTE_CODIGO, :PEDIDO_DATAEMISSAO, :PEDIDO_VALORTOTAL) ';

    vSQLInsertCabecalho.ParamByName('PEDIDO_NUMERO').AsInteger       := cdsCabecalhoPEDIDO_NUMERO.AsInteger;
    vSQLInsertCabecalho.ParamByName('CLIENTE_CODIGO').AsInteger      := cdsCabecalhoCLIENTE_CODIGO.AsInteger;
    vSQLInsertCabecalho.ParamByName('PEDIDO_DATAEMISSAO').AsDateTime := cdsCabecalhoPEDIDO_DATAEMISSAO.AsDateTime;
    vSQLInsertCabecalho.ParamByName('PEDIDO_VALORTOTAL').AsFloat     := cdsCabecalhoPEDIDO_VALORTOTAL.AsFloat;

    vSQLInsertCabecalho.ExecSQL;

    {$ENDREGION 'CABECALHO'}

    {$REGION 'INSERT DETALHE'}
    cdsPedidoProduto.First;
    while not cdsPedidoProduto.Eof do
    begin
      vSQLInsertDetalhe.SQL.Text :=      ' INSERT INTO PEDIDOS_PRODUTOS                                                                             ' +
                                         ' (PEDIDO_CODIGOITEM, PEDIDO_NUMERO, PRODUTO_CODIGO, PEDIDOPRODUTO_QUANT, PEDIDOPRODUTO_VLRUNIT, PEDIDOPRODUTO_VLRTOTAL)      ' +
                                         ' VALUES                                                                                                   ' +
                                         ' (:PEDIDO_CODIGOITEM, :PEDIDO_NUMERO, :PRODUTO_CODIGO, :PEDIDOPRODUTO_QUANT, :PEDIDOPRODUTO_VLRUNIT, :PEDIDOPRODUTO_VLRTOTAL) ';

      vSQLInsertDetalhe.ParamByName('PEDIDO_CODIGOITEM').AsInteger     := cdsPedidoProdutoPEDIDO_CODIGOITEM.AsInteger;
      vSQLInsertDetalhe.ParamByName('PEDIDO_NUMERO').AsInteger         := cdsCabecalhoPEDIDO_NUMERO.AsInteger;
      vSQLInsertDetalhe.ParamByName('PRODUTO_CODIGO').AsInteger        := cdsPedidoProdutoPRODUTO_CODIGO.AsInteger;
      vSQLInsertDetalhe.ParamByName('PEDIDOPRODUTO_QUANT').AsFloat     := cdsPedidoProdutoPEDIDOPRODUTO_QUANT.AsFloat;
      vSQLInsertDetalhe.ParamByName('PEDIDOPRODUTO_VLRUNIT').AsFloat   := cdsPedidoProdutoPEDIDOPRODUTO_VLRUNIT.AsFloat;
      vSQLInsertDetalhe.ParamByName('PEDIDOPRODUTO_VLRTOTAL').AsFloat  := cdsPedidoProdutoPEDIDOPRODUTO_VLRTOTAL.AsFloat;

      vSQLInsertDetalhe.ExecSQL;
      cdsPedidoProduto.Next;
    end;
    {$ENDREGION 'INSERT DETALHE'}

    // Confirma a transa��o
    TConfiguracao.BancoDados.Conexao.Commit;

    ShowMessage('Pedido gravado com sucesso!');
  except
    on E: Exception do
    begin
      // Reverte a transa��o em caso de erro
      TConfiguracao.BancoDados.Conexao.Rollback;
      ShowMessage('Erro ao gravar o pedido: ' + E.Message);
    end;
  end;
  FreeAndNil(vSQLInsertCabecalho);
  FreeAndNil(vSQLInsertDetalhe);

  cdsCabecalho.Close;
  fLimpaCamposCliente;
  fLimpaCamposProduto;
  fControlaTela(True);
end;


procedure TfrmInicial.btIncluirClick(Sender: TObject);
var
  vChave: Integer;
begin
  fValidacoesIncluirProduto;

  if cdsPedidoProduto.IsEmpty then
    vChave := 1 // Inicia com 1 se n�o houver registros
  else
  begin
    cdsPedidoProduto.Last;
    vChave := cdsPedidoProduto.RecordCount + 1; // Incrementa o �ltimo valor
  end;

  if bEditando then //Se estiver editando os produtos na grade
  begin
    cdsPedidoProduto.Edit;
    cdsPedidoProdutoPEDIDO_CODIGOITEM.AsInteger     := cdsPedidoProdutoPEDIDO_CODIGOITEM.AsInteger;
    cdsPedidoProdutoPEDIDO_NUMERO.AsString          := cdsCabecalhoPEDIDO_NUMERO.AsString;
    cdsPedidoProdutoPRODUTO_CODIGO.AsInteger        := sqlProdutoPRODUTO_CODIGO.AsInteger;
    cdsPedidoProdutoPEDIDOPRODUTO_VLRUNIT.AsFloat   := StrToFloatDef(edPrecoVenda.Text, 0);
    cdsPedidoProdutoPEDIDOPRODUTO_VLRTOTAL.AsFloat  := StrToFloatDef(edTotalProduto.Text, 0);
    cdsPedidoProdutoPEDIDOPRODUTO_QUANT.AsFloat     := StrToFloatDef(edQuantidade.Text, 0);
    cdsPedidoProdutoPRODUTO_DESCRICAO.AsString      := sqlProdutoPRODUTO_DESCRICAO.AsString;
    cdsPedidoProduto.Post;
    bEditando := False;
  end
  else
  begin  //caso estiver adicionando novos produtos
    try
      cdsPedidoProduto.Append;

      cdsPedidoProdutoPEDIDO_CODIGOITEM.AsInteger     := vChave;
      cdsPedidoProdutoPEDIDO_NUMERO.AsString          := cdsCabecalhoPEDIDO_NUMERO.AsString;
      cdsPedidoProdutoPRODUTO_CODIGO.AsInteger        := sqlProdutoPRODUTO_CODIGO.AsInteger;
      cdsPedidoProdutoPEDIDOPRODUTO_VLRUNIT.AsFloat   := StrToFloatDef(edPrecoVenda.Text, 0);
      cdsPedidoProdutoPEDIDOPRODUTO_VLRTOTAL.AsFloat  := StrToFloatDef(edTotalProduto.Text, 0);
      cdsPedidoProdutoPEDIDOPRODUTO_QUANT.AsFloat     := StrToFloatDef(edQuantidade.Text, 0);
      cdsPedidoProdutoPRODUTO_DESCRICAO.AsString      := sqlProdutoPRODUTO_DESCRICAO.AsString;

      cdsPedidoProduto.Post;
    except
      on E : EDBClient do
      begin
        ShowMessage('Erro ao incluir produto: Valor total n�o suportado');
        cdsPedidoProduto.Delete;
      end;

      on E: Exception do
      begin
        ShowMessage('Erro ao incluir produto: Erro inesperado');
        cdsPedidoProduto.Delete;
      end;

    end;
  end;

  fAtualizarSubtotal;
  fLimpaCamposProduto;
  edCodProd.SetFocus;
end;

procedure TfrmInicial.btIncluirPedidoClick(Sender: TObject);
begin
  fLimpaCamposCliente;
  fControlaTela(False);
  btCarregarPedidos.Visible := True;
  btExcluirPed.Visible      := True;
  cdsCabecalho.Close;
  cdsCabecalho.Params[0].AsInteger := -1;
  cdsCabecalho.Open;
  cdsCabecalho.Append;

  cdsCabecalhoCLIENTE_CODIGO.Required := False;
  cdsCabecalhoPEDIDO_DATAEMISSAO.AsDateTime := Date;
  cdsCabecalhoPEDIDO_VALORTOTAL.AsFloat := 0;


  ControlaBotoes(True, False);

  edNumeroPedido.Text := IntToStr(TConfiguracao.ProximoRegistro('PEDIDOS', 'PEDIDO_NUMERO'));

  edCodCliente.SetFocus;
end;

procedure TfrmInicial.btPesquisarClienteClick(Sender: TObject);
var
  vFM : TfrmConsultaCliente;
begin
  vFM := TfrmConsultaCliente.Create(nil); //Abre tela consulta
  try
    if vFM.ShowModal = mrOK then
    begin
      edCodCliente.Text := vFm.CodigoClienteSelecionado;
      if edCodCliente.Text <> '' then
        edCodClienteExit(Self);
    end;

  finally
    FreeAndNil(vFM);
  end;

end;

procedure TfrmInicial.edCodClienteExit(Sender: TObject);
begin
  if edCodCliente.Text <> '' then
  begin
    sqlCliente.Close;
    sqlCliente.ParamByName('CLIENTE_CODIGO').AsString := edCodCliente.Text;
    sqlCliente.Open;

    //n�o encontrou
    if sqlCliente.IsEmpty then
    begin
      ShowMessage('Cliente n�o encontrado!');
      edCodCliente.SetFocus;
      edCodCliente.Clear;
      btCarregarPedidos.Visible := True;
      btExcluirPed.Visible      := True;
      Abort;
    end;

    //encontrou
    cdsCabecalhoCLIENTE_CODIGO.AsString := Trim(edCodCliente.Text);
    edCodProd.SetFocus;
    btCarregarPedidos.Visible           := False;
    btExcluirPed.Visible                := False;
  end
  else //caso seja vazio, somente limpa os campos, caso tenha algum conte�do
  begin
    edNomeCliente.Clear;
    edCidade.Clear;
    edUF.Clear;
    cdsCabecalhoCLIENTE_CODIGO.Clear;
    btCarregarPedidos.Visible := True; //Deixo o bot�o visivel
    btExcluirPed.Visible      := True; //Deixo o bot�o visivel
  end;
end;

procedure TfrmInicial.edCodClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_F2 then
    btPesquisarClienteClick(Self);
end;

procedure TfrmInicial.edCodProdExit(Sender: TObject);
begin
  if edCodProd.Text <> '' then
  begin
    sqlProduto.Close;
    sqlProduto.ParamByName('PRODUTO_CODIGO').AsString := edCodProd.Text;
    sqlProduto.Open;

    //n�o encontrou
    if sqlProduto.IsEmpty then
    begin
      ShowMessage('Produto n�o encontrado!');
      edCodProd.SetFocus;
      Abort;
    end;

    //encontrou
    edNomeProduto.Text  := sqlProduto.FieldByName('PRODUTO_DESCRICAO').AsString;
    edPrecoVenda.Text   := sqlProduto.FieldByName('PRODUTO_PRECOVENDA').AsString;
    edPrecoVendaExit(Self);
    edQuantidade.Text := '1,00';
    edQuantidade.SetFocus;
  end
  else
  begin
    edNomeProduto.Clear;
    edQuantidade.Clear;
    edprecoVenda.Clear;
  end;
end;

procedure TfrmInicial.edCodProdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_F2 then
    btPesquisarProdutoClick(Self);
end;

procedure TfrmInicial.edPrecoVendaExit(Sender: TObject);
var
  vPreco, vTotal: Double;
begin
  // Tenta converter e formatar o valor de edPrecoVenda com duas casas decimais
  if TryStrToFloat(edPrecoVenda.Text, vPreco) then
    edPrecoVenda.Text := FormatFloat('0.00', vPreco)
  else
    edPrecoVenda.Text := '0,00';

  // Calcula o total usando o valor formatado de edPrecoVenda e edQuantidade
  vTotal := StrToFloatDef(edQuantidade.Text, 0) * vPreco;
  vTotal := RoundTo(vTotal, -2); // Arredonda para 2 casas decimais

  // Exibe o total formatado com duas casas decimais
  edTotalProduto.Text := FormatFloat('0.00', vTotal);
end;


procedure TfrmInicial.edPrecoVendaKeyPress(Sender: TObject; var Key: Char);
begin
  TFuncao.Numero.DigitarComVirgula(Key);
end;

procedure TfrmInicial.edQuantidadeExit(Sender: TObject);
var
  vValor : Double;
begin
  if TryStrToFloat(edQuantidade.Text, vValor) then
    edQuantidade.Text := FormatFloat('0.00', vValor)
  else
    edQuantidade.Text := '0,00';

  edPrecoVendaExit(Self);
end;

procedure TfrmInicial.edQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
   TFuncao.Numero.DigitarComVirgula(Key);
end;

procedure TfrmInicial.FormCreate(Sender: TObject);
begin
  Caption := sForm_Caption;

  Screen.Cursor := crDefault;
end;

procedure TfrmInicial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F3 then
    btIncluirPedidoClick(Self);

  if Key = VK_F7 then
    btGravar.Click;

  if Key = VK_ESCAPE then
    btSairClick(Self);

  if Key = VK_F5 then
    btExcluirClick(Self);
end;

procedure TfrmInicial.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then //Faz o enter ter fun��o do TAB
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmInicial.FormShow(Sender: TObject);
begin
  bEditando := False;
  fControlaTela(True);
end;

procedure TfrmInicial.ControlaBotoes(bbtIncluir, bbtExcluir: Boolean);
begin
  btIncluirPedido.Enabled             := bBtIncluir;
  btGravar.Enabled                    := cdsCabecalho.State in [dsedit, dsinsert];
end;

procedure TfrmInicial.dsPedidoCabecalhoDataChange(Sender: TObject;
  Field: TField);
begin
// Atualiza caption do Form
  if cdsCabecalho.State in [dsInsert] then
    Caption:= sForm_Caption + sCaptionIncluirRegistro
  else
    Caption := sForm_Caption;
end;

procedure TfrmInicial.fValidacoesIncluirProduto;
begin
  {$REGION 'CAMPOS OBRIGAT�RIOS'}
    if Trim(edCodCliente.Text) = '' then
    begin
      ShowMessage('� necess�rio informar Cliente!');
      edCodCliente.SetFocus;
      Abort;
    end;

    if Trim(edCodProd.Text) = ''  then
    begin
      ShowMessage('� necess�rio informar o Produto!');
      edCodProd.SetFocus;
      Abort;
    end;

    if (Trim(edQuantidade.Text) = '') or (Trim(edQuantidade.Text) = '0,00') then
    begin
      ShowMessage('Quantidade do produto n�o informada!');
      edQuantidade.SetFocus;
      Abort;
    end;

    if (Trim(edPrecoVenda.Text) = '') or (Trim(edPrecoVenda.Text) = '0,00') then
    begin
      ShowMessage('Pre�o de venda do produto n�o informado!');
      edPrecoVenda.SetFocus;
      Abort;
    end;
    {$ENDREGION 'CAMPOS OBRIGAT�RIOS'}

end;

procedure TfrmInicial.GradeProdutosDblClick(Sender: TObject);
begin
  if not cdsPedidoProduto.IsEmpty then
  begin
   if cdsPedidoProduto.State in [dsEdit, dsInsert, dsBrowse] then
   begin
     edCodProd.Clear;
     edNomeProduto.Clear;
     edQuantidade.Clear;
     edPrecoVenda.Clear;
     edTotalProduto.Clear;
   end;

   edCodProd.Text      := cdsPedidoProdutoPRODUTO_CODIGO.AsString;
   edNomeProduto.Text  := cdsPedidoProdutoPRODUTO_DESCRICAO.AsString;
   edQuantidade.Text   := cdsPedidoProdutoPEDIDOPRODUTO_QUANT.AsString;
   edPrecoVenda.Text   := cdsPedidoProdutoPEDIDOPRODUTO_VLRUNIT.AsString;
   edTotalProduto.Text := cdsPedidoProdutoPEDIDOPRODUTO_VLRTOTAL.AsString;
   bEditando := True;
   edQuantidadeExit(Self);
   edQuantidade.SetFocus;
  end;

end;

procedure TfrmInicial.GradeProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    GradeProdutosDblClick(Self);

  if Key = VK_DELETE then
    btExcluirClick(Self);
end;

procedure TfrmInicial.fLimpaCamposProduto;
begin
  edCodProd.Clear;
  edNomeProduto.Clear;
  edQuantidade.Clear;
  edPrecoVenda.Clear;
  edTotalProduto.Clear;
end;

procedure TfrmInicial.fAtualizarSubtotal;
var
  vSubtotal: Double;
begin
  vSubtotal := 0;
  if cdsPedidoProduto.Active then
  begin
    cdsPedidoProduto.DisableControls;
    try
      cdsPedidoProduto.First;
      while not cdsPedidoProduto.Eof do
      begin
        vSubtotal := vSubtotal + cdsPedidoProduto.FieldByName('PEDIDOPRODUTO_VLRTOTAL').AsFloat;
        cdsPedidoProduto.Next;
      end;
      cdsPedidoProduto.First;
    finally
      cdsPedidoProduto.EnableControls;
    end;
  end;

  cdsCabecalho.Edit;
  cdsCabecalhoPEDIDO_VALORTOTAL.AsString := FormatFloat('0.00', vSubtotal);
  cdsCabecalho.Post;
end;

procedure TfrmInicial.fControlaTela(bBloqueiaTela : Boolean);
begin
  tbControlGeral.Enabled := not bBloqueiaTela;
end;

procedure TfrmInicial.fLimpaCamposCliente;
begin
  edCodCliente.Clear;
  edNomeCliente.Clear;
  edCidade.Clear;
  edUF.Clear;
  edNumeroPedido.Clear;
end;

procedure TfrmInicial.fValidacoesGravar;
begin
  if cdsCabecalhoCLIENTE_CODIGO.IsNull then
  begin
    ShowMessage('� necess�rio informar Cliente!');
    edCodCliente.SetFocus;
    Abort;
  end;

  if cdsPedidoProduto.RecordCount = 0 then
  begin
    ShowMessage('Nenhum produto informado no Pedido de Venda!');
    edCodProd.SetFocus;
    Abort;
  end;
end;

procedure TfrmInicial.fCancelarPedido(const vPedidoNumero: Integer);
var
  vQryCancelamento: TFDQuery;
begin
  vQryCancelamento := TFDQuery.Create(nil);
  try
    vQryCancelamento.Connection := TConfiguracao.BancoDados.Conexao;

    // Inicia a transa��o
    TConfiguracao.BancoDados.Conexao.StartTransaction;

    try
      // Deleta os produtos do pedido
      vQryCancelamento.SQL.Text := 'DELETE FROM PEDIDOS_PRODUTOS WHERE PEDIDO_NUMERO = :PEDIDO_NUMERO';
      vQryCancelamento.ParamByName('PEDIDO_NUMERO').AsInteger := vPedidoNumero;
      vQryCancelamento.ExecSQL;

      // Deleta o cabe�alho do pedido
      vQryCancelamento.SQL.Text := 'DELETE FROM PEDIDOS WHERE PEDIDO_NUMERO = :PEDIDO_NUMERO';
      vQryCancelamento.ParamByName('PEDIDO_NUMERO').AsInteger := vPedidoNumero;
      vQryCancelamento.ExecSQL;

      // Confirma a transa��o
      TConfiguracao.BancoDados.Conexao.Commit;

      ShowMessage('Pedido cancelado com sucesso!');
    except
      on E: Exception do
      begin
        // Reverte a transa��o em caso de erro
        TConfiguracao.BancoDados.Conexao.Rollback;
        ShowMessage('Erro ao cancelar o pedido: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(vQryCancelamento);
  end;
end;

end.
