package com.eleccciones.cliente.config.cache;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "spring-redis-redisson-config")
public class RedissonConfigData {
    private Integer idleConnectionTimeout;
    private Integer connectTimeout;
    private Integer timeout;
    private Integer retryAttempts;
    private Integer retryInterval;
    private Integer subscriptionsPerConnection;
    private Integer subscriptionConnectionMinimumIdleSize;
    private Integer subscriptionConnectionPoolSize;
    private Integer connectionMinimumIdleSize;
    private Integer connectionPoolSize;
    private Integer dnsMonitoringInterval;
    private String redisHostName;
    private Integer redisPort;
}
