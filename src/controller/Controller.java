package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONValue;

import com.google.gson.Gson;

import entity.Cliente;
import entity.Lembrete;
import entity.Pedido;
import entity.Prato;
import persistence.ClienteDao;
import persistence.LembreteDao;
import persistence.PedidoDao;
import persistence.PratoDao;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getParameter("cmd");
		
		if("deletarcliente".equalsIgnoreCase(cmd)) {
			deletarCliente(request, response);			
		}
		if("deletarpedido".equalsIgnoreCase(cmd)) {
			deletarPedido(request, response);			
		}
		if("deletarprato".equalsIgnoreCase(cmd)) {
			deletarPrato(request, response);			
		}		
		if("deletarlembrete".equalsIgnoreCase(cmd)) {
			deletarLembrete(request, response);			
		}
		
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getParameter("cmd");
		String todos = request.getParameter("todos");
		
		if("gravarcliente".equalsIgnoreCase(cmd)) {
			gravarCliente(request, response);
		}
		if("gravarprato".equalsIgnoreCase(cmd)) {
			gravarPrato(request, response);
		}
		if("gravarpedido".equalsIgnoreCase(cmd)) {
			gravarPedido(request, response);
			System.out.println("gravarpedido");
		}
		if("alterarCliente".equalsIgnoreCase(cmd)) {
			System.out.println("Id do modal: " + request.getParameter("idcliente"));
			atualizarCliente(request, response);
		}
		if("lembrete".equalsIgnoreCase(cmd)) {
			gravarLembrete(request, response);
		}
		if("todosospratos".equalsIgnoreCase(todos)) {
			System.out.println("Entrou aqui.");
			listarPratos(request, response);
			
		}
		
	}

	private void listarPratos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Prato p = new Prato();
		response.setContentType("application/json");
		PrintWriter print = response.getWriter();
		String json = new Gson().toJson(p.getListaPratos());
		print.print(json);		
	}
	
	private void gravarPedido(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Pedido p = new Pedido();
		PedidoDao pd = new PedidoDao();
		ClienteDao cd = new ClienteDao();
		
		p.setIdCliente(Integer.parseInt(request.getParameter("idcliente")));
		p.setNomeCliente(cd.findById(Integer.parseInt(request.getParameter("idcliente"))).getNome().toString());
		p.setEnderecoCliente(cd.findById(Integer.parseInt(request.getParameter("idcliente"))).getEnderecoCliente());
		p.setPrato(request.getParameter("prato"));
		p.setObs(request.getParameter("observacao"));
		p.setValor(request.getParameter("preco"));
		
		request.setAttribute("msg", pd.gravarPedido(p));
		request.getRequestDispatcher("pedido.jsp").forward(request, response);
	}

	protected void gravarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			ClienteDao cdao = new ClienteDao();
			Cliente cliente = new Cliente();
			
			cliente.setEnderecoCliente(request.getParameter("endereco"));
			cliente.setNome(request.getParameter("nome"));
			cliente.setTelefoneCliente(request.getParameter("telefone"));
			cliente.setObservacao(request.getParameter("obs"));
			
			String mensagem = cdao.gravarCliente(cliente);
			
			request.setAttribute("msg", mensagem);
			request.getRequestDispatcher("cliente.jsp").forward(request, response);
		
	}
	
	protected void gravarPrato(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			
			PratoDao pdao = new PratoDao();
			Prato prato = new Prato();
			
			prato.setNome(request.getParameter("nome"));
			prato.setDescricaoPrato(request.getParameter("descricao"));
			prato.setCategoria(request.getParameter("categoria"));
			
			String mensagem = pdao.gravarPrato(prato);
			
			request.setAttribute("msg", mensagem);
			request.getRequestDispatcher("prato.jsp").forward(request, response);
		
	}
	
	protected void deletarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			ClienteDao cdao = new ClienteDao();
			String mensagem = cdao.deletarCliente(Integer.parseInt(request.getParameter("id")));
			
			request.setAttribute("msg", mensagem);
			request.getRequestDispatcher("cliente.jsp").forward(request, response);
			
	}
	
	private void deletarPedido(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			PedidoDao pd = new PedidoDao();
			String mensagem = pd.deletarPedido(Integer.parseInt(request.getParameter("id")));
		
			request.setAttribute("msg", mensagem);
			request.getRequestDispatcher("pedido.jsp").forward(request, response);
	}
	
	protected void deletarPrato(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PratoDao pdao = new PratoDao();
		String mensagem = pdao.deletarPrato(Integer.parseInt(request.getParameter("id")));
		
		request.setAttribute("msg", mensagem);
		request.getRequestDispatcher("prato.jsp").forward(request, response);
		
	}
	private void atualizarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ClienteDao cdao = new ClienteDao();
		Cliente cliente = new Cliente();
		
		cliente.setId(Long.parseLong(request.getParameter("idcliente")));
		cliente.setEnderecoCliente(request.getParameter("enderecocliente"));
		cliente.setNome(request.getParameter("nomecliente"));
		cliente.setTelefoneCliente(request.getParameter("telefonecliente"));
		cliente.setObservacao(request.getParameter("obscliente"));
		
		System.out.println("cliente: " + cliente);
		
		String mensagem = cdao.atualizarCliente(cliente);
	
		request.setAttribute("msg", mensagem);
		request.getRequestDispatcher("cliente.jsp").forward(request, response);
}
	
	private void gravarLembrete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Lembrete lembrete = new Lembrete();
		LembreteDao ld = new LembreteDao();
		
		lembrete.setTitulo(request.getParameter("titulolembrete"));
		lembrete.setTexto(request.getParameter("textolembrete"));
		
		String mensagem = ld.gravarLembrete(lembrete);
		request.setAttribute("msg", mensagem);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	
	private void deletarLembrete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LembreteDao ld = new LembreteDao();
		String mensagem = ld.deletarLembrete(Integer.parseInt(request.getParameter("id")));
		request.setAttribute("msg", mensagem);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
	
	
}
