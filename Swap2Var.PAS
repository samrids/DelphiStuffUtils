var
   a,
   b: integer;
begin
   a:= -1;
   b:= 2;

showmessage (format('Before swap %d, %d',[a, b]));
   b:= a + b;
   a:= b - a;
   b:= b - a;
   showmessage (format('After swap %d, %d',[a, b])
