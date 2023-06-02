package kr.or.ddit.item.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.item.vo.ItemVO;

@Mapper
public interface ItemDAO {
	
	
	/**
	 * 상품 전체 조회
	 */
	public List<ItemVO> itemList();
	
	/**
	 * 상품 한개의 정보를 반환
	 * @param itemId 상품 기본키
	 * @return 상품 한개의 정보를 반환
	 */
	public ItemVO itemSelect(int itemId);
	
	/**
	 * 상품 한개의 정보를 저장
	 * @param item 
	 * @return
	 */
	public int itemInsert(ItemVO item);
	
	/**
	 * 수정된 상품 갯수를 반환
	 * @param item 상품 한개의 정보를 받음
	 * @return 상품정보가 수정되면 0보다 높은 값을 반환 
	 */
	public int updateItem(ItemVO item);
	
	/**
	 * 상품의 사용유무 수정
	 * @param itemId 를 받아서 사용유무를 update를 함 삭제하는거 아님!!!
	 * @return 사용유무가 수정되면 0보다 높은 값을 반환
	 */
	public int deleteItem(int itemId);
	
	

}
