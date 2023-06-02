package kr.or.ddit.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;

import kr.or.ddit.board.dao.BoardFileDAO;
import kr.or.ddit.ui.BoardFileUtil;
import kr.or.ddit.ui.NoticeBoardFileUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.board.dao.BoardDAO;
import kr.or.ddit.board.vo.BoardFileVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.noticeBoard.vo.NoticeBoardFileVO;
import kr.or.ddit.noticeBoard.vo.NoticeBoardVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.multipart.MultipartFile;

@Service
@Slf4j
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

	private final BoardDAO boardDAO;
	private final BoardFileDAO boardFileDAO;
	private final ServletContext servletContext;


	@Value("#{appInfo['images.attatchPath']}")
	private String uploadDir;


	@Override
	public List<BoardVO> boardList(int boardTypeId) {

		return boardDAO.boardList(boardTypeId);
	}

	@Override
	public BoardVO boardSelect(int boardId) {

		return boardDAO.boardSelect(boardId);
	}

	@Override
	public int boardSelectCount( ) {
		return boardDAO.boardSelectCount();
	}




	@Override
	public int insertBoard(BoardVO board,List<MultipartFile> files) {

		int cnt = boardDAO.insertBoard(board);

		log.info("jein: " + board);

	    String realPath = servletContext.getRealPath("/src/main/webapp/resources/uploads");

	    log.info("realPath = {}",realPath);
	    // 원본 파일 저장
	    // 트랜잭션 처리를 위해 여기서 NoticeBoardFileDAO를 사용해서 저장
	    // Optional을 사용하여 null 체크를 해서 파일이 있을때만 저장을 함
	    Optional.ofNullable(files).ifPresent(fileList -> {
	        fileList.forEach(file -> {
	            // 각각의 파일에 대해 두 번의 저장을 실행
	            BoardFileVO vo = BoardFileUtil.saveFile(file, uploadDir, realPath, board.getBoardId());
	            if (vo != null) {  // 두 위치 모두에 성공적으로 저장됐다면
	            	boardFileDAO.insertBoardFile(vo);  // DB에 저장
	            }
	        });
	    });
	    return cnt;
	}

	@Override
	public int updateBoard(BoardVO board) {
		return boardDAO.updateBoard(board);
	}

	@Override
	public int deleteBoard(int boardId) {

		return boardDAO.deleteBoard(boardId);
	}

	@Override
	public List<BoardVO> boardCoNoticList(int companyId) {

		return boardDAO.boardCoNoticList(companyId);
	}

	@Override
	public int insertCoNoticeBoard(BoardVO board) {
		// TODO Auto-generated method stub
		return boardDAO.insertCoNoticeBoard(board);
	}

	@Override
	public int boardHitUpdate(int boardId) {
		int cnt = boardDAO.boardHitUpdate(boardId);
		return cnt;
	}

	@Override
	public int selectProjectRole(BoardVO board) {

		int projectRoleNum = boardDAO.selectProjectRole(board);
		log.info("projectRoleNum:{}",projectRoleNum);
		return projectRoleNum;
	}



	@Override
	public List<BoardVO> boardFileSelect(int boardId) {
		return boardDAO.boardFileSelect(boardId);
	}

	@Override
	public int boardMemCompanySelect(int memberId) {
		int companyId = boardDAO.boardMemCompanySelect(memberId);
		return companyId;
	}



}
