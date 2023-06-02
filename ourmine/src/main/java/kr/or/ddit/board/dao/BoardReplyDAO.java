package kr.or.ddit.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardReplyVO;

@Mapper
public interface BoardReplyDAO {

	
	public List<BoardReplyVO> boardReplyList(int boardId);
	
	public BoardReplyVO boardReplySelect(int boardReplyId);
	
	public int insertBoardReply(BoardReplyVO  boardReply);
	
	public int updateBoardReply(BoardReplyVO  boardReply);
	
	public int deleteBoardReply(int boardReplyId);
	
}
