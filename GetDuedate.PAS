unit GetDuedate.PAS;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses
 DateUtils;

 {
  The DayOfWeek function returns an index number for the day of the week :
  1 	= Sunday
  2 	= Monday
  3 	= Tuesday
  4 	= Wednesday
  5 	= Thursday
  6 	= Friday
  7 	= Saturday
 }

 //Test DayOfWeek
procedure TForm1.FormCreate(Sender: TObject);
var
  d,m,y: word;
  idx:  byte;
  dd: tdatetime;
begin
  d:= 23;
  m:= 9;
  y:= 2019;

  dd:= encodedate(y,m,d);
  idx:= DayOfWeek(dd);
  label1.Caption := format('%s DayOfWeek = %d',[formatdatetime('dd/mm/yyyy', dd), idx]);

  dd:= encodedate(y,m,d+1);
  idx:= DayOfWeek(dd);
  label2.Caption := format('%s DayOfWeek = %d',[formatdatetime('dd/mm/yyyy', dd), idx]);

  dd:= encodedate(y,m,d+2);
  idx:= DayOfWeek(dd);
  label3.Caption := format('%s DayOfWeek = %d',[formatdatetime('dd/mm/yyyy', dd), idx]);

  dd:= encodedate(y,m,d+3);
  idx:= DayOfWeek(dd);
  label4.Caption := format('%s DayOfWeek = %d',[formatdatetime('dd/mm/yyyy', dd), idx]);

  dd:= encodedate(y,m,d+4);
  idx:= DayOfWeek(dd);
  label5.Caption := format('%s DayOfWeek = %d',[formatdatetime('dd/mm/yyyy', dd), idx]);

  dd:= encodedate(y,m,d+5);
  idx:= DayOfWeek(dd);
  label6.Caption := format('%s DayOfWeek = %d',[formatdatetime('dd/mm/yyyy', dd), idx]);

  dd:= encodedate(y,m,d+6);
  idx:= DayOfWeek(dd);
  label7.Caption := format('%s DayOfWeek = %d',[formatdatetime('dd/mm/yyyy', dd), idx]);
end;

function GetDueDate(const ADuedate: TDateTime; ANumberOfDays: Integer): TDateTime;
var
  Due: TDateTime;
  ADayOfWeek: Word;
begin
    Due:= ADuedate;
    Due:= IncDay(due, ANumberOfDays);
    ADayOfWeek:= DayOfWeek(Due);
    if ((ADayOfWeek=1) or (ADayOfWeek=7)) then

    begin
       case ADayOfWeek of
          1: Due := IncDay(Due,1); //when Sunday
          7: Due := IncDay(Due,2); //when Saturday
       end;
    end;
    result:= Due;
end;

end.
