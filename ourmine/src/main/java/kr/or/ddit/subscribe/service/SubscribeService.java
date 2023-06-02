package kr.or.ddit.subscribe.service;

import java.util.List;

import kr.or.ddit.subscribe.vo.SubscribeVO;

public interface SubscribeService {
	
	
	
	public List<SubscribeVO> subscribeList();
	
	public SubscribeVO subscribeSelect(int subscribeId);
	
	public SubscribeVO subscribeSelectByMemberId(int memberId);
	
	public int insertSubscribe(SubscribeVO  subscribe);
	
	public void updateSubscribeUse();

	public int updateSubscribeUseById(int memberId);
	
	public int updateSubscribe(SubscribeVO  subscribe);
	
	public int deleteSubscribe(int subscribeId);
	
}
