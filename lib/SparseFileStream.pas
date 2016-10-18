unit SparseFileStream;

interface

uses
  Windows, Classes, SysUtils;

type
  TSparseFileStream = class( TFileStream )
  private
    FSupportSparse: Boolean;
  public
    constructor Create(const AFileName: string; Mode: Word); overload;
    constructor Create(const AFileName: string; Mode: Word; Rights: Cardinal); overload;

    property SupportSparse: Boolean read FSupportSparse;
  end;

implementation

{ TSparseFileStream }

constructor TSparseFileStream.Create(const AFileName: string; Mode: Word;
  Rights: Cardinal);
var
  RootPath: string;
  MaximumComponentLength, Flags: Cardinal;
  BytesReturned: DWORD;
begin
  RootPath := IncludeTrailingPathDelimiter( ExtractFileDrive(AFileName) );

  FSupportSparse := False;
  if GetVolumeInformation( PChar(RootPath), nil, 0, nil, MaximumComponentLength, Flags, nil, 0 ) then
  begin
    if (Flags and FILE_SUPPORTS_SPARSE_FILES) <> 0 then
      FSupportSparse := True;
  end;

  inherited Create( AFileName, Mode, Rights );

  if FSupportSparse then
    if not DeviceIoControl( FHandle, FSCTL_SET_SPARSE, nil, 0, nil, 0, BytesReturned, nil ) then
    begin
      FSupportSparse := False;
    end;
end;

constructor TSparseFileStream.Create(const AFileName: string; Mode: Word);
begin
{$IFDEF MSWINDOWS}
  Create(AFilename, Mode, 0);
{$ENDIF}
{$IFDEF POSIX}
  Create(AFilename, Mode, FileAccessRights);
{$ENDIF}
end;

end.
