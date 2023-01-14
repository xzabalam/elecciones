package com.eleccciones.cliente.config.cache;

import com.eleccciones.cliente.config.cache.enumeration.CandidatosCacheNameEnum;
import com.eleccciones.cliente.config.cache.enumeration.UbicacionCacheNameEnum;
import com.eleccciones.cliente.config.cache.enumeration.UsuariosCacheNameEnum;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.concurrent.ConcurrentMapCache;
import org.springframework.cache.support.SimpleCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;

@Configuration
@EnableCaching
public class EleccionesCacheConfig {

    @Bean
    public CacheManager cacheManager() {
        SimpleCacheManager cacheManager = new SimpleCacheManager();
        cacheManager.setCaches(Arrays.asList(
                new ConcurrentMapCache("directory"),
                new ConcurrentMapCache("addresses"),
                // Usuarios
                new ConcurrentMapCache(UsuariosCacheNameEnum.USUARIOS.name()),
                new ConcurrentMapCache(UsuariosCacheNameEnum.PERMISOS.name()),
                new ConcurrentMapCache(UsuariosCacheNameEnum.ROLES.name()),
                // Ubicacion
                new ConcurrentMapCache(UbicacionCacheNameEnum.PAIS.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.PAIS_LIST.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.PAIS_PAGE.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.PROVINCIA.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.PROVINCIA_LIST.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.PROVINCIA_PAGE.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.CANTON.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.CANTON_LIST.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.CANTON_PAGE.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.CIRCUNSCRIPCION.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.PARROQUIA.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.PARROQUIA_LIST.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.PARROQUIA_PAGE.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.ZONA.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.ZONA_LIST.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.ZONA_PAGE.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.RECINTO.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.RECINTO_LIST.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.RECINTO_PAGE.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.JUNTA.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.JUNTA_LIST.name()),
                new ConcurrentMapCache(UbicacionCacheNameEnum.JUNTA_PAGE.name()),
                // CANDIDATOS
                new ConcurrentMapCache(CandidatosCacheNameEnum.ACTA_DIGNIDAD.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.MOVIMIENTOS.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.CANDIDATOS.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.DIGNIDADES.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.TIPO_UBICACION.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.PROCESO.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.TIPO_GRUPO.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.ENTIDAD.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.TIPO_IDENTIFICACION.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.SEXO.name()),
                new ConcurrentMapCache(CandidatosCacheNameEnum.VOTO.name())));

        return cacheManager;
    }
}
