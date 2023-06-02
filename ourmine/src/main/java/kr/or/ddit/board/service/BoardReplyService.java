package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.vo.BoardReplyVO;

public interface BoardReplyService {
	
	/**
	 * 
	 * @return
	 */
	public List<BoardReplyVO> boardReplyList(int boardId);
	/**
	 * 
	 * @param boardReply
	 * @return
	 */
	public int insertBoardReply(BoardReplyVO  boardReply);
	/**
	 * 
	 * @param boardReply
	 * @return
	 */
	public int updateBoardReply(BoardReplyVO  boardReply);
	
	/**
	 * 
	 * @param boardReplyId
	 * @return
	 */
	public int deleteBoardReply(int boardReplyId);
	
}
