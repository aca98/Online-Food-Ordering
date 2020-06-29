package rs.viser.onlinenarucivanje.jdbc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Component;
import rs.viser.onlinenarucivanje.classes.ProizvodKolicina;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Component
public class ProizvodKolicinaJdbcDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private ProizvodJdbcDAO proizvodJdbcDAO;

    class ProizvodKolicinaRowMapper implements RowMapper<ProizvodKolicina>{
        @Override
        public ProizvodKolicina mapRow(ResultSet resultSet, int i) throws SQLException {
            ProizvodKolicina kol = new ProizvodKolicina();
            kol.setId_kolicina(resultSet.getInt("id_kolicina"));
            kol.setProizvod(proizvodJdbcDAO.getProizvod(resultSet.getInt("id_proizvod")));
            kol.setKolicina(resultSet.getInt("kolicina"));
            return kol;
        }
    }

    public List<ProizvodKolicina> getProizvodKolicina(int id_kolicina){
        return jdbcTemplate.query("select * from dbo.func_Vrati_ProizvodKolicina(?)",new Object[]{id_kolicina},new ProizvodKolicinaRowMapper());
    }
    public void DodajProizvodKolicina(int id_proizvod,int kolicina){
      jdbcTemplate.update("exec dbo.proc_DodajProizvodKolicina ?, ? ",new Object[]{id_proizvod,kolicina});
    }
}
