package persistence;

import java.util.ArrayList;

import entity.Lembrete;

public class LembreteDao extends Dao{

	public String gravarLembrete(Lembrete lembrete) {
		try {
			conectarBanco();
			stmt = con.prepareStatement("insert into lembrete (titulo, texto) values (?,?)");
			stmt.setString(1, lembrete.getTitulo());
			stmt.setString(2, lembrete.getTexto());
			stmt.execute();
			
			con.close();
			
			return lembrete.getTitulo() + " salvo com sucesso!";
			
		} catch (Exception e) {
			System.out.println("LembreteDao | gravarLembrete: " + e.getMessage());
			return "Erro ao salvar o lembrete '"+ lembrete.getTitulo()+"': " + e.getMessage();
		}
	}
	
	public String deletarLembrete(Integer id) {
		try {
			conectarBanco();
			stmt = con.prepareStatement("delete from lembrete where id=?");
			stmt.setInt(1, id);
			stmt.execute();
			
			con.close();
			
			return "Lembrete excluído com sucesso!";
			
		} catch (Exception e) {
			System.out.println("LembreteDao | deletarLembrete: " + e.getMessage());
			return "Erro ao deletar lembrete: " + e.getMessage();
		}
	}
	
	public Lembrete buscarLembretePorId(Integer id){
		Lembrete lembrete = null;
		try {
			conectarBanco();
			stmt = con.prepareStatement("select * from lembrete where id=?");
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				lembrete = new Lembrete();
				lembrete.setId(rs.getInt("id"));
				lembrete.setTitulo(rs.getString("titulo"));
				lembrete.setTexto(rs.getString("texto"));
			}
			
			return lembrete;
			
		} catch (Exception e) {
			System.out.println("LembreteDao | buscarLembretePorId: " + e.getMessage());
			return null;
		}
	}
	
	public ArrayList<Lembrete> listarTodosLembretes(){
		ArrayList<Lembrete> lista = new ArrayList<Lembrete>();
		Lembrete lembrete;
		try {
			conectarBanco();
			stmt = con.prepareStatement("select * from lembrete");
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				lembrete = new Lembrete();
				lembrete.setId(rs.getInt("id"));
				lembrete.setTitulo(rs.getString("titulo"));
				lembrete.setTexto(rs.getString("texto"));
				lista.add(lembrete);
			}
			
			return lista;
			
		} catch (Exception e) {
			System.out.println("LembreteDao | listarTodosLembretes: " + e.getMessage());
			return null;
		}
	}
	
	
}
