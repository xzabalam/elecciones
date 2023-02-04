package com.eleccciones.cliente.config;

import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SpringDocConfig {
    private static final String GRUPO = "controladores";
    private static final String[] PATHS = {
            "/acta-dignidad/**",
            "/dignidad/**",
            "/movimiento/**",
            "/voto/**",
            "/estadisticas/**",
            "/numero-electores/**",
            "/usuarios/**",
            "/canton/**",
            "/circunscripcion/**",
            "/junta/**",
            "/pais/**",
            "/parroquia/**",
            "/provincia/**",
            "/recinto/**",
            "/zona/**"
    };

    @Bean
    public GroupedOpenApi getDocket() {
        return GroupedOpenApi
                .builder()
                .packagesToScan("com.eleccciones.cliente.web.controllers")
                .group(GRUPO)
                .pathsToMatch(PATHS)
                .build();
    }
}
