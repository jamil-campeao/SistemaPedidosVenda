program Sistema;

uses
  Vcl.Forms,
  UnInicial in 'Fontes\UnInicial.pas' {frmInicial},
  UnDM in 'Fontes\UnDM.pas' {DM: TDataModule},
  UnConsultaProduto in 'Fontes\UnConsultaProduto.pas' {frmConsultaProduto},
  UnFuncoes in 'Fontes\UnFuncoes.pas',
  UnConsultaCliente in 'Fontes\UnConsultaCliente.pas' {frmConsultaCliente},
  UnFuncoesBancoDados in 'Fontes\UnFuncoesBancoDados.pas',
  UnConsultaPedido in 'Fontes\UnConsultaPedido.pas' {frmConsultaPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Sistema';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmInicial, frmInicial);
  Application.Run;
end.
