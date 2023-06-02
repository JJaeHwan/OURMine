package kr.or.ddit.websocket;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationService {
    private final SimpMessagingTemplate template;

    public void notify(String message) {

    	log.info("message : {} ", message);
    	log.info("message : {} ", message);
    	log.info("message : {} ", message);
    	log.info("message : {} ", message);

        this.template.convertAndSend("/topic/notification", message);

    }
}
