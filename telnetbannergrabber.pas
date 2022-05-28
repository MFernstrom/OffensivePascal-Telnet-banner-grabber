program telnetbannergrabber;

{
  About             Telnet banner grabber. Metasploitable 2 has some sensitive information in a telnet banner on port 23
  Requirements      Synapse - Install through OPM
  License           Apache 2.0
  Author            Marcus Fernstrom
}

uses
  tlntsend, sysutils;

var
  Sock: TTelnetSend;
  Str: String;
  start: Integer;
begin
  if paramCount <> 2 then writeln('Usage ./gettelnetbanner <target ip> <target port>') else begin

    Sock := TTelnetSend.Create;
    try
      Sock.TargetPort := ParamStr(2);
      Sock.TargetHost := ParamStr(1);
      Sock.Timeout := 1000;
      Sock.Login;
      str := #13;
      start := GetTickCount64;
      while GetTickCount64 < (start + 500) do begin
        str := Sock.RecvString;
        writeln(str);
      end;
      Sock.Logout;
    finally
      Sock.Free;
    end;
  end;
end.
