package kr.or.ddit.noticeBoard.service;

import java.util.List;
import java.util.Optional;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.noticeBoard.dao.NoticeBoardDAO;
import kr.or.ddit.noticeBoard.dao.NoticeBoardFileDAO;
import kr.or.ddit.noticeBoard.vo.NoticeBoardFileVO;
import kr.or.ddit.noticeBoard.vo.NoticeBoardVO;
import kr.or.ddit.ui.NoticeBoardFileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class NoticeBoardServiceImpl implements NoticeBoardService{

	private final NoticeBoardDAO noticeBoardDAO;
	private final NoticeBoardFileDAO noticeBoardFileDAO;
	private final ServletContext servletContext;

	@Value("#{appInfo['images.attatchPath']}")
	private String uploadDir;

	// 공지게시글 목록
	@Override
	@Transactional(readOnly = true)
	public List<NoticeBoardVO> NoticeBoardList() {
		return noticeBoardDAO.noticeBoardList();
	}

	//F&Q게시글 목록
	@Override
	@Transactional(readOnly = true)
	public List<NoticeBoardVO> fnqNoticeBoardList() {
		return noticeBoardDAO.fnqNoticeBoardList();
	}

	@Override
	@Transactional(readOnly = true)
	public  List<NoticeBoardVO> NoticeBoardSelect(int noticeBoardId) {
		return noticeBoardDAO.noticeBoardSelect(noticeBoardId);
	}

	// 조회수 증가
	@Override
	public int updateNoticeBoardCount(int noticeBoardId) {
		return noticeBoardDAO.updateNoticeBoardCount(noticeBoardId);
	}

	// 게시글 등록
	@Override
	public int insertNoticeBoard(NoticeBoardVO noticeBoard, List<MultipartFile> files) {
	    // NoticeBoard를 먼저 저장함
	    int cnt = noticeBoardDAO.insertNoticeBoard(noticeBoard);
	    String realPath = servletContext.getRealPath("/src/main/webapp/resources/uploads");

	    log.info("realPath = {}",realPath);
	    // 원본 파일 저장
	    // 트랜잭션 처리를 위해 여기서 NoticeBoardFileDAO를 사용해서 저장
	    // Optional을 사용하여 null 체크를 해서 파일이 있을때만 저장을 함
	    Optional.ofNullable(files).ifPresent(fileList -> {
	        fileList.forEach(file -> {
	            // 각각의 파일에 대해 두 번의 저장을 실행
	            NoticeBoardFileVO vo = NoticeBoardFileUtil.saveFile(file, uploadDir, realPath, noticeBoard.getNoticeBoardWriteId());
	            if (vo != null) {  // 두 위치 모두에 성공적으로 저장됐다면
	                noticeBoardFileDAO.insertNoticeBoardFile(vo);  // DB에 저장
	            }
	        });
	    });
	    return cnt;
	}

	// 게시글 수정
	@Override
	public int updateNoticeBoard(NoticeBoardVO noticeBoard) {
		int cnt = noticeBoardDAO.updateNoticeBoard(noticeBoard);
		return cnt;
	}

	// 게시글 삭제
	@Override
	public int deleteNoticeBoard(int noticeBoardId) {
		return noticeBoardDAO.deleteNoticeBoard(noticeBoardId);
	}

}


