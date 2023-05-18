package edu.inai.coursework3.config;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.util.HashMap;
import java.util.Map;


@Configuration
public class FreeMarkerConfig implements BeanPostProcessor {

    @Value("${avatar.path}")
    private String avatarPath;

    @Value("${courses.path}")
    private String coursesPath;

    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName)
            throws BeansException {
        if (bean instanceof FreeMarkerConfigurer) {
            FreeMarkerConfigurer configurer = (FreeMarkerConfigurer) bean;
            Map<String, Object> sharedVariables = new HashMap<>();
            sharedVariables.put("avatarPath", avatarPath);
            sharedVariables.put("coursesPath", coursesPath);
            configurer.setFreemarkerVariables(sharedVariables);
        }
        return bean;
    }
}
