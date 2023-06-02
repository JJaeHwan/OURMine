package kr.or.ddit.codeEditor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@PropertySource("classpath:kr/or/ddit/appInfo.properties")
public class ApiKeyProvider {
    @Value("${apiKey}")
    private String apiKey;

    public String getApiKey() {
    	log.info("apiKey={}", apiKey);
        return apiKey;
    }
}