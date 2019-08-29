unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, System.ImageList, Vcl.ImgList, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.Menus, Unit2, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImageList;

 const btn_size = 16;

type
  TMyPanel = class(TPanel)
  private
    FRows: Integer;
    FColumns: Integer;
    FBtnColor: TColor;
    FScaledOffset: Integer;
    FScaledBtnSize: Integer;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ScaleForPPI(NewPPI: Integer); override;
    property Rows: Integer read FRows write FRows;
    property Columns: Integer read FColumns write FColumns;
    property BtnColor: TColor read FBtnColor write FBtnColor;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ListBox1: TListBox;
    ComboBox1: TComboBox;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    New1: TMenuItem;
    Load1: TMenuItem;
    Save1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    RadioButton1: TRadioButton;
    ColorDialog1: TColorDialog;
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    Panel4: TPanel;
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Panel3DockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure Panel3GetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure ToolButton5Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
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

procedure TForm1.FormCreate(Sender: TObject);
var
  mp: TMyPanel;
begin
  mp := TMyPanel.Create(Panel4);
  mp.Parent := Panel4;
  mp.Align := alClient;
  mp.Rows := 4;
  mp.Columns := 4;
  mp.BtnColor := clSkyBlue;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMetaF);
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  ListBox1.Canvas.FillRect(Rect);
  VirtualImageList1.Draw(ListBox1.Canvas, Rect.Left, Rect.Top, 1);
  ListBox1.Canvas.TextOut(VirtualImageList1.Width, Rect.Top + 1, ListBox1.Items[Index]);
end;

procedure TForm1.New1Click(Sender: TObject);
begin
  Form2.Show;
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

procedure TForm1.Panel3DockOver(Sender: TObject; Source: TDragDockObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Sender is TForm2;
end;

procedure TForm1.Panel3GetSiteInfo(Sender: TObject; DockClient: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := DockClient is TForm2;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
var
  ctx: DPI_AWARENESS_CONTEXT;
begin
  ctx := GetThreadDpiAwarenessContext;
  SetThreadDpiAwarenessContext(DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED);
  ColorDialog1.Execute;
  SetThreadDpiAwarenessContext(ctx);
end;

{ TMyPanel }

constructor TMyPanel.Create(AOwner: TComponent);
begin
  inherited;
  FScaledOffset := Round(2 * (CurrentPPI / 96));
  FScaledBtnSize := Round(btn_size * (CurrentPPI / 96));
end;

procedure TMyPanel.Paint;
var
  i, j, offset, t, l: Integer;

begin
  inherited;
  offset := 2;
  Canvas.Brush.Color := BtnColor;
  for i := 0 to FRows - 1 do
    for j := 0 to FColumns - 1 do
    begin
      t := (FScaledOffset + FScaledBtnSize) * i;
      l := (FScaledOffset + FScaledBtnSize) * j;
      Canvas.FillRect(Rect(l, t, l + FScaledBtnSize, t + FScaledBtnSize));
    end;
end;

procedure TMyPanel.ScaleForPPI(NewPPI: Integer);
begin
  inherited;
  FScaledOffset := Round(2 * (CurrentPPI / 96));
  FScaledBtnSize := Round(btn_size * (CurrentPPI / 96));
end;

end.
