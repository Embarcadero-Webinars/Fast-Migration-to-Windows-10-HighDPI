unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
  private
    FMetaF: TMetafile;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure GetDisplayScale(var aScaleX, aScaleY: Extended);
var
  DevMode: TDevMode;
begin
  aScaleX := 1;
  aScaleY := 1;
  // scale factor for non DPI aware applications
  // msdn.microsoft.com/en-us/library/windows/desktop/dn469266(v=vs.85).aspx
  ZeroMemory(@DevMode, sizeof(DevMode));
  if EnumDisplaySettings(nil, Cardinal(-1{ENUM_CURRENT_SETTINGS MSDN FLAG}), DevMode) then
  begin
    aScaleX := 1 / (DevMode.dmPelsWidth / GetSystemMetrics(SM_CXSCREEN));
    aScaleY := 1 / (DevMode.dmPelsHeight / GetSystemMetrics(SM_CYSCREEN));
  end;
end;

function CreateMetafile(aWidth, aHeight: Integer): TMetafile;
var
  SHandle: THandle;
  aScaleX, aScaleY: Extended;
begin
  GetDisplayScale(aScaleX, aScaleY);
  Result := TMetafile.Create;
  Result.Width := aWidth;
  Result.Height := aHeight;
  Result.Width := Round(aWidth * aScaleX);
  Result.Height := Round(aHeight * aScaleY);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMetaF);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  EMFCanvas: TMetafileCanvas;
  i, w, h: Integer;
begin
  FreeAndNil(FMetaF);
  FMetaF := CreateMetafile(PaintBox1.Width, PaintBox1.Height);
  if Assigned(FMetaF) then
  begin
    w := PaintBox1.Width;
    h := PaintBox1.Height;
    EMFCanvas := TMetafileCanvas.Create(FMetaF, 0);
    try
      EMFCanvas.Lock;
      EMFCanvas.Brush.Color := clSkyBlue;
      EMFCanvas.FillRect(Rect(0, 0, w, h));
      EMFCanvas.Brush.Color := clSilver;
      for i := 0 to w div 10 do
        EMFCanvas.FillRect(Rect(i * 10, i * 10, (i + 1) * 10, (i + 1) * 10));
      EMFCanvas.Unlock;
    finally
      EMFCanvas.Free;
    end;
  end;
  PaintBox1.Invalidate;
end;
//
procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  if Assigned(FMetaF) then
    PaintBox1.Canvas.StretchDraw(Rect(0, 0, PaintBox1.Width, PaintBox1.Height), FMetaF);
end;

end.
