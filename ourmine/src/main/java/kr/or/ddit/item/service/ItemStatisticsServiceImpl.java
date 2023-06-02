package kr.or.ddit.item.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.item.dao.ItemStatisticsDAO;
import kr.or.ddit.item.vo.ItemStatisticsVO;
import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
@Transactional
public class ItemStatisticsServiceImpl implements ItemStatisticsService{
	
	private final ItemStatisticsDAO ItemStatisticsDAO;

	@Override
	@Transactional(readOnly = true)
	public List<ItemStatisticsVO> itemStatisticsList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	@Transactional(readOnly = true)
	public ItemStatisticsVO itemStatisticsSelect(int itemStatisticsId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int insertItemStatistics(ItemStatisticsVO itemStatistics) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int updateItemStatistics(ItemStatisticsVO itemStatistics) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int deleteItemStatistics(int itemStatisticsId) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
}
