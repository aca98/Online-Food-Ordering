package rs.viser.onlinenarucivanje;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.thymeleaf.spring5.templateresolver.SpringResourceTemplateResolver;

import javax.annotation.PostConstruct;

@Component
public class DecoupledLogicSetup {

    private final SpringResourceTemplateResolver springResourceTemplateResolver;

    @Autowired
    public DecoupledLogicSetup(SpringResourceTemplateResolver springResourceTemplateResolver) {
        this.springResourceTemplateResolver = springResourceTemplateResolver;
    }

    @PostConstruct
    public void init(){
        springResourceTemplateResolver.setUseDecoupledLogic(true);

    }

}
