package rs.viser.onlinenarucivanje.jdbc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import rs.viser.onlinenarucivanje.classes.Zaposleni;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.ZoneId;
import java.util.List;

@Repository
public class ZaposleniJdbcDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    class ZaposleniRowMapper implements RowMapper<Zaposleni>{

        @Override
        public Zaposleni mapRow(ResultSet resultSet, int i) throws SQLException {
            Zaposleni zap = new Zaposleni();
            zap.setUsername(resultSet.getString("username"));
            zap.setPassword(resultSet.getString("password"));
            zap.setIme(resultSet.getString("ime"));
            zap.setPrezime(resultSet.getString("prezime"));
            zap.setAdresa(resultSet.getString("adresa"));
            zap.setTelefon(resultSet.getString("telefon"));
            zap.setDat_zap(resultSet.getTimestamp("dat_zap").toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
            try{
                zap.setDat_otkaza(resultSet.getTimestamp("dat_otkaza").toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
            }catch (Exception e){
                zap.setDat_otkaza(null);
            }

            return zap;
        }
    }
    public List<Zaposleni> sviZaposleni(){
        return jdbcTemplate.query("select * from View_Zaposleni", new ZaposleniRowMapper());
    }
    public Zaposleni getZaposleni(String username){
        return jdbcTemplate.queryForObject("select * from dbo.func_NadjiZaposlenog(?)", new Object[]{username}, new ZaposleniRowMapper());
    }
    public Zaposleni getZaposleniSvi(String username){
        return jdbcTemplate.queryForObject("select * from dbo.func_NadjiZaposlenog_i_Otpustenog(?)", new Object[]{username}, new ZaposleniRowMapper());
    }
    public int dodajZaposlenog(Zaposleni zap){
        try{
            return jdbcTemplate.update("exec dbo.proc_DodajZaposlenog ?,?,?,?,?,?", new Object[]{zap.getUsername(),zap.getPassword(),zap.getIme(),zap.getPrezime(),zap.getAdresa(),zap.getTelefon()});
        }catch (Exception e){
            return -1;
        }
    }
    public int ObrisiZaposlenog(String username){
        return jdbcTemplate.update("exec dbo.proc_ObrisiZaposlenog ? ",new Object[]{username});
    }
}
