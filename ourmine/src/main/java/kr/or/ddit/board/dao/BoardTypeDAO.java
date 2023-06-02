package kr.or.ddit.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardTypeVO;

@Mapper
public interface BoardTypeDAO {


	public List<BoardTypeVO> boardTypeList(int projectId);
	
	public BoardTypeVO boardTypeSelect(int boardTypeId);
	
	public int insertBoardType(BoardTypeVO  boardType);
	
	public int updateBoardType(BoardTypeVO  boardType);
	
	public int deleteBoardType(int boardTypeId);
}
