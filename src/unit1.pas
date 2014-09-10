unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, Buttons, ComCtrls, StdCtrls, ExtCtrls;

type

  { TDespertador }

  TDespertador = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Process1: TProcess;
    Timer2: TTimer;
    txtHora: TEdit;
    txtMinuto: TEdit;
    txtRelogio: TEdit;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure txtHoraChange(Sender: TObject);
    procedure txtMinutoExit(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Despertador: TDespertador;
  AProcess : TProcess;
  nomearquivo: string;

implementation

{ TDespertador }

procedure TDespertador.TrackBar1Change(Sender: TObject);
var
comando: string;
begin
     if (OpenDialog1.FileName <> '') then
     begin
               comando := concat('mpg123\mpg123.exe -q -f ',inttostr(TrackBar1.Position), ' ', nomearquivo);
               AProcess.CommandLine := comando;
     end;
end;

procedure TDespertador.txtHoraChange(Sender: TObject);
begin
  if (length(txtMinuto.text) = 1) then
  begin
       txtMinuto.text := concat('0',txtMinuto.text);
  end;
end;

procedure TDespertador.txtMinutoExit(Sender: TObject);
begin
  if (length(txtMinuto.text) = 1) then
  begin
       txtMinuto.text := concat('0',txtMinuto.text);
  end;
end;

procedure TDespertador.SpeedButton1Click(Sender: TObject);
var
comando: string;
begin
   if (OpenDialog1.Execute) then
   begin
        nomearquivo := OpenDialog1.filename;
        AProcess := TProcess.Create(nil);
        comando := concat('mpg123\mpg123.exe -q -f ',inttostr(Trackbar1.Position), ' ', nomearquivo);
        AProcess.CommandLine := comando;
        AProcess.ShowWindow:= swoHIDE;
   end;
end;

procedure TDespertador.Button2Click(Sender: TObject);
begin
  Timer2.Enabled := False;
  AProcess.Terminate(1);
end;

procedure TDespertador.Button1Click(Sender: TObject);
begin
     if (OpenDialog1.filename <> '') then
     begin
          if (AProcess.Running <> true) then
          begin
               AProcess.Execute;
          end;
     end;
end;

procedure TDespertador.CheckBox1Change(Sender: TObject);
begin
  Timer2.Enabled := False;
end;

procedure TDespertador.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
     if (OpenDialog1.filename <> '') then
     begin
          AProcess.Terminate(1);
     end;
end;


procedure TDespertador.Timer1Timer(Sender: TObject);
begin
  txtRelogio.Text := FormatDateTime('hh:mm:ss', Now);
  if (txtRelogio.text = concat(txtHora.text,':', txtMinuto.text,':00')) then
  begin
      WindowState := wsNormal;
      caption := 'Despertador Ativado';
      if (CheckBox1.Checked = True) then
      begin
           if (OpenDialog1.FileName = '') then
           begin
                Timer2.Enabled := True;
           end
           else
           begin
                AProcess.Execute;
           end;
      end;
  end;
end;

procedure TDespertador.Timer2Timer(Sender: TObject);
begin
  Beep;
end;

initialization
  {$I unit1.lrs}

end.

