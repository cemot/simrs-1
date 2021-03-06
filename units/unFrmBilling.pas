unit unFrmBilling;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, RpRave, RpDefine,
  RpCon, RpConDS, DB,DateUtils, ADODB, DBCtrls, Mask;

type
  TfrmBillingRawatInap = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    billingsementara: TBitBtn;
    rvRawatInap: TRvDataSetConnection;
    rvProjectRawatInap: TRvProject;
    gridRawatInap: TDBGrid;
    rvRawatInapDetail: TRvDataSetConnection;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox5: TGroupBox;
    txtCariNama: TEdit;
    Label1: TLabel;
    txtCariAlamat: TEdit;
    Label2: TLabel;
    dbNoRM: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    dbNama: TDBEdit;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBMemo1: TDBMemo;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    Label10: TLabel;
    btnClear: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    rvKamarDetail: TRvDataSetConnection;
    rvViewObat: TRvDataSetConnection;
    rvRontgen: TRvDataSetConnection;
    rvAdministrasi: TRvDataSetConnection;
    rvProjectRawatInapSementara: TRvProject;
    rvAlkes: TRvDataSetConnection;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    dbjamkeluar: TDBEdit;
    DBEdit1: TDBEdit;
    dbTglMasuk: TDBEdit;
    dbJamMasuk: TDBEdit;
    DBEdit11: TDBEdit;
    dbNoreg: TDBEdit;
    gbJam: TGroupBox;
    btnSaveJam: TButton;
    Button3: TButton;
    txtJamBaru: TEdit;
    gbPassword: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    txtusername: TEdit;
    txtPassword: TEdit;
    BitBtn5: TBitBtn;
    rvApotik: TRvDataSetConnection;
    rvProjectStruk: TRvProject;
    rvApotikdetail: TRvDataSetConnection;
    procedure billingsementaraClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure txtCariNamaChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure dbNoRMKeyPress(Sender: TObject; var Key: Char);
    procedure dbNamaKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure DBMemo1KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit7KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit5KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
    procedure txtPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure btnSaveJamClick(Sender: TObject);
    procedure dbTglKeluarKeyPress(Sender: TObject; var Key: Char);
    procedure dbJamKeluarKeyPress(Sender: TObject; var Key: Char);
    procedure txtusernameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
   
  private
    { Private declarations }


  public
    { Public declarations }
    procedure refreshRptRawatInap;
  end;

var
  frmBillingRawatInap: TfrmBillingRawatInap;

implementation

uses unDm, unFrmService, unitFrmBillingPasienNonAktif, unFrmRawatInap,
  unFrmTransaksiRawatInap, undmrpt;

{$R *.dfm}

procedure tfrmBillingRAwatInap.refreshRptRawatInap;
begin
  with dm.dsetRptRawatInap do
 begin
  active := false;
  commandType := cmdText;
  commandText :='select * from  tarawatinap,tapasien,takamar, takamardetail '+
  'where psKodePasien LIKE inNoRM '+
  'AND kdNoReg LIKE inNoReg '+
  'and kdactive=1 '+
  'and inisbayar=0 '+
  'and kakode like inkodekamar '+
  'ORDER BY inNoReg';

  active := true;
 end;


end;

procedure TfrmBillingRawatInap.billingsementaraClick(Sender: TObject);
var tempNoRM,tempNoReg : string;
    JmlHari : integer;
    tempKelas : string;
    tempAdmin : integer;
    tglMasuk,tglKeluar : TDate;
    jamkeluar : TTime;
    hour,minute,sec,msec,hourline,minuteline:word;
begin


  tempNoRM := dbNoRM.Text;
  tempNoReg := dbnoreg.Text;
  hourline :=12;
  minuteLine :=30;

  

 with dm.dsetRptRawatInap do
 begin
  active := false;
  commandType := cmdText;
  commandText :='select * from  tarawatinap,tapasien '+
  'where psKodePasien LIKE inNoRM '+
  'and inisbayar=0 '+
  'and innoreg like (:noreg) ';
  parameters.ParamByName('noreg').Value := tempnoreg;
  active := true;
 end;


  with dm.dsetKamarDetail do
  begin
    active:=false;
    commandType := cmdText;
    commandText := 'SELECT * FROM taKamarDetail '+
    'WHERE kdActive=1 '+
    'AND kdNoReg LIKE (:noreg) ';
    parameters.ParamByName('noReg').Value :=tempNoReg;
    active:=true;

    if isEmpty=false then
    begin
      //showMessage(tempNoReg);
      open;
      edit;
      fields.FieldByName('kdTglKeluar').AsDateTime := date();
      fields.FieldByName('kdJamKeluar').AsDateTime := time();
      post;
    end;
   
  end;

 
  dm.dsetkamardetail.Requery();
  dm.dsetAlkes.Requery();
  dmrpt.dsetrptrawatinapdetail.Requery();
  //dm.dsetViewObat.Requery();

  rvProjectRawatInapSementara.ProjectFile := 'rawatInapsementara.rav';

  rvProjectRawatInapSementara.Open;

  rvProjectRawatInapSementara.SelectReport('rawatInapsementara',true);
  rvProjectRawatInapSementara.SetParam('noReg',tempNoReg);
  rvProjectRawatInapSementara.SetParam('numOfDays',intToStr(jmlHari));
  rvProjectRawatInapSementara.Execute;
  refreshRptRawatInap;

end;

procedure TfrmBillingRawatInap.FormActivate(Sender: TObject);
begin
  refreshrptRawatInap;
end;

procedure TfrmBillingRawatInap.BitBtn2Click(Sender: TObject);
begin
  refreshrptRawatInap;
end;

procedure TfrmBillingRawatInap.txtCariNamaChange(Sender: TObject);
begin
with dm.dsetRptRAwatInap do
begin
 locate('psnama',txtCariNama.Text,[loPartialKey]);
end;
end;

procedure TfrmBillingRawatInap.btnClearClick(Sender: TObject);
begin
  txtCariNama.Clear;
  txtCarialamat.Clear;
end;

procedure TfrmBillingRawatInap.dbNoRMKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure TfrmBillingRawatInap.dbNamaKeyPress(Sender: TObject;
  var Key: Char);
begin
    key:=#0;
end;

procedure TfrmBillingRawatInap.DBEdit3KeyPress(Sender: TObject;
  var Key: Char);
begin
   key:=#0;
end;

procedure TfrmBillingRawatInap.DBMemo1KeyPress(Sender: TObject;
  var Key: Char);
begin
   key:=#0;
end;

procedure TfrmBillingRawatInap.DBEdit4KeyPress(Sender: TObject;
  var Key: Char);
begin
   key:=#0;
end;

procedure TfrmBillingRawatInap.DBEdit6KeyPress(Sender: TObject;
  var Key: Char);
begin
   key:=#0;
end;

procedure TfrmBillingRawatInap.DBEdit7KeyPress(Sender: TObject;
  var Key: Char);
begin
 key:=#0;
end;

procedure TfrmBillingRawatInap.DBEdit5KeyPress(Sender: TObject;
  var Key: Char);
begin
   key:=#0;
end;

procedure TfrmBillingRawatInap.BitBtn3Click(Sender: TObject);
var tempNoReg : string;
    tempNoRM : string;
   tglMasuk : TDate;
  TglKeluar : TDate;
  jmlHari : integer;
  jamkeluar:TTime;
  HourLine,minuteLine,hour,minute,sec,msec : word;
  tempkelas : string;
  administrasi,rontgen,obat,lab,alkes : integer;

begin
  HourLine := 12;
  MinuteLine := 30;
  tempNoRM := dbNoRM.Text;
  tempNoReg := dbNoReg.Text;
  //tempTglMasuk := strToDate(dbTglMasuk.Text);

if MessageDlg('Nama Pasien : '+dbNama.Text+#13+
'Anda Yakin Setting Pasien ini Keluar? ',mtConfirmation,[mbYes,mbNo],0)=mrYes then
begin

 //frmService.cekAdministrasi;
 

  with dmrpt.dsetRawatInapOnly do
  begin
     active := false;
    commandType := cmdText;
    commandText := 'select * from takamardetail '+
    'WHERE kdactive=1 '+
    'and kdnoreg LIKE (:noReg) ';
    parameters.ParamByName('noReg').Value := tempNoReg;
    active := true;


   if isEmpty=false then
   begin
        tempKelas := fields.fieldbyname('kdkamar').AsString;
        showMessage('Kelas : '+tempKelas);
        edit;
        fields.FieldByName('kdJamKeluar').AsDateTime := time();
        fields.fieldbyName('kdtglkeluar').AsDateTime := date();
        post;
   end;

  end;
  //gbJam.Visible := false;


 with dm.dsetAdministrasi do
 begin
   active:=false;
   commandType := cmdText;
   commandText := 'select * from taadministrasi '+
   'where adkelas like (:kelas) ';
   parameters.ParamByName('kelas').Value := tempkelas;
   active:=true;

   if isEmpty=false then
   begin
     administrasi := fields.fieldByname('adadmin').AsInteger;
     rontgen      := fields.fieldbyname('adrontgen').AsInteger;
     lab          := fields.fieldbyname('adlab').AsInteger;
     alkes        := fields.fieldbyname('adalkes').AsInteger;
     obat         := fields.fieldbyname('adobat').AsInteger;
   end;
 end;


 // kembalikan jumlah kamar
 with dm.dsetViewKamar do
 begin
  active:=false;
  commandType := cmdText;
  commandText := 'select * from takamar '+
  'WHERE kaBedStok <> 0 '+
  'and kakode like (:kelas) ';
  parameters.ParamByName('kelas').Value := tempKelas;
  active:=true;

  if isempty=false then
  begin
    edit;
    fields.FieldByName('kaBedStok').AsInteger :=  fields.FieldByName('kaBedStok').AsInteger+1;
    post;
  end;

 end;

 with dmrpt.dsetRawatInapOnly do
  begin
     active := false;
    commandType := cmdText;
    commandText := 'select * from tarawatinap '+
    'WHERE inNoReg LIKE (:noReg) ';
    parameters.ParamByName('noReg').Value := tempNoReg;
    active := true;
                     
   if isEmpty=false then
   begin
        //showMessage('ketemu!');
        edit;
        fields.FieldByName('inTglKeluar').AsDateTime := date();
        fields.FieldByName('inJamKeluar').AsDateTime := time();
        fields.FieldByName('inisbayar').AsInteger := 1;
        fields.FieldByName('inpersenadm').AsInteger := administrasi;
        post;
        requery;
   end;
  end;

 // dsetrptRawatinap.Requery();

  with dm.dsetrptrawatinap do
  begin
    locate('innoreg',tempnoreg,[locaseinsensitive]);
  end;

   // cek apabila tanggal masuk dan tanggal keluar sama
   //apabila jam dibawah 12:30 maka dianggap 0 hari sebaliknya
   //apabila jam keluar di atas 12:30 maka dianggap 1 hari
   //jam bisa disetting menjadi 12:30 supaya tanggal yang sama tidak dianggap 1 hari
   //walaupun sudah melewati jam 12:30

  with  dm.dsetRptKamarDetail do
  begin
    active:=false;
    commandType := cmdText;
    commandtext := 'select * from takamardetail '+
    'where kdactive=1 and kdnoreg like (:noreg) ';
    parameters.ParamByName('noreg').Value := tempNoReg;
    active:=true;

    if isEmpty=false then
    begin
      showMessage('RptKamar Detail: Ketemu!'+tempNoReg);
      tglMasuk:= fields.fieldByName('kdTglMasuk').AsDateTime;
      tglKeluar := fields.fieldbyname('kdtglkeluar').AsDateTime;
      jamkeluar :=fields.fieldbyname('kdjamkeluar').AsDateTime;
      showmessage(timeToStr(jamkeluar));
      jmlHari:=daysBetween(tglKeluar,tglmasuk);
      DecodeTime(jamkeluar,hour,minute,sec,msec);
      showmessage('Jml Hari: '+intToStr(jmlhari));
      if jmlhari=0 then // jika masuk dan keluar di tanggal yang sama
      begin
        if (hour >= hourline) and (minute > minuteLine) then
        begin
           showMessage('wkt lebih dari jam 12:30== SEHARI');
           edit;
           fields.FieldByName('kdnumofdays').AsInteger := 1;
           post;
        end
        else if (hour = hourline) and (minute < minuteLine) then
             begin
               showMessage('kurang sehari dari menit');
               edit;
               Fields.FieldByName('kdnumofdays').AsInteger := 0;
               post;
             end else if (hour = hourline) and (minute>minuteline) then
             begin
               edit;
               Fields.FieldByName('kdnumofdays').AsInteger := 1;
               post;
                showMessage('1 hari dgn jam sama tapi menit lebih besar');
             end
             else if (hour>hourline) and (minute<minuteline) then
             begin
               showMessage('jam lebih besar tapi menit lebih kecil...1 HARI!');
               edit;
               Fields.FieldByName('kdnumofdays').AsInteger := 1;
               post;
             end
             else if hour<hourline then
                 begin
                  edit;
                  Fields.FieldByName('kdnumofdays').AsInteger := 0;
                 showMessage('BELUM SEHARI');
                  post;
                 end;
      end else begin
               edit;
               Fields.FieldByName('kdnumofdays').AsInteger := jmlHari;
               showMessage('Hari Sudah Berbeda');
               post;
               end;
    end;
   end;
 // dm.dsetRptKamarDetail.Requery();
   //dsetrptrawatinap.Requery();

 dm.dsetkamardetail.Requery();
 with dm.dsetRptRawatInap do
 begin
  active := false;
  commandType := cmdText;
  commandText :='select * from  tarawatinap,tapasien '+
  'where psKodePasien LIKE inNoRM '+
  'and inisbayar=1 '+
  'and innoreg like (:noreg) ';
  parameters.ParamByName('noreg').Value := tempnoreg;
  active := true;
 end;

  // kembalikan jumlah kamar yang tersedia
  frmRawatInap.refreshViewKamar;

  rvProjectRawatInap.ProjectFile:= 'rawatInap.rav';

  rvProjectRawatInap.Open;

  rvProjectRawatInap.SelectReport('rawatInap',true);
  rvProjectRawatInap.SetParam('noReg',tempNoReg);
  rvProjectRawatInap.Execute;

  refreshRptRawatInap;
  //frmBillingPasienNonAktif.refreshPasienKeluar;
end // end of MessageDlg   
end;

procedure TfrmBillingRawatInap.txtPasswordKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if key=vk_return then
 begin
    with dmrpt.dsetPassword do
    begin
     active := false;
     commandType := cmdText;
     commandText := 'SELECT * FROM tauser '+
     'WHERE usNama LIKE (:nama) AND '+
     'usPassword Like (:password) AND '+
     'usNamaGroup LIKE (:group) ';
     parameters.ParamByName('nama').Value := txtUsername.Text;
     parameters.ParamByName('password').Value := txtPassword.Text;
     parameters.ParamByName('group').Value := 'Administrator';
     active := true;

     if isEmpty=false then
     begin
        gbPassword.Visible := false;
        gbJam.Visible := true;
        txtJamBaru.Text := dbJamKeluar.Text;
        txtJamBaru.SetFocus;
     end  else
     begin
       showMessage('Anda tidak punya hak untuk setting Jam!');
       gbPassword.Visible := false;
     end;

    end;
 end;

 if key=vk_escape then
 begin
   gbPassword.Visible := false;
 end;

end;

procedure TfrmBillingRawatInap.Button3Click(Sender: TObject);

begin

   gbJam.Visible := false;
end;

procedure TfrmBillingRawatInap.btnSaveJamClick(Sender: TObject);
var tempNoReg : string;
    tempNoRM : string;
    //tempTglMasuk : TDateTime;
begin
  tempNoREg := dbNoReg.Text;
  tempNoRM := dbNoRm.Text;
  //tempTglMasuk := strToDate(dbTglMasuk.Text);

 with dmrpt.dsetRawatInapOnly do
  begin
     active := false;
    commandType := cmdText;
    commandText := 'select * from takamardetail '+
    'WHERE kdactive=1 '+
    'and kdnoreg LIKE (:noReg) ';
    parameters.ParamByName('noReg').Value := tempNoReg;
    active := true;


   if isEmpty=false then
   begin
        edit;
        fields.FieldByName('kdJamKeluar').AsDateTime := strToTime(txtJamBaru.Text);
        post;
   end;

  end;
  gbJam.Visible := false;
  dm.dsetrptRawatinap.Requery();
  with dm.dsetrptrawatinap do
  begin
    locate('innoreg',tempnoreg,[locaseinsensitive]);
  end;
  // refresh database dan kembali ke posisi semula

 {  with dsetRptRawatInap do
  begin
    active := false;
    commandType := cmdText;
    commandText := 'select * from tarawatinap,tapasien,takamar '+
    'WHERE psKodePasien LIKE inNoRM AND '+
    'kaKode LIKE inKodeKamar AND '+
    'inNoRM LIKE (:noRM) ';
    parameters.ParamByName('noRM').Value := tempNoRM;
    active := true;

   end;}

end;

procedure TfrmBillingRawatInap.dbTglKeluarKeyPress(Sender: TObject;
  var Key: Char);
begin
 key := #0;
end;

procedure TfrmBillingRawatInap.dbJamKeluarKeyPress(Sender: TObject;
  var Key: Char);
begin
 key := #0;
end;

procedure TfrmBillingRawatInap.txtusernameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if key=vk_escape then
 begin
   gbPassword.Visible := false;
 end;

end;

procedure TfrmBillingRawatInap.BitBtn4Click(Sender: TObject);
begin
  gbPassword.Visible := true;
  txtUsername.Clear;
  txtPassword.Clear;
  txtUsername.SetFocus;
end;

procedure TfrmBillingRawatInap.BitBtn5Click(Sender: TObject);
begin

    with dmrpt.dsetPassword do
    begin
     active := false;
     commandType := cmdText;
     commandText := 'SELECT * FROM tauser '+
     'WHERE usNama LIKE (:nama) AND '+
     'usPassword Like (:password) AND '+
     'usNamaGroup LIKE (:group) ';
     parameters.ParamByName('nama').Value := txtUsername.Text;
     parameters.ParamByName('password').Value := txtPassword.Text;
     parameters.ParamByName('group').Value := 'Administrator';
     active := true;

     if isEmpty=false then
     begin
        gbPassword.Visible := false;
        gbJam.Visible := true;
        txtJamBaru.Text := dbJamKeluar.Text;
        txtJamBaru.SetFocus;
     end  else
     begin
       showMessage('Anda tidak punya hak untuk setting Jam!');
       gbPassword.Visible := false;
     end;

    end;



end;

end.
