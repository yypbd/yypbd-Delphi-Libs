unit Winsock2Addon;

interface

type
  PUInt32 = ^UInt32;
  TWinsock2Addon = record
  public
    class function WS2_32_WINSOCK_SWAP_LONG(Value: UInt32): UInt32; inline; static;
    class function WS2_32_WINSOCK_SWAP_LONGLONG(Value: UInt64): UInt64; inline; static;

    class function htond(Value: Double): UInt64; inline; static;
    class function htonf(Value: Single): UInt32; inline; static;
    class function htonll(Value: UInt64): UInt64; inline; static;

    class function ntohd(Value: UInt64): Double; inline; static;
    class function ntohf(Value: UInt32): Single; inline; static;
    class function ntohll(Value: UInt64): UInt64; inline; static;

    class function IsLittleEndian: Boolean; static;
  end;

implementation

//uses
//  Winsock2;

{ TWinsock2Addon }

class function TWinsock2Addon.htond(Value: Double): UInt64;
begin
  // Result := htonll( (PUInt64(@Value))^ );
  Result := WS2_32_WINSOCK_SWAP_LONGLONG( (PUInt64(@Value))^ );
end;

class function TWinsock2Addon.htonf(Value: Single): UInt32;
begin
  // Result := htonl( (PUInt32(@Value))^ );
  Result := WS2_32_WINSOCK_SWAP_LONG( (PUInt32(@Value))^ );
end;

class function TWinsock2Addon.htonll(Value: UInt64): UInt64;
begin
  // Result := (UInt64(htonl(Value)) shl 32) + htonl((Value) shr 32);
  Result := WS2_32_WINSOCK_SWAP_LONGLONG(Value);
end;

class function TWinsock2Addon.IsLittleEndian: Boolean;
var
  Num: Integer;
begin
  Num := 42;
  Result := PByte(@Num)^ = 42;
end;

class function TWinsock2Addon.ntohd(Value: UInt64): Double;
begin
  // (PUInt64(@Result))^ := htonll(Value);
  (PUInt64(@Result))^ := WS2_32_WINSOCK_SWAP_LONGLONG(Value);
end;

class function TWinsock2Addon.ntohf(Value: UInt32): Single;
begin
  // (PUInt32(@Result))^ := htonl(Value);
  (PUInt32(@Result))^ := WS2_32_WINSOCK_SWAP_LONG(Value);
end;

class function TWinsock2Addon.ntohll(Value: UInt64): UInt64;
begin
  // Result := (UInt64(ntohl(Value)) shl 32) + ntohl((Value) shr 32);
  Result := WS2_32_WINSOCK_SWAP_LONGLONG(Value);
end;

class function TWinsock2Addon.WS2_32_WINSOCK_SWAP_LONG(Value: UInt32): UInt32;
begin
  Result := ( ((Value) shr 24) and $000000FF ) or
            ( ((Value) shr  8) and $0000FF00 ) or
            ( ((Value) shl  8) and $00FF0000 ) or
            ( ((Value) shl 24) and $FF000000 );
end;

class function TWinsock2Addon.WS2_32_WINSOCK_SWAP_LONGLONG(
  Value: UInt64): UInt64;
begin
  Result := ( ((Value) shr 56) and $00000000000000FF ) or
            ( ((Value) shr 40) and $000000000000FF00 ) or
            ( ((Value) shr 24) and $0000000000FF0000 ) or
            ( ((Value) shr  8) and $00000000FF000000 ) or
            ( ((Value) shl  8) and $000000FF00000000 ) or
            ( ((Value) shl 24) and $0000FF0000000000 ) or
            ( ((Value) shl 40) and $00FF000000000000 ) or
            ( ((Value) shl 56) and $FF00000000000000 );
end;

end.
