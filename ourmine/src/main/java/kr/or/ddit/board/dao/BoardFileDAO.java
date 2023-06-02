package kr.or.ddit.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardFileVO;
import kr.or.ddit.board.vo.BoardReplyVO;

@Mapper
public interface BoardFileDAO {
	
	

	public List<BoardFileVO> boardFileList();
	
	public BoardFileVO boardFileSelect(int boardFileId);
	
	public int insertBoardFile(BoardFileVO  boardFile);
	
	public int updateBoardFile(BoardFileVO  boardFile);
	
	public int deleteBoardFile(int boardFileId);
}
