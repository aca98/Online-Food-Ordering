package rs.viser.onlinenarucivanje.classes;


import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class Zaposleni {
    private String username;
    private String password;
    private String ime;
    private String prezime;
    private String adresa;
    private String telefon;
    private LocalDateTime dat_zap;
    private LocalDateTime dat_otkaza;

    public Zaposleni(String username, String password, String ime, String prezime, String adresa, String telefon) {
        this.username = username;
        this.password = password;
        this.ime = ime;
        this.prezime = prezime;
        this.adresa = adresa;
        this.telefon = telefon;
        this.dat_zap = dat_zap;
        this.dat_otkaza = dat_otkaza;
    }


    public Zaposleni(){

    }

    public LocalDateTime getDat_zap() {
        return dat_zap;
    }

    public void setDat_zap(LocalDateTime dat_zap) {
        this.dat_zap = dat_zap;
    }

    public LocalDateTime getDat_otkaza() {
        return dat_otkaza;
    }

    public void setDat_otkaza(LocalDateTime dat_otkaza) {
        this.dat_otkaza = dat_otkaza;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getTelefon() {
        return telefon;
    }

    public void setTelefon(String telefon) {
        this.telefon = telefon;
    }
}
