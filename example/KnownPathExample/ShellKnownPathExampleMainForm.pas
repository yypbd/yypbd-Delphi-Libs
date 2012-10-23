unit ShellKnownPathExampleMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormShellKnownPathExampleMain = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormShellKnownPathExampleMain: TFormShellKnownPathExampleMain;

implementation

uses
  ShellKnownPath;

{$R *.dfm}

procedure TFormShellKnownPathExampleMain.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Add( TShellKnownPath.GetFolderPath( FOLDERID_Music ) );
  Memo1.Lines.Add( TShellKnownPath.GetFolderPath( FOLDERID_RoamingAppData ) );
  Memo1.Lines.Add( TShellKnownPath.GetFolderPath( FOLDERID_Profile ) );
end;

end.
