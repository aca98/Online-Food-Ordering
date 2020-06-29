package rs.viser.onlinenarucivanje.config;

import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

public class WebConfig implements WebMvcConfigurer {

    private static final String PREFIX = "/WEB-INF/view/";
    private static final String SUFFIX = ".jsp";

    @Bean
    public ViewResolver viewResolver()
    {
        UrlBasedViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix(PREFIX);
        viewResolver.setSuffix(SUFFIX);
        return viewResolver;
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("pocetna");
    }
}
