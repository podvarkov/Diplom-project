unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, AppEvnts;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Map1: TMenuItem;
    Map2: TMenuItem;
    New1: TMenuItem;
    Save1: TMenuItem;
    Load1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Block1: TMenuItem;
    Lestnica1: TMenuItem;
    Player1: TMenuItem;
    Ghost1: TMenuItem;
    Door1: TMenuItem;
    Cristal1: TMenuItem;
    space1: TMenuItem;
    Exit1: TMenuItem;
    Undo1: TMenuItem;
    N1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Block1Click(Sender: TObject);
    procedure Lestnica1Click(Sender: TObject);
    procedure Player1Click(Sender: TObject);
    procedure Ghost1Click(Sender: TObject);
    procedure Door1Click(Sender: TObject);
    procedure Cristal1Click(Sender: TObject);
    procedure space1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure DeleteAllMaps1Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Undo1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
    { Private declarations }
  public
  procedure Fdraw;
  procedure proverka;
    { Public declarations }
  end;

var
  Form1: TForm1;
  tb:TBitmap;
  map,zmap:array [1..12,1..16] of integer;
  block:integer;
  mos,b:boolean;

implementation

{$R *.dfm}
procedure TForm1.proverka;
var path:string;
begin
path:=ExtractFilePath(Application.ExeName)+'images\';
end;

procedure TForm1.Fdraw;
var
i,j:integer;
path:string;
begin
Canvas.Font.Color:=clGreen;
b:=true;
i:=0;
path:=ExtractFilePath(Application.ExeName)+'images\';
repeat
i:=i+1;
for j:=1 to 16 do
CASE map[i,j] of
8:begin tb.LoadFromFile(path+'8.bmp');Canvas.Draw((j-1)*40,(i-1)*40,tb);end;
7:begin tb.LoadFromFile(path+'7.bmp');Canvas.Draw((j-1)*40,(i-1)*40,tb);end;
5:begin tb.LoadFromFile(path+'5.bmp');Canvas.Draw((j-1)*40,(i-1)*40,tb);end;
1:begin tb.LoadFromFile(path+'1.bmp');Canvas.Draw((j-1)*40,(i-1)*40,tb);end;
2:begin tb.LoadFromFile(path+'2.bmp');Canvas.Draw((j-1)*40,(i-1)*40,tb);end;
3:begin tb.LoadFromFile(path+'3.bmp');Canvas.Draw((j-1)*40,(i-1)*40,tb);b:=false;end;
4:begin tb.LoadFromFile(path+'4.bmp');Canvas.Draw((j-1)*40,(i-1)*40,tb);end;
0:Canvas.Rectangle((j-1)*40,(i-1)*40,(j-1)*40+40,(i-1)*40+40);
END;
until i>=12;
end;

procedure TForm1.FormCreate(Sender: TObject);
var path:string;
begin
Save1.Enabled:=false;
mos:=false;
Position:=poScreenCenter;
DoubleBuffered:=true;
tb:=TBitmap.Create;
tb.Width:=40;
tb.Height:=40;
tb.Transparent:=True;
tb.TransparentColor:=clFuchsia;
top:=0;left:=0;Width:=650;
Height:=530;BorderStyle:=bsToolWindow;
b:=true;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
block:=1;
proverka;
end;

procedure TForm1.FormClick(Sender: TObject);
var
i,j:integer;
path:string;
begin
{i:=(Mouse.CursorPos.y-top-30) div 40+1;
j:=(Mouse.CursorPos.x-left) div 40+1;
if ((i>1) and (i<12)) and ((j<16) and (j>1)) then
case block of
1:begin
map[i,j]:=1;
Fdraw;
end;
2:begin
map[i,j]:=2;
Fdraw;
end;
0:begin
map[i,j]:=0;
Fdraw;
end;
4:begin
map[i,j]:=4;
Fdraw;
end;
3:
if b then
begin
map[i,j]:=3;
Fdraw;
end else
begin
block:=0;
ShowMessage('The Game never use more then 1 player!');
end;
5:begin
map[i,j]:=5;
Fdraw;
end;
7:begin
map[i,j]:=7;
Fdraw;
end;

end;}
end;


procedure TForm1.Image2Click(Sender: TObject);
begin
block:=2;
proverka;
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
block:=0;proverka;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
f:TextFile;
i,j:integer;
str:string;
begin
SaveDialog1.Execute;
if SaveDialog1.FileName<>'' then
begin
AssignFile(f,SaveDialog1.FileName);
Rewrite(f);
i:=0;
repeat
i:=i+1;
for j:=1 to 16 do
str:=str+inttostr(map[i,j]);
Writeln(f,str);
str:='';
until i>=12;
CloseFile(f);
ShowMessage('Map-File Created!');
end;
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
block:=4;
proverka;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
if b then block:=3 else
begin
block:=0;
ShowMessage('The Game never use more then 1 player!');
end;
proverka;
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
block:=5;
proverka;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
i,j:integer;
str:string;
f:TextFile;
begin
OpenDialog1.Execute;
New1Click(Self);
if FileExists(OpenDialog1.FileName) then
begin
AssignFile(f,OpenDialog1.FileName);
reset(f);
i:=0;
repeat
readln(f,str);
for j:=0 to length(str)-1 do
map[i+1,j+1]:= strtoint(str[j+1]);
i:=i+1;
until eof(f);
CloseFile(f);
end;
Fdraw;
end;

procedure TForm1.Image8Click(Sender: TObject);
begin
block:=7;proverka;
end;

procedure TForm1.New1Click(Sender: TObject);
var
i,j:integer;
str:string;
f:TextFile;
begin
begin
AssignFile(f,ExtractFilePath(Application.ExeName)+ 'Default.mp');
reset(f);
i:=0;
repeat
readln(f,str);
for j:=0 to length(str)-1 do
map[i+1,j+1]:= strtoint(str[j+1]);
i:=i+1;
until eof(f);
CloseFile(f);
end;
Fdraw;
Map2.Enabled:=True;
Save1.Enabled:=True;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
Fdraw;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
Fdraw;
end;

procedure TForm1.Load1Click(Sender: TObject);
begin
Map2.Enabled:=true;
Button2Click(self);
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
Button1Click(self);
end;

procedure TForm1.Block1Click(Sender: TObject);
begin
Image1Click(self);
end;

procedure TForm1.Lestnica1Click(Sender: TObject);
begin
Image2Click(self);
end;

procedure TForm1.Player1Click(Sender: TObject);
begin
Image3Click(self);
end;

procedure TForm1.Ghost1Click(Sender: TObject);
begin
Image4Click(self);
end;

procedure TForm1.Door1Click(Sender: TObject);
begin
Image6Click(self);
end;

procedure TForm1.Cristal1Click(Sender: TObject);
begin
Image8Click(self);
end;

procedure TForm1.space1Click(Sender: TObject);
begin
Image5Click(self);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.DeleteAllMaps1Click(Sender: TObject);
begin
WinExec(pchar('DeleteMaps.bat'),SW_HIDE);
ShowMessage(ExtractFilePath(Application.ExeName)+'Maps\*.mp Deleted');
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
i,j:integer;
begin
for i:=1 to 12 do
for j:=1 to 16 do
zmap[i,j]:=map[i,j];
mos:=true;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
i,j,s,i1,j1:integer;
begin
if mos then begin
i:=y div 40+1;
j:=x div 40+1;
if ((i>1) and (i<12)) and ((j<16) and (j>1)) then
case block of
1:
map[i,j]:=1;
2:
map[i,j]:=2;
0:
map[i,j]:=0;
4:  Begin
  s:=0;
  for i1:=1 to 12 do
    for j1:=1 to 16 do
      if map[i1,j1]=4 then s:=s+1;
  if s<5 then map[i,j]:=4;
    End;
3:
if b then
map[i,j]:=3
else
begin
block:=0;   mos:=false;
ShowMessage('The Game never use more then 1 player!');
end;
5:map[i,j]:=5;
7:map[i,j]:=7;
8:map[i,j]:=8;
end;
Fdraw;
end;

end;
procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
mos:=false;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
var i,j:integer;
begin
end;

procedure TForm1.Undo1Click(Sender: TObject);

var i,j:integer;
begin
if not mos then
for i:=1 to 12 do
for j:=1 to 16 do
map[i,j]:=zmap[i,j];
Fdraw;
end;


procedure TForm1.N1Click(Sender: TObject);
begin
block:=8;
proverka;
end;

procedure TForm1.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
e:=nil;
end;

END.
