program Winsock2AddonExample;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Winsock2Addon in '..\..\lib\Winsock2Addon.pas';

procedure Test_htond;
var
  A: Double;
  B: UInt64;
begin
  A := 10.10;
  B := TWinsock2Addon.htond( A );
  Writeln( Format( 'B=0x%x', [B] ) );
end;

procedure Test_htonf;
var
  A: Single;
  B: UInt64;
begin
  A := 10.10;
  B := TWinsock2Addon.htonf( A );
  Writeln( Format( 'B=0x%x', [B] ) );
end;

procedure Test_htonll;
var
  A, B: UInt64;
begin
  A := $0102030405060708;
  B := TWinsock2Addon.htonll( A );
  Writeln( Format( 'A=0x%x, B=0x%x', [A, B] ) );
  B := TWinsock2Addon.htonll( B );
  Writeln( Format( 'A=0x%x, B=0x%x', [A, B] ) );
end;


procedure Test_ntohd;
var
  A: UInt64;
  B: Double;
begin
  A := $0102030405060708;
  B := TWinsock2Addon.ntohd( A );
  Writeln( Format( 'B=%f', [B] ) );
end;

procedure Test_ntohf;
var
  A: UInt32;
  B: Single;
begin
  A := $01020304;
  B := TWinsock2Addon.ntohf( A );
  Writeln( Format( 'B=%f', [B] ) );
end;

procedure Test_ntohll;
var
  A, B: UInt64;
begin
  A := $0102030405060708;
  B := TWinsock2Addon.ntohll( A );
  Writeln( Format( 'A=0x%x, B=0x%x', [A, B] ) );
  B := TWinsock2Addon.htonll( B );
  Writeln( Format( 'A=0x%x, B=0x%x', [A, B] ) );
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Test_htond;
    Test_htonf;
    Test_htonll;

    Test_ntohd;
    Test_ntohf;
    Test_ntohll;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
