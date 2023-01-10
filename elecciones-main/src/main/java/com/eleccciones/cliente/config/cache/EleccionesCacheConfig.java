package com.eleccciones.cliente.config.cache;

import com.eleccciones.cliente.config.cache.enumeration.CandidatosCacheNameEnum;
import com.eleccciones.cliente.config.cache.enumeration.UbicacionCacheNameEnum;
import com.eleccciones.cliente.config.cache.enumeration.UsuariosCacheNameEnum;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.redisson.spring.cache.CacheConfig;
import org.redisson.spring.cache.RedissonSpringCacheManager;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableCaching
public class EleccionesCacheConfig {

    @Bean
    public CacheManager getCahe(RedissonClient redissonClient) {
        final Map<String, CacheConfig> config = new HashMap<>();

        // Usuarios
        config.put(UsuariosCacheNameEnum.USUARIOS.name(), new CacheConfig());
        config.put(UsuariosCacheNameEnum.PERMISOS.name(), new CacheConfig());
        config.put(UsuariosCacheNameEnum.ROLES.name(), new CacheConfig());

        // Ubicacion
        config.put(UbicacionCacheNameEnum.PAIS.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.PAIS_LIST.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.PAIS_PAGE.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.PROVINCIA.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.PROVINCIA_LIST.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.PROVINCIA_PAGE.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.CANTON.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.CANTON_LIST.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.CANTON_PAGE.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.CIRCUNSCRIPCION.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.PARROQUIA.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.PARROQUIA_LIST.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.PARROQUIA_PAGE.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.ZONA.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.ZONA_LIST.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.ZONA_PAGE.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.RECINTO.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.RECINTO_LIST.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.RECINTO_PAGE.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.JUNTA.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.JUNTA_LIST.name(), new CacheConfig());
        config.put(UbicacionCacheNameEnum.JUNTA_PAGE.name(), new CacheConfig());
        // CANDIDATOS
        config.put(CandidatosCacheNameEnum.ACTA_DIGNIDAD.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.MOVIMIENTOS.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.CANDIDATOS.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.DIGNIDADES.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.TIPO_UBICACION.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.PROCESO.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.TIPO_GRUPO.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.ENTIDAD.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.TIPO_IDENTIFICACION.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.SEXO.name(), new CacheConfig());
        config.put(CandidatosCacheNameEnum.VOTO.name(), new CacheConfig());

        return new RedissonSpringCacheManager(redissonClient, config);
    }

    /**
     * Permite conectarse con redis para almacenar ahí la cache del aplicativo
     *
     * @return
     */
    @Bean(destroyMethod = "shutdown")
    public RedissonClient redisson() {
        final Config config = new Config();
        config.useSingleServer().setAddress("redis://127.0.0.1:6379");
        return Redisson.create(config);
    }
}
