package persistence;

import java.util.ArrayList;

import entity.Cliente;

public class ClienteDao extends Dao{

	
	public String gravarCliente(Cliente cliente) {
		try {
			conectarBanco();
			stmt = con.prepareStatement("insert into cliente (endereco, nome, telefone, observacao) values (?,?,?,?)");
			stmt.setString(1, cliente.getEnderecoCliente());
			stmt.setString(2, cliente.getNome());
			stmt.setString(3, cliente.getTelefoneCliente());
			stmt.setString(4, cliente.getObservacao());
			stmt.execute();
			System.out.println("Cliente salvo com sucesso.");
			con.close();
			return "Cliente salvo com sucesso.";
	
		} catch (Exception e) {
			System.out.println("Erro: " + e.getMessage());
			return "Falha ao salvar cliente" + e.getMessage();
		}
	}
	
	public String deletarCliente(Integer id) {
		try {
			conectarBanco();
			stmt = con.prepareStatement("delete from cliente where id = "+id);
			stmt.execute();
			con.close();
			return "Cliente deletado com sucesso!!";
		} catch (Exception e) {
			return "Falha ao deletar cliente: "+ e.getMessage();
		}
	}
	
	public Cliente findById(Integer id) {
		Cliente cliente = null;
		try {
			conectarBanco();
			stmt = con.prepareStatement("select * from cliente where id = " + id);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				cliente = new Cliente();
				cliente.setId(rs.getLong("id"));
				cliente.setEnderecoCliente(rs.getString("endereco"));
				cliente.setNome(rs.getString("nome"));
				cliente.setTelefoneCliente(rs.getString("telefone"));
				cliente.setObservacao(rs.getString("observacao"));
			}
			System.out.println(cliente);
			con.close();
		} catch (Exception e) {
			System.out.println("Erro ao buscar cliente: " + e.getMessage());
			e.printStackTrace();
		}
		
		return cliente;
	}
	
	public ArrayList<Cliente> listaCliente(){
		try {
			ArrayList<Cliente> lista = new ArrayList<Cliente>();
			conectarBanco();
			stmt = con.prepareStatement("select * from cliente order by nome asc");
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Cliente cliente = new Cliente();
				cliente.setId(rs.getLong("id"));
				cliente.setEnderecoCliente(rs.getString("endereco"));
				cliente.setNome(rs.getString("nome"));
				cliente.setTelefoneCliente(rs.getString("telefone"));
				cliente.setObservacao(rs.getString("observacao"));
				
				lista.add(cliente);
			}
			con.close();
			return lista;
			
		} catch (Exception e) {
			System.out.println("Erro ao obter lista de clientes:" + e.getMessage());
			return null;
		}
	}
	
	public String atualizarCliente(Cliente cliente) {
		try {
			conectarBanco();
			stmt = con.prepareStatement("update cliente set nome=?, endereco=?, telefone=?, observacao=? where id=?");
			stmt.setString(1, cliente.getNome());
			stmt.setString(2, cliente.getEnderecoCliente());
			stmt.setString(3, cliente.getTelefoneCliente());
			stmt.setString(4, cliente.getObservacao());
			stmt.setLong(5, cliente.getId());
			stmt.execute();
			
			con.close();
			
			return "Cliente atualizado com sucesso.";
		} catch (Exception e) {
			System.out.println("Erro: "+ e.getMessage());
			e.printStackTrace();
			return "Falha ao atualizar cliente: "+ e.getMessage();
		}
	}

	public static void main(String[] args) {
		ArrayList<Cliente> c = new Cliente().getLista();
		System.out.println(c);
	}
}
