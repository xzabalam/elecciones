package com.eleccciones.cliente.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.github.javafaker.Faker;

@Configuration
public class FakerBean {

	@Bean
	public Faker getFaker() {
		return new Faker();
	}
}
