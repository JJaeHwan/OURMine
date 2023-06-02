package kr.or.ddit.noticeBoard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.noticeBoard.vo.NoticeBoardFileVO;
import kr.or.ddit.noticeBoard.vo.NoticeBoardVO;

@Mapper
public interface NoticeBoardFileDAO {
	
	
	
	public List<NoticeBoardFileVO> noticeBoardFileList();
	
	public NoticeBoardFileVO noticeBoardSelect(int noticeBoardFileId);
	
	public int insertNoticeBoardFile(NoticeBoardFileVO  noticeBoardFile);
	
	public int updateNoticeBoardFile(NoticeBoardFileVO  noticeBoardFile);
	
	public int deleteNoticeBoardFile(int noticeBoardFileId);
}
