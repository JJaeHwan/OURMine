package kr.or.ddit.item.service;

import java.util.List;

import kr.or.ddit.item.vo.ItemStatisticsVO;

public interface ItemStatisticsService {
	
	/**
	 * 
	 * @return
	 */
	public List<ItemStatisticsVO> itemStatisticsList();
	/**
	 * 
	 * @param itemStatisticsId
	 * @return
	 */
	public ItemStatisticsVO itemStatisticsSelect(int itemStatisticsId);
	/**
	 * 
	 * @param itemStatistics
	 * @return
	 */
	public int insertItemStatistics(ItemStatisticsVO  itemStatistics);
	/**
	 * 
	 * @param itemStatistics
	 * @return
	 */
	public int updateItemStatistics(ItemStatisticsVO  itemStatistics);
	
	/**
	 * 
	 * @param itemStatisticsId
	 * @return
	 */
	public int deleteItemStatistics(int itemStatisticsId);
}
