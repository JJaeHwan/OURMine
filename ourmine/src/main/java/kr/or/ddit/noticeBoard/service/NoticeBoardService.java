package kr.or.ddit.noticeBoard.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.noticeBoard.vo.NoticeBoardVO;
import kr.or.ddit.vo.Pagination;

public interface NoticeBoardService {

	public List<NoticeBoardVO> NoticeBoardList();

	// FNQ게시글 목록
	public List<NoticeBoardVO> fnqNoticeBoardList();

	public List<NoticeBoardVO> NoticeBoardSelect(int noticeBoardId);

	public int insertNoticeBoard(NoticeBoardVO  noticeBoard,List<MultipartFile> files);

	public int updateNoticeBoard(NoticeBoardVO  noticeBoard);

	public int deleteNoticeBoard(int noticeBoardId);

	// 조회수 증가
	public int updateNoticeBoardCount(int noticeBoardCount);
}
