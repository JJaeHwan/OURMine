package kr.or.ddit.projectAttend.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;

@Mapper
public interface ProjectAttendDAO {

	public List<ProjectAttendVO> ProjectAttendList();


	public ProjectAttendVO ProjectAttendSelect(int projectAttendId);

	public int countProjectAttend(ProjectAttendVO projectAttend);

	public int insertProjectAttend(ProjectAttendVO  projectAttend);

	public int insertProjectAttendPL(List<ProjectAttendVO> projectAttend);
	

	public int updateProjectAttendStatus(ProjectAttendVO  projectAttend);

	public int updateProjectAttend(ProjectAttendVO  projectAttend);

	public int deleteProjectAttend(int projectAttendAk);
	
	// 해당 프로젝트의 pm구하는 
	public List<AssociationVO> issuePmSelect(int projectId);
	
	// projectRoleId구함 (projectID알고있을때)
	public int projectRoleIdSelect(ProjectAttendVO pVO);
}
