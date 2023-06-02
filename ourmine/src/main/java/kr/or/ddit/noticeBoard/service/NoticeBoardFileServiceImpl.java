package kr.or.ddit.noticeBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.noticeBoard.dao.NoticeBoardDAO;
import kr.or.ddit.noticeBoard.dao.NoticeBoardFileDAO;
import kr.or.ddit.noticeBoard.vo.NoticeBoardFileVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class NoticeBoardFileServiceImpl implements NoticeBoardFileService{

	private final NoticeBoardFileDAO noticeBoardFileDAO;
	
	@Override
	public List<NoticeBoardFileVO> noticeBoardFileList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NoticeBoardFileVO noticeBoardSelect(int noticeBoardFileId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertNoticeBoardFile(NoticeBoardFileVO noticeBoardFile) {
		return noticeBoardFileDAO.insertNoticeBoardFile(noticeBoardFile);
	}

	@Override
	public int updateNoticeBoardFile(NoticeBoardFileVO noticeBoardFile) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteNoticeBoardFile(int noticeBoardFileId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
