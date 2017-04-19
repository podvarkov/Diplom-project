unit load;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,ShellApi;

type
  TLoadForm = class(TForm)
    Image1: TImage;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure MobsLoad(s:string);
    { Public declarations }
  end;

var
  LoadForm: TLoadForm;
  LoadName:string[255];
implementation

uses Unit1, market, UnMenu;

{$R *.dfm}
function PlayerLoad(s:string):player;
var
f:file of player;
r:player;
begin
AssignFile(f,s);
reset(f);
read(f,r);
close(f);
Result:=r;
end;

procedure TLoadForm.MobsLoad(s:string);
var
i:integer;
f:file of m;
mb:m;
begin
AssignFile(f,s);
reset(f);
mobs:=pl.moblar;
for i:=1 to mobs do
begin
Read(f,mb);
mob[i]:=mb;
end;
CloseFile(f);
end;

procedure TLoadForm.Button1Click(Sender: TObject);
begin
if FileExists(ExtractFilePath(Application.ExeName)+'..\Saves\'+LoadName+ '.sav') then
  begin
  game:=false;
  mn[1]:='Restart Round';
  form1.FormCreate(Self);
  pl:=PlayerLoad(ExtractFilePath(Application.ExeName)+'..\Saves\'+LoadName+'.psav');
  MobsLoad(ExtractFilePath(Application.ExeName)+'..\Saves\'+LoadName+'.msav');
  put:=ExtractFilePath(Application.ExeName)+'..\Saves\level_'+inttostr(pl.level) +'.sav';
  Form1.Show;Form1.LoadTimer.Enabled:=true;
  b.LoadFromFile(ExtractFilePath(Application.ExeName)+'..\images\menu\menu.bmp');
  form1.image1.canvas.Draw(0,0,b);
  end;
Close;
end;

procedure TLoadForm.FormActivate(Sender: TObject);
var
i:integer;
rec:TSearchRec;
s:string;
begin
Screen.Cursors[1]:=LoadCursorFromFile(pchar(ExtractFilePath(Application.ExeName)+'hand.cur'));
screen.Cursor:=1;
ListBox1.Clear;
i:=FindFirst(ExtractFilePath(Application.ExeName)+'..\Saves\*.sav',faAnyFile,rec);
repeat
s:=rec.Name;
Delete(s,length(s)-3,length(s));
ListBox1.Items.Add(s);
i:=FindNext(rec);
until i<>0;
mennu.Enabled:=false;
end;

procedure TLoadForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
mennu.Enabled:=true;
screen.Cursor:=crNone;
end;

procedure TLoadForm.FormCreate(Sender: TObject);
begin
ListBox1.OnDblClick:=Button1Click;
end;

procedure TLoadForm.Button2Click(Sender: TObject);
var st:string;
begin
st:=ExtractFilePath(Application.ExeName)+'..\Saves\'+LoadName;
DeleteFile(st+'.sav');
DeleteFile(st+'.psav');
DeleteFile(st+'.msav');
FormActivate(self);
end;

procedure TLoadForm.ListBox1Click(Sender: TObject);
begin
LoadName:=ListBox1.Items[ListBox1.ItemIndex];
end;

end.
