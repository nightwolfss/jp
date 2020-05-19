package entity;

import java.util.ArrayList;

import persistence.LembreteDao;

public class Lembrete {
	
	private Integer id;
	private String titulo;
	private String texto;
	
	ArrayList<Lembrete> lista;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getTexto() {
		return texto;
	}
	public void setTexto(String texto) {
		this.texto = texto;
	}
	
	public ArrayList<Lembrete> getLista() {
		LembreteDao ld = new LembreteDao();
		return this.lista = ld.listarTodosLembretes();
	}
	public void setLista(ArrayList<Lembrete> lista) {
		this.lista = lista;
	}
	@Override
	public String toString() {
		return "Lembrete [id=" + id + ", titulo=" + titulo + ", texto=" + texto + "]";
	}
	
	
	

}
