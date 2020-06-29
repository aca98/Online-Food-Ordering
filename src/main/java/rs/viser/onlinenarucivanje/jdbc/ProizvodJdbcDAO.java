package rs.viser.onlinenarucivanje.jdbc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import rs.viser.onlinenarucivanje.classes.Proizvod;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProizvodJdbcDAO {

    @Autowired
    JdbcTemplate jdbcTemplate;

    class ProizvodRowMapper implements RowMapper<Proizvod> {
        @Override
        public Proizvod mapRow(ResultSet resultSet, int i) throws SQLException {
            Proizvod proizvod = new Proizvod();
            proizvod.setId_proizvod(resultSet.getInt("id_proizvod"));
            proizvod.setNaziv(resultSet.getString("naziv"));
            proizvod.setSastojci(resultSet.getString("sastojci"));
            proizvod.setCena(resultSet.getInt("cena"));
            return proizvod;
        }
    }

    public List<Proizvod> sviProizvodi() {
        return jdbcTemplate.query("select * from dbo.func_Vrati_Proizvod(0)", new ProizvodRowMapper());
    }
    public List<Proizvod> sviObrisaniProizvodi() {
        return jdbcTemplate.query("select * from dbo.func_Vrati_Proizvod(1)", new ProizvodRowMapper());
    }
    public void PromeniProizvod(int Id,String naziv,String sastojci,int cena) {
        jdbcTemplate.update("exec dbo.proc_PromeniProizvod ?,?,?,?", new Object[]{Id,naziv,sastojci,cena});
    }
    public Proizvod getProizvod(int id_proizvod) {
        return jdbcTemplate.queryForObject("select * from dbo.func_Nadji_Proizvod(?)",new Object[]{id_proizvod}, new ProizvodRowMapper());
    }
    public int dodajProizvod(Proizvod proizvod) {
       return jdbcTemplate.update("exec dbo.proc_Dodaj_Proizvod ?,?,?", new Object[]{proizvod.getNaziv(), proizvod.getSastojci(), proizvod.getCena()});
    }
    public void ObrisiProizvod(int id) {
        jdbcTemplate.update("exec dbo.proc_ObrisiProizvod ?", new Object[]{id});
    }
    public void VratiProizvod(int id) {
        jdbcTemplate.update("exec dbo.proc_VratiProizvod ?", new Object[]{id});
    }
    public List<Proizvod> FiltrirajProizvodPoNazivu(String filter) {
         return jdbcTemplate.query("select * FROM dbo.func_FiltrirajProizvode(?)", new Object[]{filter}, new ProizvodRowMapper());
    }
}
