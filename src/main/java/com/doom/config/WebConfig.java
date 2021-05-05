package com.doom.config;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.Filter;
import javax.servlet.ServletRegistration;

//web.xml을 대신 할 설정 클래스
//WebApplicationInitializer를 구현할수도 있지만, 더 간단한 방법으로 설정한다.
//AbstractAnnotationConfigDispatcherServletInitializer은 WebApplicationInitializer 구현체중에 하나.
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {

    //프로젝트에서 사용할 Bean과 DB설정을 위한 클래스.
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[] {RootConfig.class};
    }

    //Spring MVC 프로젝트 설정을 위한 클래스.
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] {ServletConfig.class};
    }

    //DispacherServlet에 매핑할 요청주소를 반환한다.("/"로 된 모든 요청주소 반환)
    @Override
    protected String[] getServletMappings() {
        return new String[] {"/"};
    }

    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
        encodingFilter.setEncoding("UTF-8");
        encodingFilter.setForceEncoding(true);
        return new Filter[]{encodingFilter};
    }

    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {
        registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");
    }
}
