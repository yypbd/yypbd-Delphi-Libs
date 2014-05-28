unit WindowsVersionExampleMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  WindowsVersion;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Major, Minor, ServicePack: DWORD;
  IsServer: Boolean;
begin
  if GetWindowsVersion( Major, Minor, ServicePack, IsServer ) then
  begin
    Memo1.Lines.Add( Format( 'Major=%d, Minor=%d, ServicePack=%d', [Major, Minor, ServicePack] ) );

    if IsServer then
      Memo1.Lines.Add( '  Is Server!!' )
    else
      Memo1.Lines.Add( '  Not Server!!' )
  end;
end;

end.
