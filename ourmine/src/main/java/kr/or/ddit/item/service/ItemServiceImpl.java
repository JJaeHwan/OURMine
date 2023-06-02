package kr.or.ddit.item.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.item.dao.ItemDAO;
import kr.or.ddit.item.vo.ItemVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ItemServiceImpl implements ItemService{
	
	private final ItemDAO itemDAO;
	
	@Override
	@Transactional(readOnly = true)
	public List<ItemVO> itemList() {
		return itemDAO.itemList();
	}

	@Override
	@Transactional(readOnly = true)
	public ItemVO itemSelect(int itemId) {
		return itemDAO.itemSelect(itemId);
	}
	
	@Override
	public int insertItem(ItemVO item) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateItem(ItemVO item) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteItem(int itemId) {
		// TODO Auto-generated method stub
		return 0;
	}

	

}
