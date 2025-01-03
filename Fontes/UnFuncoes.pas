unit UnFuncoes;

interface

uses
  System.SysUtils, Vcl.StdCtrls, Vcl.Forms, Vcl.DBCtrls;

resourcestring
  sCaptionIncluirRegistro   = ' - Incluindo';

type
  TNumero = class
  strict private
    class procedure DigitaSoNumeroEPonto(var Key: Char); static;
    class procedure DigitaSoNumeroEVirgula(var Key: Char); static;
  public
    class procedure DigitarComPonto(var Key: Char);
    class procedure DigitarComVirgula(var Key: Char);
  end;

  TFuncao = class
  strict private
    class var FNumero: TNumero;
  public
    class property Numero: TNumero read FNumero;
    class constructor Create;
    class destructor Destroy;
  end;

implementation

{ TNumero }

class procedure TNumero.DigitaSoNumeroEPonto(var Key: Char);
var
  TextContent: string;
begin
  if not (Key in ['0'..'9', '.', #8]) then
    Key := #0
  else if (Key = '.') then
  begin
    if Screen.ActiveControl is TEdit then
      TextContent := TEdit(Screen.ActiveControl).Text
    else if Screen.ActiveControl is TDBEdit then
      TextContent := TDBEdit(Screen.ActiveControl).Text
    else
      Exit;

    if Pos('.', TextContent) > 0 then
      Key := #0;
  end;
end;

class procedure TNumero.DigitaSoNumeroEVirgula(var Key: Char);
var
  TextContent: string;
begin
  if not (Key in ['0'..'9', ',', #8]) then
    Key := #0
  else if (Key = ',') then
  begin
    if Screen.ActiveControl is TEdit then
      TextContent := TEdit(Screen.ActiveControl).Text
    else if Screen.ActiveControl is TDBEdit then
      TextContent := TDBEdit(Screen.ActiveControl).Text
    else
      Exit;

    if Pos(',', TextContent) > 0 then
      Key := #0;
  end;
end;

class procedure TNumero.DigitarComPonto(var Key: Char);
begin
  DigitaSoNumeroEPonto(Key);
end;

class procedure TNumero.DigitarComVirgula(var Key: Char);
begin
  DigitaSoNumeroEVirgula(Key);
end;

{ TFuncao }

class constructor TFuncao.Create;
begin
  FNumero := TNumero.Create;
end;

class destructor TFuncao.Destroy;
begin
  FreeAndNil(FNumero);
end;

end.

