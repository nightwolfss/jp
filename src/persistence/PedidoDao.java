package persistence;

import java.util.ArrayList;

import entity.Pedido;

public class PedidoDao extends Dao{

	public String gravarPedido(Pedido pedido) {
		try {
			conectarBanco();
			stmt = con.prepareStatement("insert into pedido (cliente, clienteId, endereco, prato, observacao, preco) values (?,?,?,?,?,?)");
			stmt.setString(1, pedido.getNomeCliente());
			stmt.setInt(2, pedido.getIdCliente());
			stmt.setString(3, pedido.getEnderecoCliente());
			stmt.setString(4, pedido.getPrato());
			stmt.setString(5, pedido.getObs());
			stmt.setString(6, pedido.getValor());
			stmt.execute();
			con.close();
			return "Pedido salvo com sucesso!!";
		} catch (Exception e) {
			System.out.println("Erro ao salvar pedido: " + e.getMessage());
			return "Falha ao salvar pedido: " + e.getMessage();
		}
	}
	
	public String deletarPedido(Integer id){
		try {
			conectarBanco();
			stmt = con.prepareStatement("delete from pedido where id =" + id);
			stmt.execute();
			con.close();
			return "O Pedido foi deletado com sucesso";
		} catch (Exception e) {
			return "Falha ao deletar pedido: "+ e.getMessage();
		}
		
	}
	
	public ArrayList<Pedido> listaPedidos(){
		ArrayList<Pedido> lista = new ArrayList<Pedido>();
		Pedido p;
		try {
			conectarBanco();
			stmt = con.prepareStatement("SELECT * FROM pedido WHERE DATE(hora) = CURDATE() order by hora desc");
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				p = new Pedido();
				p.setId(rs.getLong("id"));
				p.setNomeCliente(rs.getString("cliente"));
				p.setIdCliente(rs.getInt("clienteId"));
				p.setEnderecoCliente(rs.getString("endereco"));
				p.setPrato(rs.getString("prato"));
				p.setObs(rs.getString("observacao"));
				p.setHora(rs.getTimestamp("hora"));
				p.setValor(rs.getString("preco"));
				
				lista.add(p);
			}
			con.close();
			return lista;
			
		} catch (Exception e) {
			lista.add(new Pedido());
			return lista;
		}
	}
	
	public Pedido findById(Long id) {
		Pedido pedido = null;
		try {
			conectarBanco();
			stmt = con.prepareStatement("select * from pedido where id = "+ id);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				pedido = new Pedido();
				pedido.setId(Long.parseLong(rs.getString("id")));
				pedido.setIdCliente(Integer.parseInt(rs.getString("clienteId")));
				pedido.setNomeCliente(rs.getString("cliente"));
				pedido.setEnderecoCliente(rs.getString("endereco"));
				pedido.setPrato(rs.getString("prato"));
				pedido.setObs(rs.getString("observacao"));
				pedido.setHora(rs.getTimestamp("hora"));
				pedido.setValor(rs.getString("preco"));
			}
			con.close();
		} catch (Exception e) {
			System.out.println("Erro ao obter pedido: "+ e.getMessage());
		}
		return pedido;
	}
}
