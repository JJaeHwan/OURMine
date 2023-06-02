package kr.or.ddit.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardVO;

@Mapper
public interface BoardDAO {

	public int insertCoNoticeBoard(BoardVO board);

	public List<BoardVO> boardCoNoticList(int companyId);

	public List<BoardVO> boardList(int boardTypeId);

	public BoardVO boardSelect(int boardId);

	public List<BoardVO> boardFileSelect(int boardId);

	public int boardSelectCount();

	public int insertBoard(BoardVO  board);

	public int updateBoard(BoardVO  board);

	public int deleteBoard(int boardId);

	public int boardHitUpdate(int boardId);

	public int selectProjectRole(BoardVO board);
	
	public int boardMemCompanySelect(int memberId);
	
}
