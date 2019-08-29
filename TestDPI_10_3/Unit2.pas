unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    procedure FormDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormDockDrop(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer);
    procedure FormEndDock(Sender, Target: TObject; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormDockDrop(Sender: TObject; Source: TDragDockObject; X,
  Y: Integer);
begin
  ShowMessage('');
end;

procedure TForm2.FormDockOver(Sender: TObject; Source: TDragDockObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TForm2.FormEndDock(Sender, Target: TObject; X, Y: Integer);
begin
  if Assigned(Target) then

  Self.Dock(TWinControl(Target), Rect(0,0, TWinControl(Target).Width, TWinControl(Target).Height));
end;

end.
