program Project1;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  SysUtils,
  Unit1 in 'Unit1.pas';

begin
  //Application.Title := 'FRScripter';
  //Application.Run;
  { Wird nur benötigt um Icon für Anwendung hinzuzufügen / ändern }

  { TODO -oUser -cConsole Main : Insert code here }
if ParamCount>0 then begin
   MyProg.Filename:= ParamStr(1);
   MyProg.Find:= ParamStr(2);
   Myprog.RType:= ParamStr(3);
   MyProg.Replace:= ParamStr(4);
   StartUp;
end;


if ParamCount=0 then begin
    WriteLn(Progver);
    WriteLn('');
    WriteLn('Commandline : FRScript.exe <File> <Find> <Typ> <Replace>');
    WriteLn('Example     : FRScript.exe c:\windows\Info.txt \%URL\% Text http:\\example.com');
    WriteLn('');
    WriteLn('<File>      : Read from File [Input]');
    WriteLn('<Find>      : RegEx-Format');
    WriteLn('<Typ>       : String-Format');
    WriteLn('<Replace>   : String-Format');
    WriteLn('');
    WriteLn('Spezial-Find:');
    WriteLn('<Find> = !DATE_1!  :  01.01.2008  [DD.MM.YYY]');
    WriteLn('<Find> = !DATE_2!  :  2008-01-01  [YYYY-MM-DD]');
    WriteLn('<Find> = !TIME_1!  :  12:01:22    [HH:MM:SS]');
    WriteLn('');

   end;
     
end.
