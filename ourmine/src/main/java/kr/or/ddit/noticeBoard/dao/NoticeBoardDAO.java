package kr.or.ddit.noticeBoard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.noticeBoard.vo.NoticeBoardVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface NoticeBoardDAO {
	
	public List<NoticeBoardVO> noticeBoardList();
	
	// FNQ게시글 목록
	public List<NoticeBoardVO> fnqNoticeBoardList();

	public  List<NoticeBoardVO> noticeBoardSelect(int noticeBoardId);
	
	public int selectTotalRecord();
	
	public int insertNoticeBoard(NoticeBoardVO noticeBoard);
	
	public int updateNoticeBoard(NoticeBoardVO noticeBoard);
	
	public int deleteNoticeBoard(int noticeBoardId);
	
	// 조회수 증가
	public int updateNoticeBoardCount(int noticeBoardId);
}
