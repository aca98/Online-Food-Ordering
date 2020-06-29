package rs.viser.onlinenarucivanje.classes;


import org.springframework.stereotype.Component;

@Component
public class ProizvodKolicina {

    private int id_kolicina;
    private Proizvod proizvod;
    private int kolicina;
    private int velicina;

    public ProizvodKolicina(int id_kolicina, Proizvod proizvod, int kolicina, int velicina) {
        this.id_kolicina = id_kolicina;
        this.proizvod = proizvod;
        this.kolicina = kolicina;
        this.velicina = velicina;
    }

    @Override
    public String toString() {
        return "ProizvodKolicina{" +
                "id_kolicina=" + id_kolicina +
                ", proizvod=" + proizvod +
                ", kolicina=" + kolicina +
                ", velicina=" + velicina +
                '}';
    }

    public ProizvodKolicina(Proizvod proizvod, int kolicina, int velicina) {
        this.id_kolicina = 0;
        this.proizvod = proizvod;
        this.kolicina = kolicina;
        this.velicina = velicina;
    }
    public ProizvodKolicina() {
    }

    public int getId_kolicina() {
        return id_kolicina;
    }

    public void setId_kolicina(int id_kolicina) {
        this.id_kolicina = id_kolicina;
    }

    public Proizvod getProizvod() {
        return proizvod;
    }

    public void setProizvod(Proizvod proizvod) {
        this.proizvod = proizvod;
    }

    public int getKolicina() {
        return kolicina;
    }

    public void setKolicina(int kolicina) {
        this.kolicina = kolicina;
    }

    public int getVelicina() {
        return velicina;
    }

    public void setVelicina(int velicina) {
        this.velicina = velicina;
    }
}
