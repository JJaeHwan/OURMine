package kr.or.ddit.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.board.dao.BoardTypeDAO;
import kr.or.ddit.board.vo.BoardTypeVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardTypeServiceImpl implements BoardTypeService {
	
	private final BoardTypeDAO boardTypeDAO;

	@Override
	public List<BoardTypeVO> BoardTypeList(int projectId) {
		List<BoardTypeVO> list = boardTypeDAO.boardTypeList(projectId);
		return list;
	}

	@Override
	public int insertBoardType(BoardTypeVO boardType) {
		int cnt = boardTypeDAO.insertBoardType(boardType);
		return cnt;
	}

	@Override
	public int deleteBoardType(int boardTypeId) {
		int cnt = boardTypeDAO.deleteBoardType(boardTypeId);
		return cnt;
	}

}
