package kr.or.ddit.board.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.board.dao.BoardReplyDAO;
import kr.or.ddit.board.vo.BoardReplyVO;
import kr.or.ddit.board.vo.BoardVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardReplyServiceImpl implements BoardReplyService{
	
	private final BoardReplyDAO boardReplyDAO;

	@Override
	public List<BoardReplyVO> boardReplyList(int boardId) {
		
		return boardReplyDAO.boardReplyList(boardId);
	}

	@Override
	public int insertBoardReply(BoardReplyVO boardReply) {

		return boardReplyDAO.insertBoardReply(boardReply);
	}

	@Override
	public int updateBoardReply(BoardReplyVO boardReply) {

		return boardReplyDAO.updateBoardReply(boardReply);
	}

	@Override
	public int deleteBoardReply(int boardReplyId) {

		return boardReplyDAO.deleteBoardReply(boardReplyId);
	} 
	


}
