package kr.or.ddit.advice;

import java.io.FileNotFoundException;
import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

@Configuration
public class AppConfig implements WebMvcConfigurer {

    @Bean
    public HandlerExceptionResolver handlerExceptionResolver() {
        SimpleMappingExceptionResolver resolver = new SimpleMappingExceptionResolver();
        Properties mappings = new Properties();

        // 500 error
        mappings.setProperty(Exception.class.getName(), "error-500");

        // 404 error
        mappings.setProperty(NoHandlerFoundException.class.getName(), "error-404");

        // jsp를 찾을수 없을때도 404
        mappings.setProperty(FileNotFoundException.class.getName(), "error-404");
        resolver.setExceptionMappings(mappings);
        return resolver;
    }
}
