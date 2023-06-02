package kr.or.ddit.subscribe.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import kr.or.ddit.subscribe.service.SubscribeService;


public class UpdateSubscribeMemberScheduler {

	@Autowired
	private SubscribeService subService;
	
	@Scheduled(cron = "0 0 12 1/1 * ? *")
	public void updateSubscribeUse() {
		subService.updateSubscribeUse();
	}
	
}
