program SparseFileStreamTest;

uses
  Vcl.Forms,
  SparseFileStreamTestMainForm in 'SparseFileStreamTestMainForm.pas' {FormSparseFileStreamMain},
  SparseFileStream in '..\..\lib\SparseFileStream.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormSparseFileStreamMain, FormSparseFileStreamMain);
  Application.Run;
end.
