
package kr.or.ddit.alarm.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.HtmlUtils;

import kr.or.ddit.alarm.vo.Greeting;
import kr.or.ddit.alarm.vo.HelloMessage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GreetingController {


	@MessageMapping("/hello")
	@SendTo("/topic/greetings")
	public Greeting greeting(HelloMessage message) throws Exception {

		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!");
		log.info("message : {} ",message);
		log.info("message : {} ",message);
		log.info("message : {} ",message);
		log.info("message : {} ",message);

		Thread.sleep(1000); // simulated delay
		return new Greeting("Hello, " + HtmlUtils.htmlEscape(message.getName()) + "!");
	}


}
