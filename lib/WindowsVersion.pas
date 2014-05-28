unit WindowsVersion;

interface

uses
  WinApi.Windows, System.SysUtils;

  function GetWindowsVersion( var AMajor, AMinor: DWORD ): Boolean; overload;
  function GetWindowsVersion( var AMajor, AMinor, AServicePack: DWORD; var AIsServer: Boolean ): Boolean; overload;

implementation

const
  NERR_Success = 0;
  SERVICE_MAX_COUNT = 10;
  VER_EQUAL = 1;

type
  WKSTA_INFO_100 = record
    wki100_platform_id: DWORD;
    wki100_computername: LPWSTR;
    wki100_langroup: LPWSTR;
    wki100_ver_major: DWORD;
    wki100_ver_minor: DWORD;
  end;
  LPWKSTA_INFO_100 = ^WKSTA_INFO_100;

  _USER_INFO_0 = record
    usri0_name: LPWSTR;
  end;

var
  MajorCache: DWORD;
  MinorCache: DWORD;
  ServicePackCache: DWORD;
  IsServerCache: Boolean;

function NetWkstaGetInfo(ServerName: LPWSTR; Level: DWORD; BufPtr: Pointer): Longint; stdcall; external 'netapi32.dll' Name 'NetWkstaGetInfo';
function NetApiBufferFree(Buffer: Pointer): LongInt; stdcall; external 'netapi32.dll' Name 'NetApiBufferFree';

{$IFDEF UNICODE}
function VerifyVersionInfo(var LPOSVERSIONINFOEX : OSVERSIONINFOEX;dwTypeMask: DWORD;dwlConditionMask: int64): BOOL; stdcall; external kernel32 name 'VerifyVersionInfoW';
{$ELSE}
function VerifyVersionInfo(var LPOSVERSIONINFOEX : OSVERSIONINFOEX;dwTypeMask: DWORD;dwlConditionMask: int64): BOOL; stdcall; external kernel32 name 'VerifyVersionInfoA';
{$ENDIF}
function VerSetConditionMask(dwlConditionMask: int64;dwTypeBitMask: DWORD; dwConditionMask: Byte): int64; stdcall; external kernel32;

function GetWindowsVersion( var AMajor, AMinor: DWORD ): Boolean;
var
  Buf: LPWKSTA_INFO_100;
  Res: LongInt;
begin
  Result := False;

  if MajorCache <> 0 then
  begin
    AMajor := MajorCache;
    AMinor := MinorCache;
    Result := True;
    Exit;
  end;

  if NetWkstaGetInfo( nil, 100, @Buf ) = NERR_Success then
  begin
    MajorCache := Buf.wki100_ver_major;
    AMajor := MajorCache;
    MinorCache := Buf.wki100_ver_minor;
    AMinor := MinorCache;

    NetApiBufferFree( Buf );
    Result := True;
  end;
end;

function GetWindowsVersion( var AMajor, AMinor, AServicePack: DWORD; var AIsServer: Boolean ): Boolean; overload
var
  I: Integer;
  osvi: OSVERSIONINFOEX;
  ConditionMask: DWORDLONG;
begin
  Result := False;

  if not GetWindowsVersion( AMajor, AMinor ) then
  begin
    Exit;
  end;

  if ServicePackCache <> MAXDWORD then
  begin
    AServicePack := ServicePackCache;
    AIsServer := IsServerCache;
    Result := True;
    Exit;
  end;

  ZeroMemory( @osvi, SizeOf(OSVERSIONINFOEX) );
  osvi.dwOSVersionInfoSize := SizeOf(OSVERSIONINFOEX);

  ConditionMask := 0;
  ConditionMask := VerSetConditionMask( ConditionMask, VER_SERVICEPACKMAJOR, VER_EQUAL );

  for I := 0 to SERVICE_MAX_COUNT - 1 do
  begin
    osvi.wServicePackMajor := I;

    if VerifyVersionInfo ( osvi, VER_SERVICEPACKMAJOR, ConditionMask ) then
    begin
      ServicePackCache := I;
      AServicePack := ServicePackCache;

      ZeroMemory( @osvi, SizeOf(OSVERSIONINFOEX) );
      osvi.dwOSVersionInfoSize := SizeOf(OSVERSIONINFOEX);
      osvi.wProductType := VER_NT_SERVER;
      ConditionMask := 0;
      ConditionMask := VerSetConditionMask( ConditionMask, VER_PRODUCT_TYPE, VER_EQUAL );
      IsServerCache := VerifyVersionInfo( osvi, VER_PRODUCT_TYPE, ConditionMask );
      AIsServer := IsServerCache;

      Result := True;
      Exit;
    end;
  end;
end;

initialization
  MajorCache := 0;
  MinorCache := 0;
  ServicePackCache := MAXDWORD;
  IsServerCache := False;

finalization

end.
