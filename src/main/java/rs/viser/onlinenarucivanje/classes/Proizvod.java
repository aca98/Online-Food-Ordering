package rs.viser.onlinenarucivanje.classes;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;


@Component
public class Proizvod {
    private int id_proizvod;
    private String naziv;
    private String sastojci;
    private int cena;

    public Proizvod(int id_proizvod, String naziv, String sastojci, int cena) {
        this.id_proizvod = id_proizvod;
        this.naziv = naziv;
        this.sastojci = sastojci;
        this.cena = cena;
    }
    public Proizvod( String naziv, String sastojci, int cena) {
        this.id_proizvod = 0;
        this.naziv = naziv;
        this.sastojci = sastojci;
        this.cena = cena;
    }
    public Proizvod(){

    }

    public int getId_proizvod() {
        return id_proizvod;
    }

    public void setId_proizvod(int id_proizvod) {
        this.id_proizvod = id_proizvod;
    }

    public String getNaziv() {
        return naziv;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    public String getSastojci() {
        return sastojci;
    }

    public void setSastojci(String sastojci) {
        this.sastojci = sastojci;
    }

    public int getCena() {
        return cena;
    }

    public void setCena(int cena) {
        this.cena = cena;
    }
}
