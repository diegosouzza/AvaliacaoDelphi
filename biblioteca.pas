unit biblioteca;
interface

uses
      Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Mask,
      Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, FMTBcd,SqlExpr, Windows,
      DateUtils, DBClient, SimpleDS, DB, DBXCommon, Math, FireDAC.Comp.Client ;

type
   TCampo = record
      tabela: string;
      nome: string;
      tipo: integer; // 1-String; 2-Char; 3-Integer; 4-Float; 5-Numeric; 6-Date; 7-Time; 8-DateTime; 9-Blob
      valor: string;
      blob: TMemoryStream;
   end;
   aCampos = array of TCampo;

   procedure HabilitarCampos(grupo: TWinControl; tag: Integer; enabled: Boolean; primeiro_focado: boolean = false);
   procedure MostrarCampos(grupo: TWinControl; tag: Integer; visible: Boolean);

   procedure LimparCampos(grupo: TWinControl);
   procedure ValidarCampos(grupo: TWinControl);

   procedure PreencherCampos(grupo: TWinControl; dataSet: TFDQuery);
   function Formatar_telefone(telefone: string): string;

   function LimparString(texto: string): string;
   function LimparMascara(texto, mascara: string): string;

   function buscar_sequencial(campo, tabela, condicao: string): string;

   function ValidarCpf(numero_cpf: string): boolean;
   function ValidarCNPJ(numero_cnpj: string): boolean;
   function ValidarEmail(email: string): boolean;
   function ValidarCEP(Estado: string; CEP: string): boolean;
   function RetornarTipo(tipo: integer): string;

   function StringParaFirebird(texto: string): string;
   function DataParaFirebird(Data : string) : string;
   function FloatParaFirebird(numero: string): string;

   function MontarChaves(grupo:TWinControl; condicao: integer): string; // 1- Cadastro(values); 2- Update/Delete(where)
   function MontarCampos(grupo: TWinControl): aCampos;

   function ExecutarSQL(const p_sql: string): string;
   function Formatar_tipo(texto, tipo: string): string; overload;



implementation

uses data_module3;

procedure HabilitarCampos(grupo: TWinControl; tag: integer; enabled: boolean; primeiro_focado: boolean);
var
   i: Integer;
   focado: boolean;
begin
   if primeiro_focado then
      focado := true
   else
      focado := false;

   for i := 0 to grupo.controlCount-1 do
   begin
      if (grupo.controls[i].tag = tag) then
      begin
         grupo.controls[i].enabled := enabled;
         if enabled and (not focado) then
         begin
            if (grupo.controls[i] is TEdit) and (grupo.controls[i] as TEdit).CanFocus then
            begin
               (grupo.controls[i] as TEdit).SetFocus;
               focado := true;
            end
            else
            if (grupo.controls[i] is TMaskEdit) and (grupo.controls[i] as TMaskEdit).CanFocus then
            begin
               (grupo.controls[i] as TMaskEdit).SetFocus;
               focado := true;
            end
            else
            if (grupo.controls[i] is TComboBox) and (grupo.controls[i] as TComboBox).CanFocus then
            begin
               (grupo.controls[i] as TComboBox).SetFocus;
               focado := true;
            end;
         end;
      end;

      if (grupo.controls[i] is TPanel) then
         HabilitarCampos(grupo.controls[i] as TPanel, tag, enabled, focado)
      else
      if (grupo.controls[i] is TGroupBox) then
         HabilitarCampos(grupo.controls[i] as TGroupBox, tag, enabled, focado)
      else
      if (grupo.Controls[i] is TPageControl) then
      begin
         (grupo.Controls[i] as TPageControl).TabIndex := 0;
         HabilitarCampos((grupo.Controls[i] as TPageControl), tag, enabled, focado);
      end
      else
      if (grupo.Controls[i] is TTabSheet) then
      begin
         HabilitarCampos((grupo.Controls[i] as TTabSheet), tag, enabled, focado);
      end;
   end;
end;

procedure MostrarCampos(grupo: TWinControl; tag: Integer; visible: Boolean);
var
   i: Integer;
begin
   for i := 0 to grupo.controlCount-1 do
   begin
      if (grupo.controls[i].tag = tag) then
         grupo.controls[i].Visible := visible;

      if (grupo.controls[i] is TPanel) then
         MostrarCampos(grupo.controls[i] as TPanel, tag, visible)
      else
      if (grupo.controls[i] is TGroupBox) then
         MostrarCampos(grupo.controls[i] as TGroupBox, tag, visible)
      else
      if (grupo.Controls[i] is TPageControl) then
         MostrarCampos((grupo.Controls[i] as TPageControl), tag, visible)
      else
      if (grupo.Controls[i] is TTabSheet) then
         MostrarCampos((grupo.Controls[i] as TTabSheet), tag, visible)
   end;
end;

procedure LimparCampos(grupo: TWinControl);
var
   i: Integer;
begin
   for i := 0 to grupo.controlCount-1 do
   begin
      if not (grupo.Controls[i].Visible) then
         continue;

      if (grupo.controls[i] is TEdit) then
         (grupo.controls[i] as TEdit).text := ''
      else
      if (grupo.controls[i] is TMaskEdit) then
         (grupo.controls[i] as TMaskEdit).Text := ''
      else
      if (grupo.controls[i] is TComboBox) then
         (grupo.controls[i] as TComboBox).itemIndex := -1
      else
      if (grupo.controls[i] is TMemo) then
         (grupo.controls[i] as TMemo).text := ''
      else
      if (grupo.controls[i] is TCheckBox) then
         (grupo.controls[i] as TCheckBox).Checked := false
      else
      if (grupo.controls[i] is TPanel) then
         LimparCampos(grupo.controls[i] as TPanel)
      else
      if (grupo.controls[i] is TGroupBox) then
         LimparCampos(grupo.controls[i] as TGroupBox)
      else
      if (grupo.controls[i] is TScrollBox) then
         LimparCampos(grupo.controls[i] as TScrollBox)
      else
      if (grupo.controls[i] is TPageControl) then
         LimparCampos(grupo.controls[i] as TPageControl)
      else
      if (grupo.controls[i] is TTabSheet) then
         LimparCampos(grupo.controls[i] as TTabSheet);
   end;
end;

procedure ValidarCampos(grupo: TWinControl);
var
   list: TList;
   i: Integer;
begin
   list := TList.Create;
   try
      grupo.GetTabOrderList(list);

      if (list.count = 0) then
         list.Add(grupo);

      for i := 0 to list.count-1 do
      begin
         if (TComponent(list[i]) is TControl) and ((TComponent(list[i]) as TControl).Enabled) then
            (TComponent(list[i]) as TControl).Perform(cm_EXIT, 0, 0);
      end;
   finally
      list.Free;
   end;
end;

procedure PreencherCampos(grupo: TWinControl; dataSet: TFDQuery);
   function retornar_campo(hpkeyword: string): string;
   begin
      result := copy(hpkeyword,5,length(hpkeyword)-4);
   end;
var
   i: integer;
begin
   for i := 0 to grupo.ControlCount - 1 do
   begin
      if (grupo.Controls[i] is TEdit) and (trim(TEdit(grupo.Controls[i]).HelpKeyword) <> '') then
         TEdit(grupo.Controls[i]).Text := dataSet.FieldByName(retornar_campo(TEdit(grupo.Controls[i]).HelpKeyword)).AsString
      else
      if (grupo.Controls[i] is TMemo) and (trim(TMemo(grupo.Controls[i]).HelpKeyword) <> '') then
         TMemo(grupo.Controls[i]).Text := dataSet.FieldByName(retornar_campo(TMemo(grupo.Controls[i]).HelpKeyword)).AsString
      else
      if (grupo.Controls[i] is TMaskEdit) and (trim(TMaskEdit(grupo.Controls[i]).HelpKeyword) <> '') then
         TMaskEdit(grupo.Controls[i]).EditText := dataSet.FieldByName(retornar_campo(TMaskEdit(grupo.Controls[i]).HelpKeyword)).AsString
      else
      if (grupo.Controls[i] is TComboBox) and (trim(TComboBox(grupo.Controls[i]).HelpKeyword) <> '') then
      begin
         if copy(TComboBox(grupo.Controls[i]).HelpKeyword,3,1) = '1' then
            TComboBox(grupo.Controls[i]).ItemIndex := TComboBox(grupo.Controls[i]).Items.IndexOf(dataSet.FieldByName(retornar_campo(TComboBox(grupo.Controls[i]).HelpKeyword)).AsString)
         else
            TComboBox(grupo.Controls[i]).ItemIndex := dataSet.FieldByName(retornar_campo(TComboBox(grupo.Controls[i]).HelpKeyword)).AsInteger + 1
      end
      else
      if (grupo.Controls[i] is TGroupBox) then
         PreencherCampos(TGroupBox(grupo.Controls[i]),dataSet)
      else
      if (grupo.Controls[i] is TTabSheet) then
         PreencherCampos(TTabSheet(grupo.Controls[i]),dataSet)
      else
      if (grupo.Controls[i] is TPageControl) then
         PreencherCampos(TPageControl(grupo.Controls[i]),dataSet);
   end;
end;

function Formatar_telefone(telefone: string): string;
begin
   if length(telefone) = 10 then
      result := '('+copy(telefone,1,2)+') '+copy(telefone,3,4)+'-'+copy(telefone,7,4)
   else
   if (length(telefone) = 11) then
      result := '('+copy(telefone,1,2)+') '+copy(telefone,3,5)+'-'+copy(telefone,8,4);
end;

function buscar_sequencial(campo, tabela, condicao: string): string;
begin
   with dm3.dataset do
   begin
      try
         Close;

         if (trim(condicao) = '') then
            sql.Text := 'select (coalesce(max('+campo+'),0)+1) as NewID from '+tabela
         else
            sql.Text := 'select (coalesce(max('+campo+'),0)+1) as NewID from '+tabela+' '+condicao;

         Open;

         Result := FieldByName('NewID').AsString;
      finally
         close;
      end;
   end;
end;

function LimparString(texto: string): string;
begin
   result := trim(StringReplace(texto,#10#13,'',[rfReplaceAll]));
end;

function LimparMascara(texto, mascara: string): string;
var
   i: Integer;
   lista: TStringList;
   aux: integer;
begin
   if LimparString(mascara) <> '' then
   begin
      try
         lista := TStringList.Create;
         texto := StringReplace(texto,'_','',[rfReplaceAll]);
         for i := 1 to length(mascara) do
         begin
            if TryStrToInt(copy(mascara,i,1),aux) then
               continue;

            if lista.IndexOf(copy(mascara,i,1)) > 0 then
               continue;

            lista.Add(copy(mascara,i,1));
            texto := StringReplace(texto,copy(mascara,i,1),'',[rfReplaceAll]);
         end;
      finally
         FreeAndNil(lista);
      end;
   end;

   result := LimparString(texto);
end;

function ValidarCpf(numero_cpf: string): boolean;
var
   acumula_cpf : string;
   somacpf, digito : integer;
   contador : shortint;
begin
   numero_cpf := LimparMascara(numero_cpf,'.-');

   if (numero_cpf = '') then
   begin
      result := true;
      exit;
   end;

   if (length(numero_cpf) <> 11) then
   begin
      result := false;
      exit;
   end;

   acumula_cpf := copy(numero_cpf,1,9);
   somacpf := 0;

   for contador := 1 to 9 do
      somacpf := somacpf + strtoint(copy(acumula_cpf,contador,1)) * (11 - contador);

   digito := 11 - somacpf mod 11;

   if digito in [10,11] then
      acumula_cpf := acumula_cpf + '0'
   else
      acumula_cpf := acumula_cpf + inttostr(digito);

   somacpf := 0;
   for contador := 1 to 10 do
      somacpf := somacpf + strtoint(copy(acumula_cpf,contador,1)) * (12 - contador);

   digito := 11 - somacpf mod 11;

   if digito in [10,11] then
      acumula_cpf := acumula_cpf + '0'
   else
      acumula_cpf := acumula_cpf + inttostr(digito);

   if numero_cpf <> acumula_cpf then
      result := false
   else
      result := true;
end;

function ValidarCNPJ(numero_cnpj: string): boolean;
var
   acumula_cnpj : string;
   somacnpj, digito : integer;
   contador : shortint;
begin
   numero_cnpj := LimparMascara(numero_cnpj,'./-');
   if (numero_cnpj = '') then
   begin
      result := true;
      exit;
   end;

   if (length(numero_cnpj) <> 14) then
   begin
      result := false;
      exit;
   end;

   acumula_cnpj := copy(numero_cnpj,1,12);

   somacnpj := 0;
   for contador := 1 to 4 do
      somacnpj := somacnpj + strtoint(copy(acumula_cnpj,contador,1)) * (6 - contador);

   for contador := 1 to 8 do
      somacnpj := somacnpj + strtoint(copy(acumula_cnpj,contador + 4,1)) * (10 - contador);

   digito := 11 - somacnpj mod 11;

   if digito in [10,11] then
      acumula_cnpj := acumula_cnpj + '0'
   else
      acumula_cnpj := acumula_cnpj + inttostr(digito);

   somacnpj := 0;
   for contador := 1 to 5 do
      somacnpj := somacnpj + strtoint(copy(acumula_cnpj,contador,1)) * (7-contador);

   for contador := 1 to 8 do
      somacnpj := somacnpj + strtoint(copy(acumula_cnpj,contador + 5, 1)) * (10-contador);

   digito := 11 - somacnpj mod 11;

   if digito in [10,11] then
      acumula_cnpj := acumula_cnpj + '0'
   else
      acumula_cnpj := acumula_cnpj + inttostr(digito);

   if (numero_cnpj <> acumula_cnpj) then
      result := false
   else
      result := true;
end;

function ValidarEmail(email: string): boolean;
var
   pArr, pCom, i, j: integer;
const
   fim: array[0..4] of string = ('.com','.net','.gov','.br','.edu');
begin
   pCom := 0;
   pArr := 0;

   email := AnsiLowerCase(email);
   pArr := Pos('@',email);

   for i := pArr to (length(email)) do
   begin
      for j := 0 to high(fim) do
         if (trim(copy(email,i,4)) = fim[j]) then
         begin
            pCom := i;
            break;
         end;
   end;

   result := false;
   if (pArr = 0) then
      exit;

   if (pArr = length(email)) then
      exit;

   if (pArr = 1) then
      exit;

   if (pCom = 0) then
      exit;

   if (pArr >= pCom) then
      exit;

   if ((pArr + 1) = pCom) then
      exit;

   result := true;
end;

function ValidarCEP(Estado: string; CEP: string): boolean;
var
  v1 : integer;
begin
   result := true;

   CEP := StringReplace(CEP,'-','',[rfReplaceAll]);
   CEP := StringReplace(CEP,'.','',[rfReplaceAll]);

   if trim(Estado) = '' then
   begin
      result := false;
      exit;
   end;

   v1 := strToint(Copy(CEP,1,3));
   // 1ª Verificação
   if strToint(CEP) <= 10000000 then
   begin
      result := false;
      exit;
   end;

   // 2ª Verificação
   if (Estado = 'SP') and ((v1 < 10) or (v1 > 199)) then
      result := false
   else
   if (Estado = 'RJ') and ((v1 < 200) or (v1 > 289)) then
      result := false
   else
   if (Estado = 'ES') and ((v1 < 290) or (v1 > 299)) then
      result := false
   else
   if (Estado = 'MG') and ((v1 < 300) or (v1 > 399)) then
      result := false
   else
   if (Estado = 'BA') and ((v1 < 400) or (v1 > 489)) then
      result := false
   else
   if (Estado = 'SE') and ((v1 < 490) or (v1 > 499)) then
      result := false
   else
   if (Estado = 'PE') and ((v1 < 500) or (v1 > 569)) then
      result := false
   else
   if (Estado = 'AL') and ((v1 < 570) or (v1 > 579)) then
      result := false
   else
   if (Estado = 'PB') and ((v1 < 580) or (v1 > 589)) then
      result := false
   else
   if (Estado = 'RN') and ((v1 < 590) or (v1 > 599)) then
      result := false
   else
   if (Estado = 'CE') and ((v1 < 600) or (v1 > 639)) then
      result := false
   else
   if (Estado = 'PI') and ((v1 < 640) or (v1 > 649)) then
      result := false
   else
   if (Estado = 'MA') and ((v1 < 650) or (v1 > 659)) then
      result := false
   else
   if (Estado = 'PA') and ((v1 < 660) or (v1 > 688)) then
      result := false
   else
   if (Estado = 'AM') and ((v1 < 690) or (v1 = 693) or (v1 > 698)) then
      result := false
   else
   if (Estado = 'AP') and (v1 <> 689) then
      result := false
   else
   if (Estado = 'RR') and (v1 <> 693) then
      result := false
   else
   if (Estado = 'AC') and (v1 <> 699) then
      result := false
   else
   if ((Estado = 'DF') or (Estado = 'GO')) and ((v1 < 700) or ( v1 > 767)) then
      result := false
   else
   if (Estado = 'TO') and ((v1 < 770) or (v1 > 779)) then
      result := false
   else
   if (Estado = 'MT') and ((v1 < 780) or (v1 > 788)) then
      result := false
   else
   if (Estado = 'MS') and ((v1 < 790) or (v1 > 799)) then
      result := false
   else
   if (Estado = 'RO') and (v1 <> 789) then
      result := false
   else
   if (Estado = 'PR') and ((v1 < 800) or (v1 > 879)) then
      result := false
   else if (Estado = 'SC') and ((v1 < 880) or (v1 > 899)) then
      result := false
   else
   if (Estado = 'RS') and ((v1 < 900) or (v1 > 999)) then
      result := false;
end;

function RetornarTipo(tipo: integer): string;
begin
   if (tipo = 1) then
      result := 'Varchar'
   else
   if (tipo = 2) then
      result := 'Char'
   else
   if (tipo = 3) then
      result := 'Integer'
   else
   if (tipo = 4) then
      result := 'Float'
   else
   if (tipo = 5) then
      result := 'Numeric'
   else
   if (tipo = 6) then
      result := 'Date'
   else
   if (tipo = 7) then
      result := 'Time'
   else
   if (tipo = 8) then
      result := 'DateTime'
   else
   if (tipo = 9) then
      result := 'Blob';
end;

function StringParaFirebird(texto: string): string;
begin
   texto := trim(texto);
   texto := StringReplace(texto,#10#13,'',[rfReplaceAll]);
   Result := QuotedStr(StringReplace(texto,#39,'"',[rfReplaceAll]));
end;

function DataParaFirebird(Data: string) : string;
begin
   Result := QuotedStr(StringReplace(Data,'/','.',[rfReplaceAll]));
end;

function FloatParaFirebird(numero: string): string;
begin
   numero := StringReplace(numero,'.','',[rfReplaceAll]);
   numero := StringReplace(numero,',','.',[rfReplaceAll]);
   result := numero;
end;

function Formatar_tipo(texto, tipo: string): string;
begin
   if LowerCase(tipo) = 'cpf' then
      result := StringReplace(StringReplace(texto,'.','',[rfReplaceAll]),'-','',[rfReplaceAll])
   else
   if lowercase(tipo) = 'cnpj' then
      result := StringReplace(StringReplace(StringReplace(texto,'.','',[rfReplaceAll]),'-','',[rfReplaceAll]),'/','',[rfReplaceAll])
   else
   if lowercase(tipo) = 'cep' then
      result := StringReplace(StringReplace(texto,'.','',[rfReplaceAll]),'-','',[rfReplaceAll]);
end;

function MontarChaves(grupo:TWinControl; condicao: integer): string;
var
   i: Integer;
   sql_campos, sql_valores: string;
begin
   for i := 0 to grupo.ControlCount -1 do
   begin
      if grupo.Controls[i] is TEdit then
      begin
         if condicao = 1 then
         begin
            sql_campos := sql_campos + copy((grupo.Controls[i] as TEdit).HelpKeyword,5,length((grupo.Controls[i] as TEdit).HelpKeyword)-4)+',';
            sql_valores := sql_valores + StringParaFirebird((grupo.Controls[i] as TEdit).Text)+',';
         end
         else
            sql_valores := sql_valores + copy((grupo.Controls[i] as TEdit).HelpKeyword,5,length((grupo.Controls[i] as TEdit).HelpKeyword)-4)+' = '+StringParaFirebird(LimparString((grupo.Controls[i] as TEdit).Text))+' and ';
      end
      else
      if grupo.Controls[i] is TMaskEdit then
      begin
         if condicao = 1 then
         begin
            sql_campos := sql_campos + copy((grupo.Controls[i] as TMaskEdit).HelpKeyword,5,length((grupo.Controls[i] as TMaskEdit).HelpKeyword)-4)+',';
            sql_valores := sql_valores + StringParaFirebird(LimparString((grupo.Controls[i] as TMaskEdit).Text))+',';
         end
         else
            sql_valores := sql_valores + copy((grupo.Controls[i] as TMaskEdit).HelpKeyword,5,length((grupo.Controls[i] as TMaskEdit).HelpKeyword)-4)+' = '+StringParaFirebird(LimparString((grupo.Controls[i] as TMaskEdit).Text))+' and ';
      end;
   end;

   case condicao of
      1: result := ' ('+copy(sql_campos,1,length(sql_campos)-1)+') values ('+copy(sql_valores,1,length(sql_valores)-1)+')';
      2: result := ' where '+copy(sql_valores,1,length(sql_valores)-4);
   end;
end;

function MontarCampos(grupo: TWinControl): aCampos;
var
   i: integer;
   info: string;
begin
   for i := 0 to grupo.ControlCount-1 do
   begin
      if (grupo.Controls[i] is TEdit) then
      begin
         info := LimparString((grupo.Controls[i] as TEdit).HelpKeyword);
         if copy(info,1,1) = '1' then
            continue;

         SetLength(result,length(result)+1);

         result[high(result)].tabela := LimparString(grupo.HelpKeyword);
         result[high(result)].tipo := StrToInt(copy(info,3,1));
         result[high(result)].nome := copy(info,5,length(info)-4);
         result[high(result)].valor := (grupo.Controls[i] as TEdit).text;

         if (LimparString(result[high(result)].valor) = '') then
            SetLength(result,length(result)-1);
      end
      else
      if (grupo.Controls[i] is TMaskEdit) then
      begin
         info := LimparString((grupo.Controls[i] as TMaskEdit).HelpKeyword);
         if copy(info,1,1) = '1' then
            continue;
         SetLength(result,length(result)+1);

         result[high(result)].tabela := LimparString(grupo.HelpKeyword);
         result[high(result)].tipo := StrToInt(copy(info,3,1));
         result[high(result)].nome := copy(info,5,length(info)-4);

         if result[high(result)].tipo = 1 then
            result[high(result)].valor := (grupo.Controls[i] as TMaskEdit).EditText
         else
            result[high(result)].valor := (grupo.Controls[i] as TMaskEdit).Text;

         if (LimparString(result[high(result)].valor) = '') or (LimparMascara(result[high(result)].valor,(grupo.Controls[i] as TMaskEdit).EditMask) = '') then
            SetLength(result,length(result)-1);
      end
      else
      if (grupo.Controls[i] is TComboBox) then
      begin
         info := LimparString((grupo.Controls[i] as TComboBox).HelpKeyword);
         if copy(info,1,1) = '1' then
            continue;
         SetLength(result,length(result)+1);

         result[high(result)].tabela := LimparString(grupo.HelpKeyword);
         result[high(result)].tipo := StrToInt(copy(info,3,1));
         result[high(result)].nome := copy(info,5,length(info)-4);

         if result[high(result)].tipo = 1 then
            result[high(result)].valor := (grupo.Controls[i] as TComboBox).Text
         else
            result[high(result)].valor := copy((grupo.Controls[i] as TComboBox).Text,1,1);

         if (LimparString(result[high(result)].valor) = '') or ((grupo.Controls[i] as TComboBox).ItemIndex < 0) then
            SetLength(result,length(result)-1);
      end
      else
      if (grupo.Controls[i] is TGroupBox) then
        result := MontarCampos((grupo.Controls[i] as TGroupBox));
   end;
end;


function ExecutarSQL(const p_sql: string): string;
begin
   result := '';

   with dm3.query do
   begin
      Close;
      SQL.Text := p_sql;

      try
         ExecSQL;
         Connection.Commit;
      except
         on e: Exception do
         begin
            Connection.Rollback;
            result := e.Message;
         end;
      end;
      close;
   end;

end;

end.
