package kr.or.ddit.board.service;

import java.util.List;

import org.springframework.security.core.Authentication;

import kr.or.ddit.board.vo.BoardVO;
import org.springframework.web.multipart.MultipartFile;

public interface BoardService {


	public int boardHitUpdate(int boardId);
	/**
	 * 사내공지게시판용 리스트 뽑는용 service
	 * @return
	 */
	public List<BoardVO> boardCoNoticList(int companyId);
	/**
	 * 게시판 전체 조회 페이징을 해야하는데.. 자바에서 해야할지 자바스크립트로 할지... 고민되네
	 * @return
	 */
	public List<BoardVO> boardList(int boardTypeId);


	/**
	 * 게시판 한개의 정보를 반환 , 동적쿼리 추가해야함 String searchParam 같은거 추가해서 있으면 동적쿼리 실행하고 없으면 실행 안하는식으로 ㄱㄱ..
	 * @param boardId 게시판 기본키
	 * @return BoardVO
	 */
	public BoardVO boardSelect(int boardId);

	/**
	 * 게시판 한개의 정보를 저장
	 * @param  board 게시판 한개의 정보를 받음
	 * @return
	 */

	public int boardSelectCount( );

	/**
	 * 사내게시판 insert
	 * @param board
	 * @return
	 */
	public int insertCoNoticeBoard(BoardVO board);
	/**
	 * 삽입된 게시판 갯수를 반환
	 * @param  board 게시판 한개의 정보를 받음
	 * @return 게시판 정보가 수정되면 0보다 높은 값을 반환
	 */

	public int insertBoard(BoardVO board,List<MultipartFile> files);

	/**
	 * 수정된 게시판 갯수를 반환
	 * @param  board 게시판 한개의 정보를 받음
	 * @return 게시판 정보가 수정되면 0보다 높은 값을 반환
	 */
	public int updateBoard(BoardVO  board);

	/**
	 * 게시판의 삭제유무 수정
	 * @param boardId 를 받아서 사용유무를 update를 함 삭제하는거 아님!!! DELETE 쿼리쓰면안됨!!!
	 * @return 사용유무가 수정되면 0보다 높은 값을 반환
	 */
	public int deleteBoard(int boardId);
	/**
	 * 프로젝트 롤 값 가져오기
	 * @param board
	 * @return
	 */
	public int selectProjectRole(BoardVO board);

	public List<BoardVO> boardFileSelect(int boardId);
	
	public int boardMemCompanySelect(int memberId);
}
