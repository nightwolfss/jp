<%@page import="entity.Pedido"%>
<%@page import="entity.Prato"%>
<%@page import="entity.Cliente"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%String uri = request.getRequestURI();
String pageName = uri.substring(uri.lastIndexOf("/")+1);%>

<jsp:useBean id="cli" class="entity.Cliente"/>
<jsp:useBean id="pra" class="entity.Prato"/>
<jsp:useBean id="ped" class="entity.Pedido"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pedido</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="icons/css/all.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body style="background-color: #8B0000">
<div style="background-color: #FFB500; border-radius: 2px;">
<div id="barratopo" class="container">
<span id="titulo" >Cadastrar Pedido</span>
</div>
</div>
<hr>

<div class="container" style="background-color: white; border-radius: 2px;">
<span id="relogio"></span>
</div>

<hr>
<div class="container">
<a href="index.jsp" class="btn btn-sm btn-warning">Início</a> |  
<a href="prato.jsp" class="btn btn-sm btn-warning">Itens</a> |
<a href="cliente.jsp" class="btn btn-sm btn-warning">Clientes</a> | 
<a href="<%=pageName%>" class="btn btn-sm btn-primary">Atualizar</a>
</div>
<hr>
${msg}
<form name="pedidos" action="Controller?cmd=gravarpedido" method="post">

<div class="container" style="color: white;">
Cliente: 
<select name="idcliente" class="custom-select my-1 mr-sm-2">
<%
List<Cliente> clientes = cli.getLista();
for(Cliente c : clientes){
%>	
	<option value="<%=c.getId()%>"><%=c.getNome()%></option>
		
<%}%>	
</select>
</div>

<div class="container">
<div id="quentinha" style="width: 50%; display: none;">

<textarea id='prato' name='prato' class="form-control" aria-label="With textarea" style=' min-width:300px; max-width:100%;min-height:100px; height:100%; width:50%;'></textarea><p>
<table>
	<tr><td>Valor:</td><td><input type="text" placeholder="Ex: 15.50" name="preco" style="width: 100px;"></td><td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
	  Salvar
	</button></td></tr>
</table>

	
</div>

</div>
<p>

<div class="container" style="background-color: white; border-radius: 5px; padding: 3%; box-shadow: 10px 10px 50px grey;">
<table class="table" id="tabela1">
<tr><th>#</th><th>Nome</th><th>Categoria</th>
<%
List<Prato> pratos = pra.getListaPratos();
for(Prato p : pratos){
%>	
	<tr><td><input type="checkbox" name="itens" value="<%=p.getNome()%>"></td><td><%=p.getNome()%></td><td><%=p.getCategoria()%></td></tr>
		
<%}%>
</table>
<input type="button" class="btn btn-success" value="Adicionar" onclick="carrinho()"><br>

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">Quer Adicionar uma Observação?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <textarea id="observacao" name="observacao" style=' max-width:100%;min-height:100px; height:100%; width:100%;'></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
        <button type="submit" class="btn btn-primary">Salvar</button>
      </div>
    </div>
  </div>
</div>
</div>
</form>

<p>
<table id="tabela2" class="table table-sm table-striped container" style="background-color: white; border-radius: 2px; box-shadow: 10px 10px 50px grey;">
	<thead class="thead-dark"><tr><th>ID</th><th>Cliente</th><th>Endereço</th><th>Prato</th><th>Hora do Pedido</th><th>Observação</th><th>Preço</th><th>Deletar</th></tr></thead>
<%List<Pedido> pedidos = ped.getLista();
for(Pedido p : pedidos){
%>
<tbody>
	<tr>
		<td><%=p.getId()%></td>
		<td><a href="detalhepedido.jsp?idpedido=<%=p.getId()%>"><%=p.getNomeCliente()%>(<%=p.getIdCliente()%>)</a></td>
		<td><%=p.getEnderecoCliente()%></td>
		<td><%=p.getPrato()%></td>
		<td><%=p.getHora()%></td>
		<td><%=p.getObs()%></td>
		<td><%=p.getValor()%></td>
		<td><a href="Controller?cmd=deletarpedido&id=<%=p.getId()%>">
			<span style="color: red;"><i class="fas fa-user-times"></i></span></a></td>
	</tr>
<%
}
%>
</tbody>
</table>

<script>
$("#titulo").css({"font-size":"35px"});

if($("#tabela2").width() > $("#prato").width()){
	$("#prato").width($("#tabela2").width());
	$("#barratopo").width($(window).width());
}

setInterval(function(){hora()}, 1000);

function hora(){
	var tempo = new Date();
	var ano = tempo.getFullYear();
	var mes = tempo.getMonth();
	var dia = tempo.getDate();
	
	var hora = tempo.getHours();
	var minuto = tempo.getMinutes();
	var segundo = tempo.getSeconds();
	
	if(mes.toString().length < 2){
		mes = "0".concat(mes);
	}
	
	if(dia.toString().length < 2){
		dia = "0".concat(dia);
	}
	
	if(hora.toString().length < 2){
		hora = "0".concat(hora);
	}
	
	if(minuto.toString().length < 2){
		minuto = "0".concat(minuto);
	}
	
	if(segundo.toString().length < 2){
		segundo = "0".concat(segundo);
	}
	
	var semana = new Array(7);
	semana[0] = "Domingo";
	semana[1] = "Segunda";
	semana[2] = "Terça";
	semana[3] = "Quarta";
	semana[4] = "Quinta";
	semana[5] = "Sexta";
	semana[6] = "Sábado";

	  var diasemana = semana[tempo.getDay()];
	
	$("#relogio").html(diasemana +", "+dia+"/"+mes+"/"+ano+" - "+hora+":"+minuto+":"+segundo);
	
}

    function carrinho(){
    	var a = document.querySelectorAll("#tabela1 tr");
    	var aux = "";
    		for(count=0; count<a.length -1; count++){
    	    	if(pedidos.itens[count].checked){
    	        	aux = aux.concat(pedidos.itens[count].value + " - ");
    	        }
    	    }
    		$("#prato").val(aux);
    		$("#quentinha").css("display","") ;    	    
    	}
</script>
</body>
</html>