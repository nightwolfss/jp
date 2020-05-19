<%@page import="persistence.LembreteDao"%>
<%@page import="entity.Lembrete"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%String uri = request.getRequestURI();
String pageName = uri.substring(uri.lastIndexOf("/")+1);%>
<jsp:useBean id="dao" class="entity.Lembrete"/>
<jsp:useBean id="pedido" class="entity.Pedido"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>index</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="background-color: black">
<div style="background-color: #FFB500; border-radius: 2px;">
<div class="container"><span id="titulo">Página inicial</span><br>
</div>
</div>
<hr>
<div class="container" style="background-color: white; border-radius: 2px;">
<span id="relogio"></span>
</div>
<hr>
<div class="container">
<div class="jumbotron">
  <h1 class="display-4">JP Refeições!</h1>
  <p class="lead"></p>
  <hr class="my-4">
  <span id="msg">${msg}</span>
  <table class="table">
<%
	ArrayList<Lembrete> lembretes = dao.getLista();
	try{
	  	if(lembretes.size() > 0){
	  	%>
			<tr><td colspan="2" style="width: 25px;"><span>Lembretes:</span></td><td><button type="button" class="badge badge-primary" data-toggle="modal" data-target="#exampleModalCenter">Novo</button></td></tr>
		<%
		  	for(Lembrete lembrete : lembretes){
		%>
			<tr  data-toggle="tooltip" data-placement="right" title="<%=lembrete.getTexto()%>"><td style="width: 25px;"><%=lembretes.indexOf(lembrete) + 1%></td>
			<td><span class="titulolembrete"><%=lembrete.getTitulo()%></span></td>
			<td><a href="Controller?cmd=deletarlembrete&id=<%=lembrete.getId()%>"><button  class="badge badge-sm"> deletar</button></a></td></tr>
  		<%
		  	}
	  		
	  	}else{
  			%>
  			<tr><td>Não há lembretes.</td><td><button type="button" class="badge badge-primary" data-toggle="modal" data-target="#exampleModalCenter">criar</button></td></tr>
  			<%
	  	}
	}catch(Exception e){
		%>
		<tr><td>Erro ao listar lembretes: <%=e.getMessage()%></td></tr>
		<%
	}
%>
  </table>
  <hr class="my-4">
  <%
  if(pedido.getLista().size() > 0){
	  %>
	  <marquee><%=pedido.getLista()%></marquee>
	  <%
  }else{
	  %>
	  <span>Não há pedidos.</span><p><p>
	  <%
  }
  %>
  
<!--   <p>It uses utility classes for typography and spacing to space content out within the larger container.</p> -->
  <a href="cliente.jsp" class="btn btn-lg btn-warning">Clientes</a> | <a href="prato.jsp" class="btn btn-lg btn-warning">Itens</a> | <a href="pedido.jsp" class="btn btn-lg btn-warning">Pedido</a><p>
</div>
</div>

	
<form action="Controller?cmd=lembrete" method="post">
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">Novo lembrete</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<span>Título</span><br><input type="text" name="titulolembrete">
      </div>
      <div class="modal-body">
      	<span>Texto</span><br>
        <textarea id="observacao" name="textolembrete" style=' max-width:100%;min-height:100px; height:100%; width:100%;'></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
        <button type="submit" class="btn btn-primary">Salvar</button>
      </div>
    </div>
  </div>
</div>
</form>
<script>

	$(document).ready(function(){
	
	$("#titulo").css({"font-size":"35px"});
	
	$("#msg").fadeOut(500);
	$("#msg").fadeIn(500);
	$("#msg").fadeOut(500);
	$("#msg").fadeIn(500);
	
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
		
		$(".titulolembrete").fadeOut(500);
		$(".titulolembrete").fadeIn(500);
	}
	});
</script>

</body>
</html>