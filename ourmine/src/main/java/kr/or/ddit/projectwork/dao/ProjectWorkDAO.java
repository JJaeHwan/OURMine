package kr.or.ddit.projectwork.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import kr.or.ddit.vo.Page;

@Mapper
public interface ProjectWorkDAO {
	
	public List<Page> projectWorkList(Page pagination);
	
	// 페이징을 위한 전체 데이터수 
	public int totalData(int projectId);
	
	public List<ProjectWorkVO> pwList(ProjectWorkVO projectWorkVO);
	
	public ProjectWorkVO projectWorkSelect(int projectWorkId);
	
	public int insertProjectWork(ProjectWorkVO projectWork);
	
	public int updateProjectWork(ProjectWorkVO projectWork);
	
	public int deleteProjectWork(int projectWorkId);
	
	///////////// 추가 //////////////
	
	public int selectProjectRole(ProjectWorkVO projectWork);
	
	public List<ProjectAttendVO> projectMemberList(int projectId);
	
	// 나의 일감 리스트 조회
	public List<Page> projectTodoWorkList(Page pagination);
	// 나의 일감 페이징을 위한 전체 데이터수 
	public int totalWorkData(Page pagination);
	// todo에서 일감 상태 변경
	public int updateStatus(int projectWorkId);
	
}
