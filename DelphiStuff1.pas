uses DateUtils;

function GetSaturdayBetweenDate(const A: TDate; const B: TDate): Integer;
var
  DaysDiff: integer;
  tmpDate: TDate;
  i: byte;
  count: integer;
begin
  DaysDiff := DaysBetween(A, B);
  count := ((DaysDiff - (DaysDiff mod 7)) div 7) * 2;

  if (DaysDiff mod 7) > 0 then begin
    tmpDate := IncDay(B,-1*((DaysDiff mod 7)-1));
    for i := 1 to (DaysDiff mod 7) do begin
        if ((DayOfWeek(tmpDate) = 1) or
           (DayOfWeek(tmpDate) = 7)) then
           inc(count);

         tmpDate := IncDay(tmpDate, 1);
    end;
  end;
  result:= count;
end;


How to use 
-------------------------------------------------------------
procedure TForm1.Button1Click(Sender: TObject);
var
 c: Integer;
begin
  c := GetSaturdaySundayBeetweenDate(DateTimePicker1.Date, DateTimePicker2.Date);
  Self.Caption:= format('%d',[c]);
end;
