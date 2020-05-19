package entity;

import java.io.Serializable;
import java.util.ArrayList;

import persistence.PratoDao;

public class Prato implements Serializable{

	private static final long serialVersionUID = 1L;

	private Long id;
	
	private String nome;
	private String descricaoPrato;
	private String categoria;
	
	ArrayList<Prato> listaPratos;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescricaoPrato() {
		return descricaoPrato;
	}

	public void setDescricaoPrato(String descricaoPrato) {
		this.descricaoPrato = descricaoPrato;
	}

	
	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public ArrayList<Prato> getListaPratos() {
		PratoDao pl = new PratoDao();
		return this.listaPratos = pl.listaPrato();
	}

	public void setListaPratos(ArrayList<Prato> listaPratos) {
		this.listaPratos = listaPratos;
	}

	@Override
	public String toString() {
		return "Prato [id=" + id + ", nome=" + nome + ", descricaoPrato=" + descricaoPrato + ", categoria=" + categoria
				+ "]";
	}

	
}
