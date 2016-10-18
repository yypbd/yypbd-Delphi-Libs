program WindowsVersionExample;

uses
  Vcl.Forms,
  WindowsVersionExampleMainForm in 'WindowsVersionExampleMainForm.pas' {Form1},
  WindowsVersion in '..\..\lib\WindowsVersion.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
