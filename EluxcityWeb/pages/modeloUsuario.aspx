﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="modeloUsuario.aspx.cs" Inherits="EluxcityWeb.pages.modeloUsuario" %>

<%
    
    string urlVolta = Session["urlVolta"].ToString();
    
    string tipoAcesso = "administrador";
    HttpCookie cookie = Request.Cookies["tipoAcesso"];
    if (cookie != null)
       tipoAcesso = cookie.Value.ToString();


    tipoAcesso = Request.Params.Get("tipoAcesso");
    if (tipoAcesso.IndexOf(',') != -1)
    {
        tipoAcesso = tipoAcesso.Split(',')[0];
    }


    string idUser = Request.Params.Get("idUser");
    string user = Request.Params.Get("usuario");
    if (idUser.IndexOf(',') != -1)
    {
        idUser = idUser.Split(',')[0];
    }
    if (user.IndexOf(',') != -1)
    {
        user = user.Split(',')[0];
    }
    urlVolta = "index.aspx?idUser=" + idUser + "&username=" + user;

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  
    <script src="../includes/arvore/js/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../includes/arvore/js/jquery-ui-1.10.4.custom.js" type="text/javascript"></script>
    <script src="../includes/arvore/js/jquery.alerts.js" type="text/javascript"></script>
    <script src="../includes/arvore/js/bootstrap.js" type="text/javascript"></script>
    <script src="../includes/arvore/js/bootstrap-table.js" type="text/javascript"></script>
    <script src="../includes/arvore/js/bootstrap-tagsinput.js" type="text/javascript"></script>


    <link rel="stylesheet" type="text/css" href="../includes/arvore/css/jquery-ui-1.10.4.custom.css" />
    <link rel="stylesheet" type="text/css" href="../includes/arvore/css/jquery.alerts.css" />
    <link rel="stylesheet" type="text/css" href="../includes/arvore/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../includes/arvore/css/bootstrap-table.css" />
    <link rel="stylesheet" type="text/css" href="../includes/arvore/css/bootstrap-tagsinput.css" />
    <link rel="stylesheet" type="text/css" href="../includes/arvore/css/estilo.css" />

    <script>
        var codProduto=0;
        var codLinha=0;
        var $j = jQuery.noConflict();
        var $l = jQuery.noConflict();


        $j('document').ready(function () {

            // esse trecho carrega os dados do combo Linha
            $l.ajax({
                type: "POST",
                url: "modelo.aspx/carregaComboLinhaUsuario",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (jasonResult) {

                    var dados = jasonResult.d;
                    document.getElementById('linha').innerHTML = dados;


                }
            });

            carregaDadosTabela();

        });


        function carregaDadosTabela() {

            $j.ajax({
                type: "POST",
                url: "modelo.aspx/carregaModelos",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (jasonResult) {



                    var obj = eval(jasonResult.d);



                    $j('#table-modelo').bootstrapTable({
                        data: obj,
                        cache: false,
                        height: 450,
                        pagination: true,
                        pageSize: 10,
                        pageList: [10, 30, 50, 100, 200],
                        search: true,
                        showColumns: false,
                        showRefresh: false,
                        minimumCountColumns: 2,
                        clickToSelect: true,
                        columns: [{
                            field: 'cod_modelo',
                            width: 1
                        }, {
                            field: 'nome_por',
                            title: 'Modelo (Port.)',
                            width: 80,
                            align: 'left',
                            valign: 'middle',
                            sortable: true
                        }, {
                            field: 'nome_esp',
                            title: 'Modelo (Esp.)',
                            width: 80,
                            align: 'left',
                            valign: 'middle',
                            sortable: true

                        }, {
                            field: 'nome_ing',
                            title: 'Modelo (Ing.)',
                            width: 80,
                            align: 'left',
                            valign: 'middle',
                            sortable: true
                        }, {
                            field: 'linha',
                            title: 'Linha',
                            width: 90,
                            align: 'left',
                            valign: 'middle',
                            sortable: true
                        }, {
                            field: 'produto',
                            title: 'Produto',
                            width: 90,
                            align: 'left',
                            valign: 'middle',
                            sortable: true
                        }]
                    });
                    $j('#table-modelo').bootstrapTable('hideColumn', 'cod_modelo');


                }
            });
        }

        function preencherComboProdutos(codLinha,codProduto) {

            $j.ajax({
                type: "POST",
                url: "modelo.aspx/carregaComboProduto",
                data: "{codigo:'" + codLinha + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (jasonResult) {

                    var dados = jasonResult.d;

                    document.getElementById('produto').innerHTML = dados;

                
                    if(codProduto!='0'){
                        $j("#produto").val(codProduto);
                    }


                }
            });

            carregaDadosTabela();


        }


        function retornaProduto() {
            codProduto = $j("#produto option:selected").val();
        }

        function retornaLinha() {
            codLinha = $l("#linha option:selected").val();
            preencherComboProdutos(codLinha,"0");
        }


      


    </script>
</head>
<body>
    <div class="container-fluid">
     <table border=0 style="width: 100%"><Tr>
          <Td  align="left" style="width: 5%">  <img src="../includes/arvore/imagens/logo.png" class="img-responsive"/></img></Td>
          
           <Td  align="center" style="width: 65%" align="center"><span id="labelCliente">&nbsp;</span></Td>
          
         <td align="right"><span id="labelUsuario">User:</span></td><td><span id="conteudoUsuario">&nbsp;Tadeu Franco</span></td>  
         
         
         
   
          
          
      </Tr></table>
    
    
    
     <br />

      <% if(tipoAcesso.Equals("usuario")){  %>
     <ul>
          <li><a class="liMenu" href="<%=urlVolta%>"  ><img src="../includes/arvore/imagens/home.png" class="img-responsive" style="cursor: pointer;" /></a></li>
            <li><a  href="linhaUsuario.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>" class="liMenu" >Linha</a></li>
            <li><a href="produtoUsuario.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>" class="liMenu">Produto</a></li>
            <li><a class="activeMenu" href="modeloUsuario.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>">Modelo</a></li>
            <li><a href="ocorrenciaUsuario.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>" class="liMenu">Ocorr&ecirc;ncias</a></li>
        </ul>    

         <%}else{ %>
      <ul>
           <li><a class="liMenu" href="<%=urlVolta%>"  ><img src="../includes/arvore/imagens/home.png" class="img-responsive" style="cursor: pointer;" /></a></li>
        <li><a href="linha.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>" class="liMenu">Linha</a></li>
        <li><a href="produto.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>" class="liMenu">Produto</a></li>
        <li><a href="modelo.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>" class="activeMenu">Modelo</a></li>
        <li><a href="ocorrencia.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>" class="liMenu">Ocorr&ecirc;ncias</a></li>
        <li><a href="importacao.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>" class="liMenu">Importa&ccedil;&atilde;o de Dados</a></li>
        <li><a href="relatorios.aspx?idUser=<%=idUser%>&username=<%=user%>&tipoAcesso=<%=tipoAcesso%>&usuario=<%=user%>" class="liMenu">Relat&oacute;rios de uso do Sistema</a></li>
    </ul> 

         <%} %>

  


    <div class="modal-body">

         <table width="100%"><tr>
          <td style="width:20%">&nbsp;</td>
          <td>
              <div class="table-responsive">
         <div id="listagem" style="width:900px;" >
          <div class="panel panel-primary">
              <div class="panel-heading">Listagem dos Modelos</div>
              <table class="table" id="table-modelo"></table>


           </div>

     </div>   
                  </div>
      </td>
          <td style="width:20%">&nbsp;</td>
                          </tr></table>    

    </div>

        </div>
</body>
</html>
