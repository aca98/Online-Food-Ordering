package rs.viser.onlinenarucivanje.jdbc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;
import rs.viser.onlinenarucivanje.classes.Isporuceno;
import rs.viser.onlinenarucivanje.classes.Narudzbina;
import rs.viser.onlinenarucivanje.classes.ProizvodKolicina;
import rs.viser.onlinenarucivanje.classes.Zaposleni;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;

@Component
public class IsporucenoJdbcDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private ProizvodKolicinaJdbcDAO kolicinaJdbcDAO;
    @Autowired
    private ZaposleniJdbcDAO zaposleniJdbcDAO;

    class IsporucenoRowMapper implements RowMapper<Isporuceno>{
        @Override
        public Isporuceno mapRow(ResultSet resultSet, int i) throws SQLException {
            Zaposleni zap = new Zaposleni();
            zap.setUsername(resultSet.getString("username"));
            zap.setPassword(resultSet.getString("password"));
            zap.setIme(resultSet.getString("zapime"));
            zap.setPrezime(resultSet.getString("zapprezime"));
            zap.setAdresa(resultSet.getString("zapadresa"));
            zap.setTelefon(resultSet.getString("zaptelefon"));
            zap.setDat_zap(resultSet.getTimestamp("dat_zap").toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
            try{
                zap.setDat_otkaza(resultSet.getTimestamp("dat_otkaza").toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
            }catch (Exception e){
                zap.setDat_otkaza(null);
            }
            Isporuceno nar = new Isporuceno();
            nar.setId_isporuceno(resultSet.getInt("id_isporuceno"));
            nar.setUsername(zap);
            nar.setIme(resultSet.getString("ime"));
            nar.setPrezime(resultSet.getString("prezime"));
            nar.setAdresa(resultSet.getString("adresa"));
            nar.setList(kolicinaJdbcDAO.getProizvodKolicina(resultSet.getInt("id_kolicina")));
            nar.setPreuzeto(resultSet.getInt("preuzeto"));
            nar.setVreme_Preuzimanja(resultSet.getTimestamp("vreme_Preuzimanja").toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
            nar.setVreme_Predaje(resultSet.getTimestamp("vreme_Predaje").toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
            return nar;
        }
    }

    public List<Isporuceno> allIsporuceno(){
        return jdbcTemplate.query("select * from view_Isporuceno",new IsporucenoRowMapper());
    }
    public Isporuceno getIsporuceno(int id){
        return jdbcTemplate.queryForObject("select * from dbo.func_NadjiIsporuceno(?)",new Object[]{id},new IsporucenoRowMapper());
    }
}
