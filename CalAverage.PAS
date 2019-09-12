Delphi (Get the average for a set of numbers)

The Mean function returns the average of a set of Double values in a DataArray.

uses Math;

procedure TForm1.FormCreate(Sender: TObject);
var
  numbers :array[0..4] of Extended;
  x_bar: Extended;
begin
  numbers[0] := 6000.1;
  numbers[1] := 6000.1;

  numbers[2] := 6000.1;
  numbers[3] := 6000.0;

  numbers[4] := 6000.0;
  x_bar:= mean(numbers);
  self.Caption := format('%f',[x_bar]);
end;
