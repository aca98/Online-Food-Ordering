package rs.viser.onlinenarucivanje.classes;

import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@Component
public class Isporuceno {

    private int id_isporuceno;
    private Zaposleni username;
    private String ime;
    private String prezime;
    private String adresa;
    private List<ProizvodKolicina> list;
    private int preuzeto;
    private LocalDateTime vreme_Preuzimanja;
    private LocalDateTime vreme_Predaje;

    public Isporuceno(int id_isporuceno, Zaposleni username, String ime, String prezime, String adresa, List<ProizvodKolicina> list, int preuzeto, LocalDateTime vreme_Preuzimanja, LocalDateTime vreme_Predaje) {
        this.id_isporuceno = id_isporuceno;
        this.username = username;
        this.ime = ime;
        this.prezime = prezime;
        this.adresa = adresa;
        this.list = list;
        this.preuzeto = preuzeto;

        this.vreme_Preuzimanja = vreme_Preuzimanja;
        this.vreme_Predaje = vreme_Predaje;
    }
    public Isporuceno(Zaposleni username, String ime, String prezime, String adresa, List<ProizvodKolicina> list, int preuzeto, LocalDateTime vreme_Preuzimanja, LocalDateTime vreme_Predaje) {
        this.id_isporuceno = 0;
        this.username = username;
        this.ime = ime;
        this.prezime = prezime;
        this.adresa = adresa;
        this.list = list;
        this.preuzeto = preuzeto;
        this.vreme_Preuzimanja = vreme_Preuzimanja;
        this.vreme_Predaje = vreme_Predaje;
    }
    public Isporuceno() {
    }
    @Override
    public String toString() {
        return "Isporuceno{" +
                "id_isporuceno=" + id_isporuceno +
                ", username='" + username + '\'' +
                ", ime='" + ime + '\'' +
                ", prezime='" + prezime + '\'' +
                ", adresa='" + adresa + '\'' +
                ", list=" + list +
                ", preuzeto=" + preuzeto +
                '}';
    }



    public Zaposleni getUsername() {
        return username;
    }

    public void setUsername(Zaposleni username) {
        this.username = username;
    }

    public int getId_isporuceno() {
        return id_isporuceno;
    }

    public void setId_isporuceno(int id_isporuceno) {
        this.id_isporuceno = id_isporuceno;
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

    public LocalDateTime getVreme_Preuzimanja() {
        return vreme_Preuzimanja;
    }

    public void setVreme_Preuzimanja(LocalDateTime vreme_Preuzimanja) {
        this.vreme_Preuzimanja = vreme_Preuzimanja;
    }

    public LocalDateTime getVreme_Predaje() {
        return vreme_Predaje;
    }

    public void setVreme_Predaje(LocalDateTime vreme_Predaje) {
        this.vreme_Predaje = vreme_Predaje;
    }
}
