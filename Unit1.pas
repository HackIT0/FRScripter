unit Unit1;

interface
   uses PerlRegEx,Classes;


type x1 = record
     Filename: String;                   { Dateiname der Textdatei -- Lesen }
     Filename2: String;                  { Dateiname der Textdatei -- Speichern }
     Find: String;                       { Suchstring - REGEX }
     RType: String;                      { Ersetzungstyp }
     Replace: String;                    { Ersetzen mit }
end;

var myprog: x1;                       // Programinterne, globale Variablen
    Scanfile: TStringList;               { enthält die Textdatei }


    
{Konstanden ...}
const
   Progver=#201 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +
   #205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +
   #205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#187 +#10+ #13 +
   #186 + '          FRScripter 0.0.1.1        ' +#186 + #10 +#13+
   #186 + '     ' + #184 + ' 2008 - 2017 by Remo M' + #129 +'ller   ' + #186 +#10 +#13+
   #186 + '               Freeware             ' +#186 +#10 +#13 +
   #200 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +
   #205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +
   #205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#205 +#188 +#10 + #13;

   Filever='0.0.1.2';
   Datever='Build: 1';

{Prozeduren / Funktionen}
Procedure StartUp;
Procedure SPWords;
procedure SPWords_Text;
procedure SPWords_Date;
procedure SPWords_Date2;
procedure SPWords_MID;
procedure SPWords_Time;


implementation
uses SysUtils, synautil, synacode, DateUtils, Windows;

// -----------[ Programmstart ]-------------------------------------------------
Procedure StartUp;
var
   RegExRes: Boolean;
   MyRegEx: TPerlRegEx;                 { RegEx-Komponente }
begin
Scanfile:= TStringList.Create;             // Liste initalisieren
MyRegEx:= TPerlRegEx.Create(nil);       { RegEx initalisieren }
MyRegEx.Options:=[preCaseLess];
Scanfile.LoadFromFile(Myprog.Filename);
SPWords;

MyRegEx.Subject    := Scanfile.Text;
MyRegEx.RegEx      := MyProg.Find;
//MyRegEx.Replacement:= MyProg.Replace;

RegExRes:= MyRegEx.Match;

If RegExRes=True then begin
   MyRegEx.Subject    := Scanfile.Text;
   MyRegEx.RegEx      := MyProg.Find;
   MyRegEx.Replacement:= MyProg.Replace;
   MyRegEx.ReplaceAll;
   Scanfile.Clear;
   Scanfile.Text:= MyRegEx.Subject;
   Scanfile.SaveToFile(MyProg.Filename);
  end;




Scanfile.Free;
MyRegEx.Free;

end;

// -----------------------------------------------------------------------------
Procedure SPWords;
// Spezial Worte suchen und Ersetzen ...
begin
if Myprog.RType=Uppercase('TEXT')  then SPWords_Text;
if Myprog.RType=Uppercase('DATE')  then SPWords_Date;
if Myprog.RType=Uppercase('DATE2') then SPWords_Date2;
if Myprog.RType=Uppercase('MID')   then SPWords_MID;
if Myprog.RType=Uppercase('TIME')  then SPWords_Time;

//If MyProg.Replace='!DATE_1!' then MyProg.Replace:=DateToStr(Date);
//If MyProg.Replace='!DATE_2!' then MyProg.Replace:=FormatDateTime('YYYY-MM-DD',Date);
//If MyProg.Replace='!DATE_3!' then MyProg.Replace:=Rfc822DateTime(Date);
//If MyProg.Replace='!TIME_1!' then MyProg.Replace:=TimeToStr(Time);

end;

//-----[Typ: Text]--------------------------------------------------------------
procedure SPWords_Text;
begin
// Myprog.Type: TEXT
// Keine Änderungen vornehmen.
end;

//-----[Typ: Date]--------------------------------------------------------------
procedure SPWords_Date;
begin
// Myprog.Type: DATE
If MyProg.Replace='!DATE_1!' then MyProg.Replace:=DateToStr(Date);
If MyProg.Replace='!DATE_2!' then MyProg.Replace:=FormatDateTime('YYYY-MM-DD', Date);
If MyProg.Replace='!DATE_3!' then MyProg.Replace:=Rfc822DateTime(Date);
end;

//-----[Typ: Time]--------------------------------------------------------------
procedure SPWords_Time;
begin
If MyProg.Replace='!TIME_1!' then MyProg.Replace:=TimeToStr(Time);
end;

//-----[Typ: Date2]--------------------------------------------------------------
procedure SPWords_Date2;
var
  temp: String;
begin
// Myprog.Type: DATE2 -> z.B. Fri, 1 Dec 2017
  temp:= Rfc822DateTime(strtodatetime(Myprog.Replace));
  MyProg.Replace:= Copy(temp,0,15);
end;

//-----[Typ: MID]--------------------------------------------------------------
procedure SPWords_MID;
var
   crypted1: string;
   a: Integer;
   tmp: String;
begin
crypted1:= synacode.HMAC_MD5(IntToStr(DateTimeToUnix(now)),IntToStr(Random(10000)));
tmp := Myprog.Replace;
a:=Length(tmp);

if a=0 then  MyProg.Replace:= Synautil.StrToHex(crypted1);
if a>0 then  MyProg.Replace:= Synautil.StrToHex(crypted1) + '@' + tmp;
end;


end.
