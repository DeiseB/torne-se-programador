<!--#INCLUDE FILE ="chamar_banco.asp"-->
<!--#INCLUDE FILE ="funcao_senha.asp"-->
<!--#INCLUDE FILE ="CPF_CNPJ.asp"-->
<!--#include file="aDOVBS.inc" -->
<%
imovel=request("imovel")
pagina=request("pagina")
data=request("data")
vencimento=request("vencimento")
currentPage = Request( "currentPage" )
Set contador = Server.CreateObject( "ADODB.Recordset" )
contador.activeConnection = conn
contador.CursorType = adOpenStatic
IF currentPage = "" THEN currentPage = 1
Set itens = Server.CreateObject( "ADODB.Recordset" ) 
itens.activeConnection = conn
itens.CursorType = adOpenStatic  
itens.PageSize = 9
itens.Open "select * from imoveis where codigo="&imovel&" ORDER BY descricao",conn
set exibir=conn.execute("SELECT top 1 *  FROM Ativacao_plano WHERE cod_imovel ="&imovel&" order by data_efetivacao desc")
if request("flag")="1" then%>
   <%conn.execute("update ativacao_plano set data_inativacao=convert(datetime,'"&date()&"',103),status=1, data_efetivacao=null where codigo="&exibir("codigo"))%>
   <script>
      alert('Desativa��o efetuada com sucesso!');
      location.href="main_imoveis.asp";
   </script>
<%end if%>

<html>
<head>
<title>:::::Imobi....:::</title>
<script language="javascript" src="formatacao.js"></script>
<link rel="stylesheet" href="estilo.css" type="text/css">
<meta name="description" content="BIG SOLUTIONS TECNOLOGIA DA INFORMA��O LTDA">
</head>
<body marginheight="0" marginwidth="0" leftmargin=0 topmargin=0 bgcolor="#FFFFFF" text="#333333" link="#333333" vlink="#333333" alink="#333333">
<table border="0" width="777" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <!--#INCLUDE FILE ="Main_Topo.asp"-->
          <form method=post action="<%=request.servervariables("SCRIPT_NAME")%>?flag=1&pagina=<%=pagina%>&imovel=<%=imovel%>" name="form1">
          <table><tr><td></td></tr></table>
          <table width=100% bgcolor=#CCCCCC>
            <tr><td></td></tr>
          </table>
          <table width=100% border=0 bgcolor=#E8E8E8 cellspacing="0" cellpadding="0">
            <tr> 
              <td width=20%><img src="../img/r_11.gif"></td>
              <td class="tb">
                <B>DESATIVA��O PLANO DE MIDIA</B>
              </td>
              <td class="tb" align=right><a href="Imprimir_detalhe_acompanhamento.asp?codigo=<%=imovel%>&pagina=<%=pagina%>&corretor=<%=corretor%>&imovel=<%=imovel%>"><img src="../img/icone-imprimir.gif" border=0></a></td>
            </tr>
            </table>
          <table><tr height=10><td></td></tr></table>
          <table width=100% border=0 cellspacing="0" cellpadding="0">
            <tr>
              <td class="tb" width=130><b>IM�VEL:</b></td>
              <td class="tb"><a href="Detalhe_Imovel.asp?codigo=<%=itens("codigo")%>&pagina=Main_Imoveis"><%=itens("descricao")%></a></td>
            </tr>
            <tr>
              <td class="tb" width=130><b>PLANO:</b></td>
              <%set plano=conn.execute("select * from planos where codigo="&exibir("cod_plano"))%>
              <td class="tb"><a href="Detalhe_Plano_Midia.asp?codigo=<%=plano("codigo")%>&pagina=Main_Imoveis"><%=plano("titulo")%></a></td>
            </tr>
            <tr>
              <td class="tb" width=130><b>DATA ATIVA��O:</b></td>
              <td class="tb"><%=exibir("data_efetivacao")%></td>
            </tr>
            <tr>
              <td class="tb" width=130><b>VENCIMENTO:</b></td>
              <td class="tb"><%
			
			  response.write(DateAdd("D", plano("validade"), exibir("data_efetivacao")))
			  %></td>
            </tr>
            <tr>
              <td class="tb" width=130><b>DIA DE EXIBI��O:</b></td>
              <%if DateDiff("d", exibir("data_efetivacao"), date()) < 0 then%>
                <td class="tb">0</td>
              <%else%>
                <td class="tb"><%=DateDiff("d", exibir("data_efetivacao"), date())%></td>
              <%end if%>
            </tr>
            <tr>
              <td class="tb" width=130><b>VALOR:</b></td>
              <%if DateDiff("d", exibir("data_efetivacao"), date()) > 0 then
                 set valor = conn.execute("Select valor from Planos where codigo = "&exibir("cod_plano")&"")%>
                <td class="tb">R$ <%=formatnumber(valor("valor"),2)%></td>
              <%else%>
                <td class="tb">R$ 0,00</td>
              <%end if%>
            </tr>
              <td align=center>
                 <input type="image" src="../img/ok.gif" value="submit" border=0>
              </td>
          </table>
        </td>
      </tr>
    <table width=100% background="../img/rod_2.gif"><tr><td><br><br></td></tr></table>      
    </form>
  </td>
</tr>
</table>
</body>
</html>