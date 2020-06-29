package rs.viser.onlinenarucivanje.classes;

import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class Narudzbina {

    private int id_narudzbina;
    private String ime;
    private String prezime;
    private String adresa;
    private List<ProizvodKolicina> list;
    private int preuzeto;

    public Narudzbina(int id_narudzbina, String ime, String prezime, String adresa, List<ProizvodKolicina> list, int preuzeto) {
        this.id_narudzbina = id_narudzbina;
        this.ime = ime;
        this.prezime = prezime;
        this.adresa = adresa;
        this.list = list;
        this.preuzeto = preuzeto;
    }

    public Narudzbina(String ime, String prezime, String adresa, List<ProizvodKolicina> list, int preuzeto) {
        this.id_narudzbina = 0;
        this.ime = ime;
        this.prezime = prezime;
        this.adresa = adresa;
        this.list = list;
        this.preuzeto = preuzeto;
    }

    @Override
    public String toString() {
        return "Narudzbina{" +
                "id_narudzbina=" + id_narudzbina +
                ", ime='" + ime + '\'' +
                ", prezime='" + prezime + '\'' +
                ", adresa='" + adresa + '\'' +
                ", list=" + list +
                ", preuzeto=" + preuzeto +
                '}';
    }

    public Narudzbina() {
    }

    public int getId_narudzbina() {
        return id_narudzbina;
    }

    public void setId_narudzbina(int id_narudzbina) {
        this.id_narudzbina = id_narudzbina;
    }

    public String getIme() {
        return ime;
    }

    public void setIme(String ime) {
        this.ime = ime;
    }

    public String getPrezime() {
        return prezime;
    }

    public void setPrezime(String prezime) {
        this.prezime = prezime;
    }

    public String getAdresa() {
        return adresa;
    }

    public void setAdresa(String adresa) {
        this.adresa = adresa;
    }

    public List<ProizvodKolicina> getList() {
        return list;
    }

    public void setList(List<ProizvodKolicina> list) {
        this.list = list;
    }

    public int getPreuzeto() {
        return preuzeto;
    }

    public void setPreuzeto(int preuzeto) {
        this.preuzeto = preuzeto;
    }
}
