package kr.or.ddit.noticeBoard.service;

import java.util.List;

import kr.or.ddit.noticeBoard.vo.NoticeBoardFileVO;

public interface NoticeBoardFileService {
	
	
	
	
	public List<NoticeBoardFileVO> noticeBoardFileList();
	
	public NoticeBoardFileVO noticeBoardSelect(int noticeBoardFileId);
	
	public int insertNoticeBoardFile(NoticeBoardFileVO  noticeBoardFile);
	
	public int updateNoticeBoardFile(NoticeBoardFileVO  noticeBoardFile);
	
	public int deleteNoticeBoardFile(int noticeBoardFileId);
}
