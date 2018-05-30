unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure ButtonClick(Sender: TObject);
    procedure ButtonEscapeOnMouseEnter(Sender: TObject);
    procedure ButtonEscapeOnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure SetNewLocation(Cursor: tPoint; Target: TButton);
var
  Direction: tPoint;
  Velocity: tPoint;
  NextLocation: tPoint;
  CorrectLocation: tpoint;
begin
  // Set Velocity
  Velocity := Point(3, 3);
  // Calcutate the direction the button should take
  Direction := Point(-1, -1);
  if (Cursor.x < (Target.Left + round(Target.Width / 2))) then // Cursor come from left
    Direction.x := abs(Direction.x);
  if (Cursor.y < (Target.Top + round(Target.Height / 2))) then // Cursor come from above
    Direction.y := abs(Direction.y);
  // Calculate the next Location of the button
  NextLocation := Point(Target.Left + (Direction.x * Velocity.x), Target.Top +
    (Direction.y * Velocity.y));
  // Correct the Location of the button if it's out of bounce
  CorrectLocation := Point(NextLocation.x, NextLocation.y);
  if ((NextLocation.x + Target.Width > Form1.Width) or (NextLocation.x < 0)) then
    CorrectLocation.x := Cursor.x + ((-Direction.x * Target.Width) +
      (-Direction.x * Velocity.x));
  if ((NextLocation.y + Target.Height > Form1.Height) or (NextLocation.y < 0)) then
    CorrectLocation.y := Cursor.y + ((-Direction.y * Target.Height) +
      (-Direction.y * Velocity.y));
  // Set the correct Location
  Target.Left := CorrectLocation.x;
  Target.Top := CorrectLocation.y;
end;


procedure TForm1.ButtonEscapeOnMouseEnter(Sender: TObject);
var
  CursorPosition: tPoint;
  Target: TButton;
begin
  if Sender is TButton then
  begin
    CursorPosition := Form1.ScreenToClient(Mouse.CursorPos);
    Target := TButton(Sender);
    SetNewLocation(CursorPosition, Target);
  end;
end;

procedure TForm1.ButtonClick(Sender: TObject);
begin
  // Show a confirmation dialog
  ShowMessage('Button clicked');
end;

procedure TForm1.ButtonEscapeOnMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
var
  CursorPosition: tPoint;
  Target: TButton;
begin
  CursorPosition := Form1.ScreenToClient(Mouse.CursorPos);
  if Sender is TButton then
  begin
    CursorPosition := Form1.ScreenToClient(Mouse.CursorPos);
    Target := TButton(Sender);
    SetNewLocation(CursorPosition, Target);
  end;
end;


end.
