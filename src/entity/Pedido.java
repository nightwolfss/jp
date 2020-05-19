package entity;

import java.sql.Timestamp;
import java.util.ArrayList;

import persistence.PedidoDao;

public class Pedido {
	
	private Long id;
	
	private String nomeCliente;
	
	private Integer idCliente;
	
	private String enderecoCliente; 
	
	private String prato;
	
	private String obs;
	
	private Timestamp hora;
	
	private String valor;

	private Pedido pedido;
	
	ArrayList<Pedido> lista;
	

	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNomeCliente() {
		return nomeCliente;
	}

	public void setNomeCliente(String nomeCliente) {
		this.nomeCliente = nomeCliente;
	}

	public Integer getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(Integer idCliente) {
		this.idCliente = idCliente;
	}

	public String getEnderecoCliente() {
		return enderecoCliente;
	}

	public void setEnderecoCliente(String enderecoCliente) {
		this.enderecoCliente = enderecoCliente;
	}

	public String getPrato() {
		return prato;
	}

	public void setPrato(String prato) {
		this.prato = prato;
	}

	public String getObs() {
		return obs;
	}

	public void setObs(String obs) {
		this.obs = obs;
	}

	public Timestamp getHora() {
		return hora;
	}

	public void setHora(Timestamp hora) {
		this.hora = hora;
	}

	public String getValor() {
		return valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}

	public Pedido getPedido() {
		return pedido;
	}

	public ArrayList<Pedido> getLista() {
		PedidoDao pd = new PedidoDao();
		return this.lista = pd.listaPedidos();
	}

	public void setLista(ArrayList<Pedido> lista) {
		this.lista = lista;
	}

	
	public Pedido getPedido(Long idPedido) {
		PedidoDao pd = new PedidoDao();
		return this.pedido = pd.findById(idPedido);
	}

	public void setPedido(Pedido pedido) {
		this.pedido = pedido;
	}

	@Override
	public String toString() {
		return "Pedido [Número: " + id + " | nomeCliente: " + nomeCliente + " | prato: " + prato
				+ " | obs: " + obs + " | valor: " + valor + "]";
	}

}
