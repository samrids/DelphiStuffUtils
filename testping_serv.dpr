 program testping_serv;
{$DEFINE NOLINENOTIFY}

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
  ShellApi,
  Windows,
  {$IFDEF LINENOTIFY}
   AwLineNotify in 'AwLineNotify.pas',
   LineAPI in 'LineAPI.pas',
  {$ENDIF}
  Inifiles;

const
  ResultStr: array [0 .. 2] of string =
   ('Destination host unreachable',
    'Request timed out.',
    'Online'
   );

var
  i: Cardinal;
  ipaddr, tmpPing, resultPing: TStrings;
  j: byte;
  rStr: string;
  {$IFDEF LINENOTIFY}TOKEN: string;{$ENDIF}

procedure LogMsg(const AFilename, AMessage: string);
var
  f: TextFile;
begin
  try
    AssignFile(f, AFilename);
    if FileExists(AFilename) then
      Append(f)
    else
      ReWrite(f);
    WriteLn(f, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now), ' ', AMessage);
    CloseFile(f);
  except
  end;
end;

function ExecAndWait(APath: string; var VProcessResult: Cardinal): boolean;
var
  LWaitResult: integer;
  LStartupInfo: TStartupInfo;
  LProcessInfo: TProcessInformation;
begin
  Result := False;

  FillChar(LStartupInfo, SizeOf(TStartupInfo), 0);

  with LStartupInfo do
  begin
    cb := SizeOf(TStartupInfo);

    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWMINIMIZED; // wShowWindow := SW_SHOWDEFAULT;
  end;

  if CreateProcess(nil, PChar(APath), nil, nil, False, NORMAL_PRIORITY_CLASS,
    nil, nil, LStartupInfo, LProcessInfo) then
  begin

    repeat
      LWaitResult := WaitForSingleObject(LProcessInfo.hProcess, 500);
      // do something, like update a GUI or call Application.ProcessMessages
    until LWaitResult <> WAIT_TIMEOUT;
    Result := LWaitResult = WAIT_OBJECT_0;
    GetExitCodeProcess(LProcessInfo.hProcess, VProcessResult);
    CloseHandle(LProcessInfo.hProcess);
    CloseHandle(LProcessInfo.hThread);
  end;
end;

begin
  if ParamCount >= 1 then
  begin
    {$IFDEF LINENOTIFY}
      (*
        Setup Line Access Token
        Sample call
         C:\>testping_serv.exe
      *)
      TOKEN := paramstr(1);
      SaveConfig(TOKEN);
    {$ENDIF}
  end
  else
  begin
    ipaddr := TStringList.Create;
    tmpPing := TStringList.Create;
    resultPing := TStringList.Create;
    if FileExists(ExtractFilePath(paramstr(0)) + 'hosts.txt') then
       ipaddr.LoadFromFile(ExtractFilePath(paramstr(0)) + 'hosts.txt')
    else
    begin
       ipaddr.Add('127.0.0.1'); //default pinging
       ipaddr.SaveToFile(ExtractFilePath(paramstr(0)) + 'hosts.txt');
    end;

    WriteLn('Batch pinging...');
    try
      for j := 0 to ipaddr.Count - 1 do
      begin
        write(format('   ping %s ...', [ipaddr.strings[j]]));

        rStr := '';
        if FileExists(ExtractFilePath(paramstr(0)) + 'ping_log.txt') then
          SysUtils.DeleteFile(ExtractFilePath(paramstr(0)) + 'ping_log.txt');

        ExecAndWait('cmd.exe /c ping ' + Trim(ipaddr.strings[j]) + ' > ' +
          ExtractFilePath(paramstr(0)) + 'ping_log.txt', i);

        if FileExists(ExtractFilePath(paramstr(0)) + 'ping_log.txt') then
        begin
          tmpPing.LoadFromFile(ExtractFilePath(paramstr(0)) + 'ping_log.txt');

          if tmpPing.Count >= 8 then
          begin
            if ((pos('Destination host unreachable', tmpPing.strings[2]) >= 1)
              or (pos('Destination host unreachable', tmpPing.strings[3]) >= 1)
              or (pos('Destination host unreachable', tmpPing.strings[3]) >= 1)
              or (pos('Destination host unreachable', tmpPing.strings[3]) >= 1))
            then
              rStr := ResultStr[0]
            else if ((pos('Request timed out.', tmpPing.strings[2]) >= 1) or
              (pos('Request timed out.', tmpPing.strings[3]) >= 1) or
              (pos('Request timed out.', tmpPing.strings[4]) >= 1) or
              (pos('Request timed out.', tmpPing.strings[5]) >= 1)) then
              rStr := ResultStr[1]
            else if ((pos('bytes=', tmpPing.strings[2]) >= 1) or
              (pos('bytes=', tmpPing.strings[3]) >= 1) or
              (pos('bytes=', tmpPing.strings[4]) >= 1) or
              (pos('bytes=', tmpPing.strings[5]) >= 1)) then
              rStr := ResultStr[2];
            resultPing.Add(ipaddr.strings[j] + ' ' + rStr);
            write(rStr);
            WriteLn;

            tmpPing.BeginUpdate;
            tmpPing.Clear;
            tmpPing.EndUpdate;
          end;
        end;
      end;
    finally
      ipaddr.Free;
      tmpPing.Free;
      resultPing.SaveToFile(ExtractFilePath(paramstr(0)) + 'result.txt');
      // SaveConfig;
      {$IFDEF LINENOTIFY}
        ValidLineAPI;

        AwaraLineNotify.LineMessage.Clear;
        write('   Send to LINE ...');
        AwaraLineNotify.LineMessage.Add(resultPing.text);
        AwaraLineNotify.SendToLineServer;
      {$ELSE}
      LogMsg(ExtractFilePath(paramstr(0)) + 'logping.txt', resultPing.text);
      write('Press enter to exit!');
      readln;
      {$ENDIF}      

      {
        if FileExists(ExtractFilePath(paramstr(0))+'result.txt') then
        ShellExecute (0, 'open', 'notepad.exe', pchar(ExtractFilePath(paramstr(0))+'result.txt'), nil, SW_SHOWNORMAL);
      }
      resultPing.Free;
    end;
  end;
end.

