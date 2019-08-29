program Project1;

uses
  Forms,
  frxDPIAwareInt,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  frxSetProcessDpiAwarenessContext(DPI_AWARENESS_CONTEXT(-4));
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
