package rs.viser.onlinenarucivanje.jdbc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;
import rs.viser.onlinenarucivanje.classes.Narudzbina;
import rs.viser.onlinenarucivanje.classes.ProizvodKolicina;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

@Component
public class NarudzbinaJdbcDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private ProizvodKolicinaJdbcDAO kolicinaJdbcDAO;


    class NarudzbinaRowMapper implements RowMapper<Narudzbina>{
        @Override
        public Narudzbina mapRow(ResultSet resultSet, int i) throws SQLException {
            Narudzbina nar = new Narudzbina();
            nar.setId_narudzbina(resultSet.getInt("id_narudzbina"));
            nar.setIme(resultSet.getString("ime"));
            nar.setPrezime(resultSet.getString("prezime"));
            nar.setAdresa(resultSet.getString("adresa"));
            nar.setList(kolicinaJdbcDAO.getProizvodKolicina(resultSet.getInt("id_kolicina")));
            nar.setPreuzeto(resultSet.getInt("preuzeto"));
            return nar;
        }
    }

    public int Isporuceno(int id){
        return jdbcTemplate.update("exec dbo.proc_Isporuceno ?",new Object[]{id});
    }

    public HashMap<String,Narudzbina> allNarudzbinaHashMap(){
        HashMap<String,Narudzbina> hash = new HashMap<>();
        List<Narudzbina> list = jdbcTemplate.query("select * from View_Narudzbina",new NarudzbinaRowMapper());
        for (Narudzbina nar:list) {
            hash.put(""+nar.getId_narudzbina(),nar);
        }
        return hash;
    }
    public void DodajNarudzbina(String ime, String prezime, String adresa, int preuzeto, HashMap<String,ProizvodKolicina> lista ){
        jdbcTemplate.update("exec dbo.proc_DodajNarudzbinu ?,?,?",new Object[]{ime,prezime,adresa});

        for (ProizvodKolicina p:lista.values()) {
            kolicinaJdbcDAO.DodajProizvodKolicina(p.getProizvod().getId_proizvod(),p.getKolicina());
        }
    }
    public void PreuzmiNarudzbinu( int id,String username){
        jdbcTemplate.update("exec dbo.proc_PreuzmiNarudzbinu ?,?",new Object[]{id,username});
    }
    public HashMap<String,Narudzbina> PreuzeteNarudzbineHashMap(String username){
        HashMap<String,Narudzbina> hash = new HashMap<>();
        List<Narudzbina> list = jdbcTemplate.query("select * from dbo.func_PreuzeteNarudzbineZaposlenog(?)",new Object[]{username},new NarudzbinaRowMapper());
        for (Narudzbina nar:list) {
            hash.put(""+nar.getId_narudzbina(),nar);
        }
        return hash;
    }
}
