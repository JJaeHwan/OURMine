package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.vo.BoardTypeVO;

public interface BoardTypeService {
	
	
	public List<BoardTypeVO> BoardTypeList(int projectId);

	/**
	 * 게시판 한개의 정보를 저장 
	 * @param  board 게시판 한개의 정보를 받음
	 * @return 
	 */
	public int insertBoardType(BoardTypeVO  boardType);
	
	/**
	 * 게시판의 삭제유무 수정
	 * @param boardId 를 받아서 사용유무를 update를 함 삭제하는거 아님!!! DELETE 쿼리쓰면안됨!!!
	 * @return 사용유무가 수정되면 0보다 높은 값을 반환
	 */
	public int deleteBoardType(int boardTypeId);
	


}
