package com.example.bt_05.config;

import java.util.EnumSet;

import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import jakarta.servlet.DispatcherType;

@Configuration
public class SiteMeshConfig {

	@Bean
	FilterRegistrationBean<ConfigurableSiteMeshFilter> siteMeshFilter() {
		FilterRegistrationBean<ConfigurableSiteMeshFilter> registration = new FilterRegistrationBean<>();
		registration.setFilter(new ConfigurableSiteMeshFilter());
		registration.setName("siteMeshFilter");
		registration.addUrlPatterns("/admin/*");
		registration.setDispatcherTypes(EnumSet.of(DispatcherType.REQUEST, DispatcherType.ERROR));
		registration.addInitParameter("configFile", "/WEB-INF/decorators/decorators.xml");
		registration.setOrder(Ordered.LOWEST_PRECEDENCE);
		return registration;
	}

	@Bean
	InternalResourceViewResolver jspViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jsp");
		resolver.setAlwaysInclude(true);
		return resolver;
	}
}
