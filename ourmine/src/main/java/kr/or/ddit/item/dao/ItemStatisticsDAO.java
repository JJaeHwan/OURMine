package kr.or.ddit.item.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.item.vo.ItemStatisticsVO;

@Mapper
public interface ItemStatisticsDAO {
	
	

	public List<ItemStatisticsVO> itemStatisticsList();
	
	public ItemStatisticsVO itemStatisticsSerlect(int itemStatisticsId);
	
	public int insertrItemStatistics(ItemStatisticsVO  itemStatistics);
	
	public int updateItemStatistics(ItemStatisticsVO  itemStatistics);
	
	public int deleteItemStatistics(int itemStatisticsId);
	
}
