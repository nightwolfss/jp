<%@page import="persistence.ClienteDao"%>
<%@page import="entity.Cliente"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.Clinit"%>
<%@page import="entity.Pedido"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <jsp:useBean id="ped" class="entity.Pedido"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<h1>Detalhes do Pedido</h1>

<%Pedido p = new Pedido().getPedido(Long.parseLong(request.getParameter("idpedido")));
ClienteDao cd = new ClienteDao();
%>
<table class="table table-sm">
	<tr><td>Cliente</td><td><%=p.getNomeCliente()%></td></tr>
	<tr><td>Endereço</td><td><%=p.getEnderecoCliente()%></td></tr>
	<tr><td>Pedido</td><td><%=p.getPrato()%></td></tr>
	<tr><td>Preço</td><td><%=p.getValor()%></td></tr>
</table>
</body>
</html>