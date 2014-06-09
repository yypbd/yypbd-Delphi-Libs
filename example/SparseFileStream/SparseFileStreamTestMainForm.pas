unit SparseFileStreamTestMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormSparseFileStreamMain = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSparseFileStreamMain: TFormSparseFileStreamMain;

implementation

uses
  SparseFileStream;

{$R *.dfm}

procedure TFormSparseFileStreamMain.Button1Click(Sender: TObject);
var
  FS: TSparseFileStream;
  Buffer: TBytes;
  sOut: string;
  I: Integer;
begin
  FS := TSparseFileStream.Create( 'c:\aaa.txt', fmCreate );

  try
    if FS.SupportSparse then
    begin
      Memo1.Lines.Add( 'Support sparse!!' );
    end;

    FS.Position := 2000000;

    sOut := 'This is test line %d'#13#10;
    for i := 1 to 100000 do
    begin
      sOut := Format(sOut, [i]);
      FS.Write(sOut[1], Length(sOut) * SizeOf(Char));
    end;

    Memo1.Lines.Add( 'FileSize = ' + IntToStr( FS.Size ) );
  finally
    FS.Free;
  end;
end;

end.
