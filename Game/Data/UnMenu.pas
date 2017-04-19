unit UnMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MPlayer;

type
  Tmennu = class(TForm)
    procedure Active(Sender:TObject);
    procedure DeActive(Sender:TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
  procedure MenuDraw;
  procedure SaveMap;
    { Public declarations }
  end;

var
  d:boolean;
  mennu: Tmennu;
  b:TBitmap;
  mn:array [1..6] of string;
  i:integer;
  game:boolean;
implementation

uses Unit1, load;

{$R *.dfm}
function SetFullscreenMode:Boolean;
var DeviceMode : TDevMode;
begin
with DeviceMode do begin
dmSize:=SizeOf(DeviceMode);
dmBitsPerPel:=32;
dmPelsWidth:=800;
dmPelsHeight:=600;
dmFields:=DM_BITSPERPEL or DM_PELSWIDTH or DM_PELSHEIGHT;
result:=False;
if ChangeDisplaySettings(DeviceMode,CDS_TEST or CDS_FULLSCREEN) > DISP_CHANGE_SUCCESSFUL
then Exit;
Result:=ChangeDisplaySettings(DeviceMode,CDS_FULLSCREEN) = DISP_CHANGE_SUCCESSFUL;
end;
end;

procedure RestoreDefaultMode;
var T : TDevMode;
begin
 ChangeDisplaySettings(T,CDS_FULLSCREEN);
end;

procedure Tmennu.FormCreate(Sender: TObject);
var MP:string;
begin
Screen.Cursor:=crnone;
SetFullscreenMode;
MP:=ExtractFilePath(Application.ExeName);
AddFontResource(PChar(MP+'MICKEY.TTF'));
SendMessage(HWND_BroadCast,WM_FontChange,0,0);
Application.OnDeactivate:=DeActive;
Application.OnActivate:=Active;
d:=false;
DoubleBuffered:=true;
i:=1;
mn[1]:='Start Game';
mn[2]:='Save Game';
mn[3]:='Load Game';
mn[4]:='Exit Game';
b:=TBitmap.Create;b.Width:=800;b.Height:=600;
BorderStyle:=bsNone;
Height:=600;Width:=800;
Canvas.Font.Name:='Mickey';
Canvas.Font.Size:=32;
Canvas.Font.Color:=clWhite;
top:=0;left:=0;Color:=clBlack;
game:=false;
end;

procedure Tmennu.MenuDraw;
var dx,dy,di:integer;
begin
  b.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\menu.bmp');
  Canvas.Draw(0,0,b);
  dx:=250;dy:=125;di:=1;
  Canvas.Font.Color:=clWhite;
  repeat
  Canvas.TextOut(dx,dy,mn[di]);
  di:=di+1;dy:=dy+100;
  until di>4;
  b.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\arrow.bmp');
  Canvas.Draw(175,(i-1)*100+125,b);
  Canvas.Font.Color:=clSkyBlue;
  Canvas.TextOut(250,(i-1)*100+125,mn[i]);
end;

procedure Tmennu.FormPaint(Sender: TObject);
begin
MenuDraw;
end;

procedure Tmennu.FormKeyPress(Sender: TObject; var Key: Char);
begin
    case key of
#27:if mn[1]<>'Start Game' then
begin
  Form1.MobTimer.Enabled:=true;pause:=False;Form1.Show;
  if d then
  Form1.detonator.Enabled:=true;
  end;


's',#251:if i=4 then
begin
Canvas.Rectangle(175,(i-1)*100+125,175+50,(i-1)*100+125+50);
Canvas.Font.Color:=clWhite;
Canvas.TextOut(250,(i-1)*100+125,mn[i]);
i:=1;
Canvas.Font.Color:=clSkyBlue;
Canvas.TextOut(250,(i-1)*100+125,mn[i]);
Canvas.Draw(175,(i-1)*100+125,b);
end else
begin
Canvas.Rectangle(175,(i-1)*100+125,175+50,(i-1)*100+125+50);
Canvas.Font.Color:=clWhite;
Canvas.TextOut(250,(i-1)*100+125,mn[i]);
i:=i+1;
Canvas.Font.Color:=clSkyBlue;
Canvas.TextOut(250,(i-1)*100+125,mn[i]);
Canvas.Draw(175,(i-1)*100+125,b);
end;
'w',#246:if i=1 then
begin
Canvas.Rectangle(175,(i-1)*100+125,175+50,(i-1)*100+125+50);
Canvas.Font.Color:=clWhite;
Canvas.TextOut(250,(i-1)*100+125,mn[i]);
i:=4;
Canvas.Font.Color:=clSkyBlue;
Canvas.TextOut(250,(i-1)*100+125,mn[i]);
Canvas.Draw(175,(i-1)*100+125,b);
end else
begin
Canvas.Rectangle(175,(i-1)*100+125,175+50,(i-1)*100+125+50);
Canvas.Font.Color:=clWhite;
Canvas.TextOut(250,(i-1)*100+125,mn[i]);
i:=i-1;
Canvas.Font.Color:=clSkyBlue;
Canvas.TextOut(250,(i-1)*100+125,mn[i]);
Canvas.Draw(175,(i-1)*100+125,b);
end;


#13:case i of
  1:if mn[1]<>'Start Game' then
  begin
  b.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\menu.bmp');
  form1.image1.canvas.Draw(0,0,b);
  il:=0;xl:=0;pl.lifes:=pl.lifes-1;
  put:=ExtractFilePath(Application.ExeName)+'..\maps\level_'+inttostr(pl.level)+'\map.mp';
  Form1.MobTimer.Enabled:=false;mobs:=0;
  Form1.Show;Form1.LoadTimer.Enabled:=true;
    end else
    begin
  mn[1]:='Restart Round';
  game:=true;form1.FormCreate(Self);
  Form1.Show;Form1.LoadTimer.Enabled:=true;
  b.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\menu.bmp');
  form1.image1.canvas.Draw(0,0,b);
  end;

  4:close;
  2:if game or (mn[1]='Restart Round') then
  begin
  if d then begin Inc(pl.bombs);map[bi,bj]:=0;end;
  SaveMap;
  end;
  3:
  LoadForm.Show;
  end;
  end;
end;

procedure Tmennu.SaveMap;
var
s:string;
n,m1:integer;
f:TextFile;
fp:file of player;
fmob:file of m;
begin
AssignFile(f,ExtractFilePath(Application.ExeName)+'..\Saves\Level_'+inttostr(pl.level)+'.sav');
Rewrite(f);
m1:=1;
s:='';
repeat
for n:=1 to 16 do
s:=s+inttostr(map[m1,n]);
Writeln(f,s);
s:='';
m1:=m1+1;
until m1>12;
CloseFile(f);
pl.moblar:=mobs;
AssignFile(fp,ExtractFilePath(Application.ExeName)+'..\Saves\Level_'+inttostr(pl.level)+'.psav');
Rewrite(fp);
Write(fp,pl);
CloseFile(fp);
AssignFile(fmob,ExtractFilePath(Application.ExeName)+'..\Saves\Level_'+inttostr(pl.level)+'.msav');
Rewrite(fmob);
for n:=1 to mobs do      begin
Write(fmob,mob[n]);
end;
CloseFile(fmob);
ShowMessage('Игра успешно сохранена');
end;

procedure Tmennu.FormActivate(Sender: TObject);
begin
if form1.detonator.Enabled=true then
begin
d:=true;
form1.detonator.Enabled:=false;
end;
end;


procedure Tmennu.Active;
begin
pause:=false;
 if d then  begin
form1.detonator.Enabled:=true;
d:=not d;
end;
Form1.MobTimer.Enabled:=true;
end;

procedure Tmennu.DeActive;
begin
if form1.detonator.Enabled=true then
begin
d:=true;
form1.detonator.Enabled:=false;
end;
pause:=True;
Form1.MobTimer.Enabled:=False;
end;

procedure Tmennu.FormDestroy(Sender: TObject);
var MP:string;
begin
MP:=ExtractFilePath(Application.ExeName);
RemoveFontResource(PChar(MP+'MICKEY.TTF'));
SendMessage(HWND_BroadCast,WM_FontChange,0,0);
RestoreDefaultMode;
end;

procedure Tmennu.FormClose(Sender: TObject; var Action: TCloseAction);
var MP:string;
begin
MP:=ExtractFilePath(Application.ExeName);
RemoveFontResource(PChar(MP+'MICKEY.TTF'));
SendMessage(HWND_BroadCast,WM_FontChange,0,0);
end;

end.
