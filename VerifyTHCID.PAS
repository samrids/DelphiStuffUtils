function ValidateTHCID(const CID: String): boolean;
var
  digit: array [1 .. 13] of byte;
  SUM: SmallInt;
  StrCID: string;
  i: byte;
begin
  StrCID := CID;
  StrCID := StringReplace(StrCID, '-', '', [rfReplaceAll]);
  StrCID := StringReplace(StrCID, ' ', '', [rfReplaceAll]);  

  result := false;
  if (Trim(StrCID)='') then
    exit;

  if (Length( Trim(StrCID) ) <> 13) then
    exit;

  for i:= 1 to 13 do begin  //Valid Numeric
    if Ord(StrCID[i]) > 57 then begin
     exit;
     Break;
    end;
  end;

  SUM := 0; //init
  for i := 1 to 12 do
  begin
    digit[i] := StrToInt(StrCID[i]);
    SUM := SUM + (digit[i] * (14 - i));
  end;
  digit[13] := StrToInt(StrCID[13]);

  SUM := (11 - (SUM mod 11));
  if SUM > 9 then
    SUM := SUM - 10;
  result := (SUM = digit[13]);
end;
