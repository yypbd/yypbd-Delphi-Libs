program ShellKnownPathExample;

uses
  Vcl.Forms,
  ShellKnownPathExampleMainForm in 'ShellKnownPathExampleMainForm.pas' {FormShellKnownPathExampleMain},
  ShellKnownPath in '..\..\lib\ShellKnownPath.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormShellKnownPathExampleMain, FormShellKnownPathExampleMain);
  Application.Run;
end.
