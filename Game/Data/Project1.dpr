program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  market in 'market.pas' {magazin},
  UnMenu in 'UnMenu.pas' {mennu},
  load in 'load.pas' {LoadForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MyGame';
  Application.CreateForm(Tmennu, mennu);
  Application.CreateForm(TLoadForm, LoadForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tmagazin, magazin);
  Application.Run;
end.
