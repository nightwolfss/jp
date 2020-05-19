<%@page import="entity.Prato"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%String uri = request.getRequestURI();
String pageName = uri.substring(uri.lastIndexOf("/")+1);%>
<jsp:useBean id="dao" class="entity.Prato"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pratos</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body style="background-color: #8B0000">
<div class="container" style="background-color: #FFB500; border-radius: 2px;">
<span id="titulo" >Cadastrar Itens</span>
</div>
<hr>

<div class="container" style="background-color: white; border-radius: 2px;">
<span id="relogio"></span>
</div>

<hr>
<div class="container">
<a href="index.jsp" class="btn btn-sm btn-warning">Início</a> |  
<a href="cliente.jsp" class="btn btn-sm btn-warning">Clientes</a> |
<a href="pedido.jsp" class="btn btn-sm btn-warning">Pedido</a> | 
<a href="<%=pageName%>" class="btn btn-sm btn-primary">Atualizar</a>
</div>
<hr>

<div class="container" style="background-color: white; border-radius: 5px; padding: 5px; margin-bottom: 10px">
${msg}
</div>

<form action="Controller?cmd=gravarprato" method="post">

<div class="container" style="background-color: white; border-radius: 5px; padding: 3%;">
<table class="table table-sm" style="background-color: white;">
<tr><td>Nome</td><td><input type="text" name="nome" id="nomeprato" class="input-group mb-3 form-control"></td>
<tr><td>Descrição:<td><input type="text" name="descricao" id="descprato" class="input-group mb-3 form-control"></td>
<tr><td>Categoria:<td><input type="text" name="categoria" id="categoria" class="input-group mb-3 form-control"></td>
</table>

<input type="submit" value="gravar" class="btn btn-success" style="box-shadow: 2px 2px 10px grey;"><p>
</div>

</form>

<div class="container" style="background-color: white; border-radius: 5px; margin-top: 10px;">
<table class="table table-sm"><tr><th>Id</th><th>Nome</th><th>DeScrição</th><th>Categoria</th><th>Deletar</th></tr>
<%	List<Prato> pratos = dao.getListaPratos();
	for(Prato p : pratos){
%>
	<tr><td><%=pratos.indexOf(p) + 1%></td><td><%=p.getNome()%></td><td><%=p.getDescricaoPrato()%></td><td><%=p.getCategoria()%></td><td><a href="Controller?cmd=deletarprato&id=<%=p.getId()%>"><button class="badge badge-sm btn">apagar</button> </a> </td></tr>
<%		
	}
%>
</table>
</div>

<div id="resultado"></div>
<script>
	$("#titulo").css({"font-size":"35px"});
	
	$(".btn").css({"box-shadow": "2px 2px 10px grey"});
	
	setInterval(function(){hora()}, 1000);
	setInterval(function(){atualizar()}, 5000);
	
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

</script>
</body>
</html>