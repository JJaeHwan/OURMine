package kr.or.ddit.subscribe.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.subscribe.dao.SubscribeDAO;
import kr.or.ddit.subscribe.vo.SubscribeVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class SubscribeServiceImpl implements SubscribeService{
	
	private final SubscribeDAO subscribeDAO;
	
	@Override
	@Transactional(readOnly = true)
	public List<SubscribeVO> subscribeList() {
		return subscribeDAO.subscribeList();
	}
	
	@Override
	@Transactional(readOnly = true)
	public SubscribeVO subscribeSelect(int subscribeId) {
		return subscribeDAO.subscribeSelect(subscribeId);
	}
	
	@Override
	public SubscribeVO subscribeSelectByMemberId(int memberId) {
		return subscribeDAO.subscribeSelectByMemberId(memberId);
	}

	@Override
	public int insertSubscribe(SubscribeVO subscribe) {
		int rowcnt = subscribeDAO.insertSubscribe(subscribe);
		return rowcnt;
	}
	
	@Override
	public void updateSubscribeUse() {
		subscribeDAO.updateSubscribeUse();
		
	}
	
	@Override
	public int updateSubscribeUseById(int memberId) {
		return subscribeDAO.updateSubscribeUseById(memberId);
	}

	@Override
	public int updateSubscribe(SubscribeVO subscribe) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteSubscribe(int subscribeId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
