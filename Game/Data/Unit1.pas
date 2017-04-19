unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, MPlayer, AppEvnts;

type
  TForm1 = class(TForm)
    MobTimer: TTimer;
    LoadTimer: TTimer;
    MediaPlayer1: TMediaPlayer;
    Timer1: TTimer;
    detonator: TTimer;
    frtime: TTimer;
    Image1: TImage;
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure MobTimerTimer(Sender: TObject);
    procedure LoadTimerTimer(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure detonatorTimer(Sender: TObject);
    procedure frtimeTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
    { Private declarations }
  public
  procedure sound(s:string);
  procedure zarisovka(ni,nj,ki,kj:integer);
  procedure MobCreate(i:integer);
  procedure MobDraw(w:integer);
  procedure Fmap(st:string);
  procedure FDraw;
  procedure PlayerCreate;
  procedure TbCreate;
  procedure PlayerMove;
    { Public declarations }
  end;
type
player=record
j,i,nap,x,y,level:integer;
moblar,points,mobkill,lifes,frtime,bombs:integer;
door,pos:boolean;
end;
m=record
j,i,nap,x,y:integer;
pos:boolean;
end;

var
  put:string;
  PlPic:TBitmap;
  MobPic:array [1..10] of TBitmap;
  Form1: TForm1;
  level,il,xl,j,bj,bi:integer;
  map:array [1..26,1..20] of integer;
  mob:array [1..5] of m;
  mobs:integer;
  tb:TBitmap;
  pl:player;
  pause:boolean;
implementation

uses market, UnMenu;





{$R *.dfm}
procedure TForm1.zarisovka(ni,nj,ki,kj:integer);
var path:string;
i,j:integer;
begin
path:=ExtractFilePath(Application.ExeName)+'..\images\';
i:=ni;
repeat
for j:=nj to kj do
case map[i+1,j+1] of
9:begin tb.LoadFromFile(path+'sunduk.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
8:begin tb.LoadFromFile(path+'d_key.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
7:begin tb.LoadFromFile(path+'skull.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
1:begin tb.LoadFromFile(path+'kirpich_1.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
2:begin tb.LoadFromFile(path+'lest.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
0:image1.canvas.Rectangle(j*50,i*50,j*50+50,i*50+50);
5:begin tb.LoadFromFile(path+'door.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
6:begin tb.LoadFromFile(path+'bomba.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
end;
i:=i+1;
until i>ki;
  end;

  procedure TForm1.MobCreate(i:integer);
begin
MobPic[i]:=TBitmap.Create;
if pl.j>mob[i].j then mob[i].nap:=2 else mob[i].nap:=1;
with MobPic[i]  do
begin
Height:=50;
Width:=50;
Transparent:=true;
TransparentColor:=clFuchsia;
LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\mob_1.1.bmp');
  end;
  end;

      procedure TForm1.TbCreate;
begin
tb:=TBitmap.Create;
with tb do
begin
Transparent:=true;
TransparentColor:=clFuchsia;
Width:=50;
Height:=50;
end;
end;

  procedure TForm1.Fmap(st:string);
var
i,j:integer;
str:string;
f:TextFile;
begin
AssignFile(f,st);
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

procedure TForm1.PlayerMove;
var a,a1:integer;
begin
with pl do
begin
PlPic.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\player_'+inttostr(nap)+'.bmp');
case nap of
 2:
if (map[i,j+1]<>1) and (y+50=i*50) then
begin
x:=x+10;
j:=x div 50+1;
if map[i,j]=7 then
begin pl.points:=pl.points+1;
map[i,j]:=0;
sound('found_item.wav');
end;
j:=x div 50+1;
if map[i,j]=8 then
begin
door:=true;
map[i,j]:=0;
sound('found_item.wav');
end;
zarisovka(i-1,j-2,i-1,j);
end;
1:  begin
  if  ((map[i,j-1]=9) and (y+50=i*50)) or ((map[i,j-1]=8) and (y+50=i*50)) or (((map[i,j-1]=0) or (x+50>j*50)) and (y=i*50-50)) or ((map[i,j-1]=2) and (y=i*50-50)) or ((map[i,j-1]=5) and (y=i*50-50)) or ((map[i,j-1]=7) and (y=i*50-50)) then
begin
x:=x-10;
j:=x div 50;
if x mod 50=0 then
begin
j:=x div 50+1;
if map[i,j]=7 then
begin
pl.points:=pl.points+1;
map[i,j]:=0;
sound('found_item.wav');
end;
end;
if x mod 50=0 then
begin
j:=x div 50+1;
if map[i,j]=8 then
begin
door:=true;
map[i,j]:=0;
sound('found_item.wav');
end;
end;

zarisovka(i-1,j-1,i-1,j+1);
  end;
END;
  3:  if ((map[i,j]=2) and (map[i-1,j]<>1) and (x=(j-1)*50)) or (y+50>i*50) then
begin
y:=y-10;
i:=y div 50+1;
if y mod 50=0 then
    begin
i:=y div 50+1;
if map[i,j]=7 then
begin
pl.points:=pl.points+1;
map[i,j]:=0;
sound('found_item.wav');
end;
    end;
if y mod 50=0 then
    begin
i:=y div 50+1;
if map[i,j]=8 then
begin
pl.door:=true;
map[i,j]:=0;
sound('found_item.wav');
end;
    end;

if y mod 50=0 then i:=y div 50+1;
zarisovka(i-2,j-1,i,j-1);
 end;

   4:  if ((map[i+1,j]=2) and (x=(j-1)*50)) or (y>i*50) then
begin
y:=y+10;
i:=y div 50+1;
zarisovka(i-2,j-1,i+1,j-1);
  end;

end;
     image1.canvas.Draw(pl.x,pl.y,PlPic);
     
for a1:=1 to mobs do
if (((pl.x+40>mob[a1].x) and (pl.x+50<=mob[a1].x+50)) or ((pl.x>=mob[a1].x) and (pl.x<mob[a1].x+40))) and (((pl.y+50>mob[a1].y) and (pl.y+50<mob[a1].y+50)) or ((pl.y>mob[a1].y) and (pl.y<mob[a1].y+50) or (pl.y=mob[a1].y)))  then
begin
Image1.Canvas.Draw(pl.x,pl.y,PlPic);
detonator.Enabled:=false;
mobtimer.Enabled:=false;
pause:=true;
pl.lifes:=pl.lifes-1;
sound('lose1.wav');
Sleep(2000);
b.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\menu.bmp');
image1.canvas.Draw(0,0,b);
put:=ExtractFilePath(Application.ExeName)+'..\maps\level_'+inttostr(pl.level)+'\map.mp';
il:=0;xl:=0;mobs:=0;
loadtimer.Enabled:=true;
Exit;
end;


for a:=1 to 20 do
begin
  if (((map[i+1,j]=0) or (map[i+1,j]=5) or (map[i+1,j]=6) or (map[i+1,j]=7) or (map[i+1,j]=8) or (map[i+1,j]=9)) and (x+50=j*50)) or ( (map[i,j]=2) and (map[i+1,j]=0)) then
  Begin
j:=x div 50+1;
if map[i+1,j]=8 then
begin
pl.door:=true;
map[i+1,j]:=0;
sound('found_item.wav');
end;
if map[i+1,j]=7 then
begin
pl.points:=pl.points+1;
map[i+1,j]:=0;
sound('found_item.wav');
end;
y:=y+50;
i:=y div 50+1;
zarisovka(i-2,j-1,i+1,j-1);
image1.canvas.Draw(pl.x,pl.y,PlPic);
for a1:=1 to mobs do
if (((pl.x+40>mob[a1].x) and (pl.x+50<=mob[a1].x+50)) or ((pl.x>=mob[a1].x) and (pl.x<mob[a1].x+40))) and (((pl.y+50>mob[a1].y) and (pl.y+50<mob[a1].y+50)) or ((pl.y>mob[a1].y) and (pl.y<mob[a1].y+50) or (pl.y=mob[a1].y)))  then
begin
PlayerMove;
exit;
end;
  End;
for a1:=1 to mobs do
if (mob[a1].j-pl.j<=3) then image1.canvas.Draw(mob[a1].x,mob[a1].y,MobPic[a1]);
end;end;


    END;
procedure TForm1.FDraw;
var
path:string;
i,j:integer;
begin
image1.canvas.Rectangle(50,50,Width-50,Height-50);
path:=ExtractFilePath(Application.ExeName)+'..\images\';
i:=0;
repeat
for j:=0 to 15 do begin
case map[i+1,j+1] of
9:begin tb.LoadFromFile(path+'sunduk.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
8:begin pl.door:=false;tb.LoadFromFile(path+'d_key.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
7:begin tb.LoadFromFile(path+'skull.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
1:begin tb.LoadFromFile(path+'kirpich_1.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
2:begin tb.LoadFromFile(path+'lest.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
0:image1.canvas.Rectangle(j*50,i*50,j*50+50,i*50+50);
3:begin pl.x:=j*50;pl.y:=i*50;pl.i:=i+1;pl.j:=j+1;image1.canvas.Draw(j*tb.Width,i*tb.Height,PlPic);map[i+1,j+1]:=0; end;
4:  begin
mobs:=mobs+1;
mob[mobs].x:=j*50;
mob[mobs].y:=i*50;
mob[mobs].i:=i+1;
mob[mobs].j:=j+1;
image1.canvas.Draw(j*50,i*50,MobPic[mobs]);
map[i+1,j+1]:=0;
    end;
5:begin tb.LoadFromFile(path+'door.bmp');image1.canvas.Draw(j*tb.Width,i*tb.Height,tb);end;
end;
//Sleep(15);
end;
i:=i+1;
until i>12;
MobTimer.Enabled:=true;
pause:=false;
Image1.Canvas.Draw(pl.x,pl.y,PlPic);
for i:=1 to mobs do
Image1.Canvas.Draw(mob[i].x,mob[i].y,mobpic[i]);
  end;

  procedure TForm1.PlayerCreate;
begin
pl.bombs:=3;
pl.mobkill:=0;
pl.door:=false;
pl.lifes:=2;
pl.frtime:=1;
pl.level:=1;
PlPic:= TBitmap.Create;
with PlPic do begin
Height:=50;
Width:=50;
Transparent:=true;
TransparentColor:=clFuchsia;
LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\player_2.bmp');
end;
  end;

  procedure TForm1.FormCreate(Sender: TObject);
  var i:integer;
begin
pause:=true;
Image1.Canvas.Brush.Color:=clBlack;
j:=0;
mobs:=0;
DoubleBuffered:=true;
BorderStyle:=bsNone;
Width:=800;Height:=600;
for i:=1 to 5 do
MobCreate(i);
PlayerCreate;
TbCreate;
put:=ExtractFilePath(Application.ExeName)+'..\maps\level_'+inttostr(pl.level)+'\map.mp';
image1.canvas.Font.Size:=30;
image1.canvas.Font.Color:=clSkyBlue;
image1.canvas.Font.Name:='Mickey';
il:=0;xl:=0;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
if not pause then
case key of
#27: begin
mennu.Show;
MobTimer.Enabled:=false;pause:=true;
  end;
#32:FormDblClick(self);
#98,#232:begin
magazin.Show;MobTimer.Enabled:=false;pause:=true;
 end;

#102,#224:if (pl.frtime>0) and (frtime.Enabled=false)  then
begin
MobTimer.Enabled:=false;frtime.Enabled:=true;
pl.frtime:=pl.frtime-1;
end;
#100,#226:begin pl.nap:=2;PlayerMove;end;
#97,#244:begin pl.nap:=1;PlayerMove;end;
#119,#246:begin pl.nap:=3;PlayerMove;end;
#115,#251:begin pl.nap:=4;PlayerMove;end;
{enter}#13:if (pl.door) and (map[pl.i,pl.j]=5) then
begin
MobTimer.Enabled:=false;
pause:=true;
pl.level:=pl.level+1;
sound('fanfare1.wav');
Sleep(2000);
 b.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\menu.bmp');
 image1.canvas.Draw(0,0,b);
il:=0;xl:=0;mobs:=0;
put:=ExtractFilePath(Application.ExeName)+'..\maps\level_'+inttostr(pl.level)+'\map.mp';
LoadTimer.Enabled:=true;
end;

end;
end;

  procedure TForm1.MobDraw(w:integer);
var
b:integer;
BEGIN
with mob[w] do
begin
if pos then MobPic[w].LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\mob_1.1.bmp')
else MobPic[w].LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\mob_1.2.bmp');
case nap of
 2:      begin
if (map[i,j+1]<>1) and (y+50=i*50) and (map[i,j+1]<>6) then
begin
pos:=not pos;
x:=x+10;
j:=x div 50;;
if x mod 50=0 then j:=x div 50+1;
zarisovka(i-1,j-2,i-1,j+1);
end else  begin nap:=1;zarisovka(i-1,j-2,i-1,j+1); end;
end;
  1:  begin
   if (((map[i,j-1]=0) or (x+50>j*50)) and (y+50=i*50)) or (map[i,j-1]=2) or (map[i,j-1]=8) or (map[i,j-1]=5) or (map[i,j-1]=7) then
begin
pos:=not pos;
x:=x-10;
j:=x div 50+1;
if x mod 50=0 then j:=x div 50+1;
zarisovka(i-1,j-1,i-1,j);
end else begin nap:=2;zarisovka(i-1,j-1,i-1,j);end;
end;
  end;
image1.canvas.Draw(x,y,MobPic[w]);
if (j-pl.j<=3) then image1.canvas.Draw(pl.x,pl.y,PlPic);
for b:=1 to mobs do
if (j-mob[b].j<=3) then image1.canvas.Draw(mob[b].x,mob[b].y,MobPic[b]);
if (((pl.x+40>x) and (pl.x+50<x+50)) or ((pl.x>x) and (pl.x<x+40))) and (((pl.y+50>y) and (pl.y+50<y+50)) or ((pl.y>y) and (pl.y<y+50) or (pl.y=y)))  then
begin
detonator.Enabled:=false;
MobTimer.Enabled:=false;
pause:=true;
pl.lifes:=pl.lifes-1;
sound('lose1.wav');
Sleep(2000);
tb.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\menu.bmp');
image1.canvas.Draw(0,0,tb);
put:=ExtractFilePath(Application.ExeName)+'..\maps\level_'+inttostr(pl.level)+'\map.mp';
il:=0;xl:=0;mobs:=0;
LoadTimer.Enabled:=true;
end;
   end;

END;




procedure TForm1.MobTimerTimer(Sender: TObject);
var
i:integer;
begin
for i:=1 to mobs do
if pause then break else MobDraw(i);
end;

procedure TForm1.LoadTimerTimer(Sender: TObject);
var
str:string;
begin
if not FileExists(ExtractFilePath(Application.ExeName)+'..\maps\level_'+inttostr(pl.level)+'\map.mp') then
  begin
str:='YOU WIN';
il:=il+1;
image1.canvas.TextOut(250+xl,250,str[il]);
xl:=xl+50;
if il>Length(str) then
begin
LoadTimer.Enabled:=false;
mn[1]:='Start Game';game:=false;Hide;
end;
end;
if FileExists(ExtractFilePath(Application.ExeName)+'..\maps\level_'+inttostr(pl.level)+'\map.mp') then
BEGIN
if pl.lifes>0 then
  begin
str:='LEVEL-'+inttostr(pl.level);
il:=il+1;
image1.canvas.TextOut(250+xl,250,str[il]);
xl:=xl+50;
if il=Length(str)+1 then
begin
Fmap(put);
FDraw;
LoadTimer.Enabled:=false;
end;
  end else
  begin
str:='GAME OVER';
il:=il+1;
image1.canvas.TextOut(250+xl,250,str[il]);
xl:=xl+50;
if il>Length(str) then
begin
LoadTimer.Enabled:=false;
mn[1]:='Start Game';game:=false;Hide;
end;
  end;
END;
end;

procedure TForm1.FormDblClick(Sender: TObject);
var a,a1:integer;
begin
tb.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\bomba.bmp');
if pl.bombs<>0 then
if (pl.x mod 50=0) then
begin
  case pl.nap of
2:if (map[pl.i,pl.j+1]<>1) and (map[pl.i,pl.j+1]<>2) and (map[pl.i,pl.j+1]<>5) and (map[pl.i,pl.j+1]<>8) then
begin
image1.canvas.Draw(pl.j*tb.Width,(pl.i-1)*tb.Height,tb);
bi:=pl.i;bj:=pl.j+1;
pl.bombs:=pl.bombs-1;
map[bi,bj]:=6;
for a1:=1 to mobs do
if (bi=mob[a1].i) and ((bj=mob[a1].j) or (bj+1=mob[a1].j) or (bj-1=mob[a1].j) ) then
Image1.Canvas.Draw(mob[a1].x,mob[a1].y,MobPic[a1]);
sound('miss.wav');
for a:=1 to 16 do
  if (map[bi+1,bj]=0) then
begin
tb.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\bomba.bmp');
Sleep(10);
map[bi,bj]:=0;
bi:=bi+1;
map[bi,bj]:=6;
Sleep(5);
Application.ProcessMessages;
image1.canvas.Draw((bj-1)*50,(bi-1)*50,tb);
zarisovka(bi-2,bj-1,bi-1,bj-1);
for a1:=1 to mobs do
if (bi-1=mob[a1].i) or (bi=mob[a1].i) then Image1.Canvas.Draw(mob[a1].x,mob[a1].y,MobPic[a1]);
  end;
detonator.Enabled:=true;
end;

1:if (map[pl.i,pl.j-1]<>1) and (map[pl.i,pl.j-1]<>2) and (map[pl.i,pl.j-1]<>2) and (map[pl.i,pl.j-1]<>5) then
begin
image1.canvas.Draw((pl.j-2)*tb.Width,(pl.i-1)*tb.Height,tb);
map[pl.i,pl.j-1]:=6;
bi:=pl.i;bj:=pl.j-1;
pl.bombs:=pl.bombs-1;
for a1:=1 to mobs do
if (bi=mob[a1].i) and ((bj=mob[a1].j) or (bj+1=mob[a1].j) or (bj-1=mob[a1].j) ) then
Image1.Canvas.Draw(mob[a1].x,mob[a1].y,MobPic[a1]);
sound('miss.wav');
for a:=1 to 16 do
  if (map[bi+1,bj]=0) then
begin
tb.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\bomba.bmp');
Sleep(10);
map[bi,bj]:=0;
bi:=bi+1;
map[bi,bj]:=6;
Sleep(10);
Application.ProcessMessages;
image1.canvas.Draw((bj-1)*50,(bi-1)*50,tb);
zarisovka(bi-2,bj-1,bi-1,bj-1);
for a1:=1 to mobs do
if (bi-1=mob[a1].i) or (bi=mob[a1].i) then Image1.Canvas.Draw(mob[a1].x,mob[a1].y,MobPic[a1]);
  end;

detonator.Enabled:=true;
end;
  end;

end;
end;
procedure TForm1.Timer1Timer(Sender: TObject);
var m:integer;
begin
detonator.Enabled:=false;
tb.TransparentColor:=clBlack;
j:=j+1;
image1.canvas.Rectangle((bj-1)*50,(bi-1)*50,(bj)*50,(bi)*50);
tb.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\explosion\'+inttostr(j)+'.bmp');
image1.canvas.Draw((bj-2)*50,(bi-1)*50,tb);
image1.canvas.Draw((bj)*50,(bi-1)*50,tb);
image1.canvas.Draw((bj-1)*50,(bi-1)*50,tb);
map[bi,bj]:=0;
    for m:=1 to mobs do begin
if ((mob[m].x+50>(bj-2)*50) and (mob[m].x<=(bj-2)*50)) and (mob[m].i=bi) then
begin
tb.TransparentColor:=clFuchsia;
zarisovka(bi-1,bj-3,bi-1,bj);
mob[m].j:=-100;mob[m].i:=-100;
mob[m].y:=-100;
pl.mobkill:=pl.mobkill+1;
end;
if ((mob[m].x<(bj+1)*50) and (mob[m].x+50>=(bj+1)*50)) and (mob[m].i=bi) then
begin
tb.TransparentColor:=clFuchsia;
zarisovka(bi-1,bj-2,bi-1,bj+1);
mob[m].j:=-100;mob[m].i:=-100;
mob[m].y:=-100;
pl.mobkill:=pl.mobkill+1;
end;
if ((mob[m].x>=(bj-2)*50) and (mob[m].x+50<=(bj+1)*50)) and (mob[m].i=bi) then
begin
tb.TransparentColor:=clFuchsia;
zarisovka(bi-1,bj-2,bi-1,bj);
mob[m].j:=-100;mob[m].i:=-100;
mob[m].y:=-100;
pl.mobkill:=pl.mobkill+1;
end;

    end;

if j=7 then begin
if ((pl.x+50>(bj-2)*50) and (pl.x<=(bj-2)*50)) and (pl.i=bi)
or ((pl.x+50>(bj-1)*50) and (pl.x<=(bj-1)*50)) and (pl.i=bi) then
begin
tb.TransparentColor:=clFuchsia;
mobtimer.Enabled:=false;
Timer1.Enabled:=false;
pause:=true;
pl.lifes:=pl.lifes-1;
sound('lose1.wav');
Sleep(2000);
b.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\menu.bmp');
image1.canvas.Draw(0,0,b);
il:=0;xl:=0;mobs:=0;
put:=ExtractFilePath(Application.ExeName)+'..\maps\level_'+inttostr(pl.level)+'\map.mp';
loadtimer.Enabled:=true;
end else
if ((pl.x<(bj+1)*50) and (pl.x+50>=(bj+1)*50)) and (pl.i=bi)
or ((pl.x<(bj)*50) and (pl.x+50>=(bj)*50)) and (pl.i=bi)
 then
begin
tb.TransparentColor:=clFuchsia;
Timer1.Enabled:=false;
mobtimer.Enabled:=false;
pause:=true;
pl.lifes:=pl.lifes-1;
sound('lose1.wav');
Sleep(2000);
b.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\menu.bmp');
image1.canvas.Draw(0,0,b);
put:=ExtractFilePath(Application.ExeName)+'..\maps\level_'+inttostr(pl.level)+'\map.mp';
il:=0;xl:=0;mobs:=0;
loadtimer.Enabled:=true;
end else begin
tb.TransparentColor:=clFuchsia;
zarisovka(bi-1,bj-2,bi-1,bj);
Timer1.Enabled:=false;
end;
end;
end;

procedure TForm1.detonatorTimer(Sender: TObject);
begin
j:=0;
sound('explosion.wav');
Timer1.Enabled:=True;
end;

procedure TForm1.sound(s: string);
begin
MediaPlayer1.Close;
MediaPlayer1.FileName:=ExtractFilePath(Application.ExeName)+'..\Sound\'+s;
MediaPlayer1.Open;
MediaPlayer1.Play;
end;


procedure TForm1.frtimeTimer(Sender: TObject);
begin
MobTimer.Enabled:=true;
frtime.Enabled:=false;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.MainForm.Close;
end;

procedure TForm1.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
e:=nil;
end;

end.




