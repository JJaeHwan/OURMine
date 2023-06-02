package kr.or.ddit.subscribe.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.subscribe.vo.SubscribeVO;

@Mapper
public interface SubscribeDAO {
	
	
	public List<SubscribeVO> subscribeList();
	
	public SubscribeVO subscribeSelect(int subscribeId);
	
	public SubscribeVO subscribeSelectByMemberId(int memberId);
	
	public int insertSubscribe(SubscribeVO  subscribe);
	
	public void updateSubscribeUse();
	
	public int updateSubscribeUseById(int memberId);
	
	public int updateSubscribe(SubscribeVO  subscribe);
	
	
	
	public int deleteSubscribe(int subscribeId);
	
}
