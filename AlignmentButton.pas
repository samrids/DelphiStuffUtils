.
.
.
const BUTTONCAP   : byte = 6;
        BUTTONCOUNT : byte = 4;
implementation

{$R *.dfm}

procedure TForm1.FormResize(Sender: TObject);
begin
  Button1.Top := (Self.Height div 2) - Button1.Height;
  Button2.Top := (Self.Height div 2) - Button2.Height;
  Button3.Top := (Self.Height div 2) - Button3.Height;
  Button4.Top := (Self.Height div 2) - Button4 .Height;

  Button1.Left := (Self.Width div 2) - ((Button1.Width * BUTTONCOUNT) + (BUTTONCAP * BUTTONCOUNT)) div 2;
  Button2.Left := Button1.Left + Button1.Width + BUTTONCAP;
  Button3.Left := Button2.Left + Button1.Width + BUTTONCAP;
  Button4.Left := Button3.Left + Button1.Width + BUTTONCAP;
  .
  .
  .
