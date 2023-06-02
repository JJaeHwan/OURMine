package kr.or.ddit.projectwork.service;

import java.util.List;

import org.springframework.security.core.Authentication;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import kr.or.ddit.vo.Page;

public interface ProjectWorkService {
	
	/**
	 * 
	 * @param projectWorkVO TODO
	 * @return
	 */
	public List<Page> projectWorkList(Page pagination);
	public int totalData(int projectWorkId);
	
	/**
	 * 
	 * @param projectWorkId
	 * @return
	 */
	public ProjectWorkVO projectWorkSelect(int projectId);
	
	public List<ProjectWorkVO> pwList(ProjectWorkVO projectWorkVO);
	
	/**
	 * 
	 * @param projectWork
	 * @return
	 */
	public int insertProjectWork(ProjectWorkVO projectWork);
	
	/**
	 * 
	 * @param projectWork
	 * @return
	 */
	public int updateProjectWork(ProjectWorkVO projectWork);
	
	/**
	 * 
	 * @param projectWorkId
	 * @return
	 */
	public int deleteProjectWork(int projectWorkId);
	
	/////// 추가 ///////////

	
	public int selectProjectRole(ProjectWorkVO projectWork);
	
	public List<ProjectAttendVO> projectMemberList(int projectId);
	
	// 나의 일감 리스트 조회
	public List<Page> projectTodoWorkList(Page pagination);
	// 나의 일감 페이징을 위한 전체 데이터수 
	public int totalWorkData(Page pagination);
	// todo에서 일감 상태 변경
	public int updateStatus(int projectWorkId);
}
