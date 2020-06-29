package rs.viser.onlinenarucivanje.controller;

import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import rs.viser.onlinenarucivanje.classes.*;
import rs.viser.onlinenarucivanje.jdbc.IsporucenoJdbcDAO;
import rs.viser.onlinenarucivanje.jdbc.NarudzbinaJdbcDAO;
import rs.viser.onlinenarucivanje.jdbc.ProizvodJdbcDAO;
import rs.viser.onlinenarucivanje.jdbc.ZaposleniJdbcDAO;

import java.util.HashMap;
import java.util.concurrent.ExecutionException;

@Controller
public class WebController {
    private Zaposleni zaposleni;
    private HashMap<String,ProizvodKolicina> korpa = new HashMap<String,ProizvodKolicina>(10);
    private HashMap<String,Narudzbina> listaNardzbina = new HashMap<>();
    private HashMap<String,Narudzbina> preuzetoNardzbina = new HashMap<>();
    private Gson gson = new Gson();

    @Autowired
    private ProizvodJdbcDAO proizvodDb;
    @Autowired
    private ZaposleniJdbcDAO zaposleniDb;
    @Autowired
    private NarudzbinaJdbcDAO narudzbinaDb;
    @Autowired
    private IsporucenoJdbcDAO isporucenoDb;


    @GetMapping("/")
    public String test(Model model){
        korpa.clear();
        model.addAttribute("test",proizvodDb.sviProizvodi());
        return "index.html";
    }
    @GetMapping("/dodaj")
    public String view_dodaj(){
        return "dodaj.html";
    }


    @GetMapping("/login")
    public String view_login(){
        return "login.html";
    }
    @GetMapping("/promeni")
    public String view_promeni(Model model){
        model.addAttribute("test",proizvodDb.sviProizvodi());
        return "promeni.html";
    }
    @PostMapping("/promeni")
    public String promeni(@RequestParam String id,@RequestParam String naziv,@RequestParam String sastojci,@RequestParam String cena, Model model){
        if(id.equals("")){
            String message = "<h1 id=\"emailHelp\" class=\"text-danger\">Niste selektovali proizvod.</h1>";
            model.addAttribute("test",proizvodDb.sviProizvodi());
            model.addAttribute("errorStyle","border-danger");
            model.addAttribute("errorMess",message);
            return "promeni.html";
        }
        if (naziv.equals("") || sastojci.equals("") || cena.equals("")){
            String message = "<h1 id=\"emailHelp\" class=\"text-danger\">Sva polja moraju da budu popunjena.</h1>";
            model.addAttribute("test",proizvodDb.sviProizvodi());
            model.addAttribute("errorStyle","border-danger");
            model.addAttribute("errorMess",message);
            return "promeni.html";
        }else {
            try{
                proizvodDb.PromeniProizvod(Integer.parseInt(id),naziv,sastojci,Integer.parseInt(cena));
                String message = "<h1 class=\"text-success\">Proizvod uspesno promenjen.</h1>";
                model.addAttribute("errorMess",message);
                model.addAttribute("test",proizvodDb.sviProizvodi());

                return "promeni.html";
            }catch (Exception e){
                String message = "<h1 id=\"emailHelp\" class=\"text-danger\">U polje cena mora da bude broj.</h1>";
                model.addAttribute("errorStyle","border-danger");
                model.addAttribute("test",proizvodDb.sviProizvodi());
                model.addAttribute("errorMess",message);
                return "promeni.html";
            }

        }

    }
    @GetMapping("/narudzbina")
    public String view_rad(Model model){
        listaNardzbina = narudzbinaDb.allNarudzbinaHashMap();
        model.addAttribute("narudzbine",listaNardzbina.values());
        model.addAttribute("preuzeto",preuzetoNardzbina.values());

        return "rad_narudzbina.html";
    }
    @GetMapping("/dodajZaposlenog")
    public String view_dodajZaposlenog(){
        return "dodajZaposlenog.html";
    }
    @PostMapping("/dodajZaposlenog")
    public String dodajZaposlenog(@RequestParam String username,@RequestParam String password,@RequestParam String ime,@RequestParam String prezime,@RequestParam String adresa,@RequestParam String telefon, Model model){
        if (username.equals("") || password.equals("") || ime.equals("") || prezime.equals("") || adresa.equals("") || telefon.equals("")){
            String message = "<h1 id=\"emailHelp\" class=\"text-danger\">Sva polja moraju da budu popunjena.</h1>";
            model.addAttribute("errorStyle","border-danger");
            model.addAttribute("errorMess",message);
            return "dodajZaposlenog.html";
        }else {
                try {
                    Long.parseLong(telefon);
                }catch (Exception e){
                    String message = "<h1 id=\"emailHelp\" class=\"text-danger\">U polje telefon mora da bude broj.</h1>";
                    model.addAttribute("errorStyle","border-danger");
                    model.addAttribute("errorMess",message);
                    return "dodajZaposlenog.html";

                }
                if(zaposleniDb.dodajZaposlenog(new Zaposleni(username.trim(),password.trim(),ime,prezime,adresa,telefon)) < 0){
                    String message = "<h1 id=\"emailHelp\" class=\"form-text text-danger text-muted\">Korisnicko ime vec postoji.</h1>";
                    model.addAttribute("errorstyle","border-danger");
                    model.addAttribute("errorMess",message);
                    return "dodajZaposlenog.html";
                }else{
                    String message = "<h1 id=\"emailHelp\" class=\"text-success\">Zaposleni uspešno dodat.</h1>";
                    model.addAttribute("errorMess",message);
                    return "dodajZaposlenog.html";
                }
        }

    }
    @GetMapping("/obrisiProizvod")
    public String view_ObrisiProizvod(Model model){
        model.addAttribute("test",proizvodDb.sviProizvodi());
        model.addAttribute("vrati",proizvodDb.sviObrisaniProizvodi());

        return "/obrisiProizvod.html";
    }
    @PostMapping("/obrisiProizvod")
    public String ObrisiProizvod(@RequestParam int id){
        proizvodDb.ObrisiProizvod(id);
        return "redirect:/obrisiProizvod";
    }
    @PostMapping("/vratiProizvod")
    public String VratiProizvod(@RequestParam int id){
        proizvodDb.VratiProizvod(id);
        return "redirect:/obrisiProizvod";
    }
    @PostMapping("/login")
    public String login(@RequestParam String username,@RequestParam String password,Model model){
        try{
            zaposleni = zaposleniDb.getZaposleni(username);
            if (zaposleni.getPassword().equals(password.trim())){
                preuzetoNardzbina = narudzbinaDb.PreuzeteNarudzbineHashMap(zaposleni.getUsername());
                return "redirect:/narudzbina";
            }else {
                String message = "<small id=\"emailHelp\" class=\"form-text text-danger text-muted\">Netacna lozinka.</small>";
                model.addAttribute("notfound","border-danger");
                model.addAttribute("message",message);

                return "login.html";
            }



        }catch (EmptyResultDataAccessException e){
            String message = "<small id=\"emailHelp\" class=\"form-text text-danger text-muted\">Korisnicko ime ne postoji.</small>";
            model.addAttribute("notfound","border-danger");
            model.addAttribute("message",message);

            return "login.html";
        }
    }

    @PostMapping("/dodaj")
    public String dodaj(@RequestParam String naziv,@RequestParam String sastojci,@RequestParam String cena,Model model){
        if (naziv == "" || sastojci == "" || cena == ""){
            String message = "<h1 id=\"emailHelp\" class=\"text-danger\">Sva polja moraju da budu popunjena.</h1>";
            model.addAttribute("errorStyle","border-danger");
            model.addAttribute("errorMess",message);
            return "dodaj.html";
        }else {
            try{
                String message = "<h1 class=\"text-success\">Proizvod uspesno dodat.</h1>";
                Proizvod p = new Proizvod(naziv, sastojci, Integer.parseInt(cena));
                proizvodDb.dodajProizvod(p);
                model.addAttribute("errorMess",message);

                return "dodaj.html";
            }catch (Exception e){
                String message = "<h1 id=\"emailHelp\" class=\"text-danger\">U polje cena mora da bude broj.</h1>";
                model.addAttribute("errorStyle","border-danger");
                model.addAttribute("errorMess",message);
                return "dodaj.html";
            }

        }
    }
    @PostMapping(value = "/dodajKorpa",produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String dodajKorpa(@RequestParam String id,@RequestParam String kolicina){
        System.out.println(korpa);
        if(korpa.containsKey(id)){
            korpa.get(id).setKolicina(korpa.get(id).getKolicina()+Integer.parseInt(kolicina));
        }else{
            korpa.put(id,new ProizvodKolicina(proizvodDb.getProizvod(Integer.parseInt(id)),Integer.parseInt(kolicina),0));
        }

        Gson gson = new Gson();
        return  gson.toJson(korpa);
    }
    @PostMapping(value = "/obrisiKorpa",produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String obrisiKorpa(@RequestParam String id){
        korpa.remove(id);

        return gson.toJson(korpa);
    }
    @PostMapping("/naruci")
    @ResponseBody
    public String naruci(@RequestParam String ime,@RequestParam String prezime,@RequestParam String adresa){
        if(korpa.isEmpty()){
            return "-1";
        }else{
            narudzbinaDb.DodajNarudzbina(ime,prezime,adresa,0, korpa);
            return "1";
        }

    }
    @PostMapping( value = "/preuzmi",produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String preuzmi(@RequestParam String id){
        System.out.println(id);
        System.out.println(listaNardzbina);
        listaNardzbina.get(id).setPreuzeto(1);
        preuzetoNardzbina.put(id,listaNardzbina.get(id));
        System.out.println(listaNardzbina);
        listaNardzbina.remove(id);
        narudzbinaDb.PreuzmiNarudzbinu(Integer.parseInt(id),zaposleni.getUsername());
        return gson.toJson(preuzetoNardzbina.values());
    }
    @PostMapping( value = "/narudzbinaProizvod",produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String narudzbinaProizvod(@RequestParam String id){
        return gson.toJson(listaNardzbina.get(id).getList());
    }

    @PostMapping("/isporuci")
    @ResponseBody
    public String isporuci(@RequestParam String id){
       preuzetoNardzbina.remove(id);
       narudzbinaDb.Isporuceno(Integer.parseInt(id));
       return "test";
    }

    @GetMapping("/isporuceno")
    public String view_Isporuceno(Model model){
        model.addAttribute("isporuceno",isporucenoDb.allIsporuceno());
        return "isporuceno.html";
    }

    @PostMapping( value ="/isporuceno", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String Isporuceno(@RequestParam int id){
        Isporuceno isporuceno = isporucenoDb.getIsporuceno(id);
        System.out.println(isporuceno.getUsername().getDat_otkaza());
        System.out.println(isporuceno.getUsername().getDat_zap());

        return gson.toJson(isporuceno);
    }
    @PostMapping("/filtriraj")
    public String Filtriraj(@RequestParam String filter,Model model){
        model.addAttribute("test",proizvodDb.FiltrirajProizvodPoNazivu(filter));
        model.addAttribute("korpa",korpa.values());
        int ukupno = 0;
        for (ProizvodKolicina p:korpa.values()) {
            ukupno += (p.getProizvod().getCena() * p.getKolicina());
        }
        model.addAttribute("ukupno","Ukupna cena: "+ukupno);

        return "index.html";
    }
    @GetMapping("/obrisiZaposlenog")
    public String view_ObrisiZapsolenog(Model model){
        model.addAttribute("zaposleni",zaposleniDb.sviZaposleni());

        return "/obrisiZaposlenog.html";
    }

    @PostMapping( value ="/obrisiZaposlenog", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String ObirisiZaposlenog(@RequestParam String username){
        return ""+zaposleniDb.ObrisiZaposlenog(username);
    }

}
