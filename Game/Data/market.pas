unit market;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  Tmagazin = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Image9: TImage;
    Image10: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Image11: TImage;
    Image12: TImage;
    Label6: TLabel;
    Label9: TLabel;
    Image13: TImage;
    Image14: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Button5: TButton;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image15Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  magazin: Tmagazin;

implementation

uses Unit1, DateUtils, UnMenu, load;

{$R *.dfm}

procedure Tmagazin.FormCreate(Sender: TObject);
var a:integer;
begin
BorderStyle:=bsNone;
top:=Form1.Top+50;Left:=Form1.Left+50;
Width:=700;Height:=500;
Image15.Top:=400;Image15.Left:=600;
end;

procedure Tmagazin.FormActivate(Sender: TObject);
begin
Screen.Cursors[1]:=LoadCursorFromFile(pchar(ExtractFilePath(Application.ExeName)+'hand.cur'));
Screen.Cursor:=1;
if form1.detonator.Enabled=true then
begin
d:=true;
form1.detonator.Enabled:=false;
end;
Form1.Enabled:=False;
top:=Form1.Top+50;Left:=Form1.Left+50;
Label7.Caption:='x '+inttostr(pl.points);
Label8.Caption:='x '+inttostr(pl.mobkill);
Label1.Caption:='x '+inttostr(pl.bombs);
Label2.Caption:='x '+inttostr(pl.lifes);
Label3.Caption:='x '+inttostr(pl.frtime);
end;

procedure Tmagazin.Button1Click(Sender: TObject);
begin
if (pl.points>=5) and (pl.mobkill>=1) then
With pl do
begin
points:=points-5;
mobkill:=mobkill-1;
bombs:=bombs+1;
Form1.sound('cash.wav');
FormActivate(Self);
end;
end;

procedure Tmagazin.Button2Click(Sender: TObject);
begin
if pl.bombs>=1 then
With pl do
begin
points:=points+5;
mobkill:=mobkill+1;
bombs:=bombs-1;
Form1.sound('cash.wav');
FormActivate(Self);
end;
end;

procedure Tmagazin.Button3Click(Sender: TObject);
begin
if (pl.points>=10) and (pl.mobkill>=2) then
With pl do
begin
points:=points-10;
mobkill:=mobkill-2;
lifes:=lifes+1;
Form1.sound('cash.wav');
FormActivate(Self);
end;
end;

procedure Tmagazin.Button4Click(Sender: TObject);
begin
 if pl.lifes>=2 then
With pl do
begin
points:=points+10;
mobkill:=mobkill+2;
lifes:=lifes-1;
Form1.sound('cash.wav');
FormActivate(Self);
end;
end;

procedure Tmagazin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.MobTimer.Enabled:=True;
pause:=false;
if d then form1.detonator.Enabled:=true;
end;

procedure Tmagazin.Image15Click(Sender: TObject);
begin
Form1.Enabled:=true;
Close;
end;

procedure Tmagazin.Button5Click(Sender: TObject);
begin
 if (pl.points>=5) and (pl.mobkill>=2) then
With pl do
begin
points:=points-5;
mobkill:=mobkill-2;
frtime:=frtime+1;
Form1.sound('cash.wav');
FormActivate(Self);
end;
end;

procedure Tmagazin.Button6Click(Sender: TObject);
begin
 if pl.frtime>=1 then
With pl do
begin
points:=points+5;
mobkill:=mobkill+2;
frtime:=frtime-1;
Form1.sound('cash.wav');
FormActivate(Self);
end;
end;

procedure Tmagazin.FormDeactivate(Sender: TObject);
begin
Screen.Cursor:=crNone;
end;
end.
