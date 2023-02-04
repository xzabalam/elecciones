package com.eleccciones.cliente.config.cache;

import com.eleccciones.cliente.config.cache.enumeration.UsuariosCacheNameEnum;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.redisson.spring.cache.CacheConfig;
import org.redisson.spring.cache.RedissonSpringCacheManager;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.concurrent.ConcurrentMapCache;
import org.springframework.cache.support.SimpleCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableCaching
public class EleccionesCacheConfig {

    @Bean
    @ConditionalOnProperty(prefix = "cache-service", name = "cache-type", havingValue = "redis")
    public CacheManager getCahe(RedissonClient redissonClient) {
        final Map<String, CacheConfig> config = new HashMap<>();
        return new RedissonSpringCacheManager(redissonClient, config);
    }

    /**
     * Permite conectarse con redis para almacenar ahí la cache del aplicativo
     *
     * @return
     */
    @Bean(destroyMethod = "shutdown")
    @ConditionalOnProperty(prefix = "cache-service", name = "cache-type", havingValue = "redis")
    public RedissonClient redisson() {
        final Config config = new Config();
        config.useSingleServer().setAddress("redis://127.0.0.1:6379");
        return Redisson.create(config);
    }

    @Bean
    @ConditionalOnProperty(prefix = "cache-service", name = "cache-type", havingValue = "basic")
    public CacheManager cacheManager() {
        SimpleCacheManager cacheManager = new SimpleCacheManager();
        cacheManager.setCaches(Arrays.asList(
                // Usuarios
                new ConcurrentMapCache(UsuariosCacheNameEnum.USUARIOS.name()),
                new ConcurrentMapCache(UsuariosCacheNameEnum.PERMISOS.name()),
                new ConcurrentMapCache(UsuariosCacheNameEnum.ROLES.name())
        ));

        return cacheManager;
    }
}
