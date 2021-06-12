package com.doom.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.doom")
public class ServletConfig implements WebMvcConfigurer {

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        WebMvcConfigurer.super.configureViewResolvers(registry);
        //view Resolver 설정 (prefix,suffix)
        //InternalResourceViewResolver 타입을 구현하여 사용해도 상관없다.
        registry.jsp("/WEB-INF/views/", ".jsp");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        WebMvcConfigurer.super.addResourceHandlers(registry);
        ///resources/모든것 들로 오는 요청을 프로젝트 /resources/된 경로로 매핑시켜 준다. (webapp 이하에 resources폴더)
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }

    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setDefaultEncoding("UTF-8"); //파일 인코딩
        multipartResolver.setMaxUploadSizePerFile(10 * 1024 * 1024); //파일당 업로드 크기 제한 (10MB)
        return multipartResolver;
    }

}
