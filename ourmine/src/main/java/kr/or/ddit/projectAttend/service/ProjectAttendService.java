package kr.or.ddit.projectAttend.service;

import java.util.List;

import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;

public interface ProjectAttendService {
	/**
	 * 
	 * @return
	 */
	public List<ProjectAttendVO> ProjectAttendList();
	
	/**
	 * 
	 * @param projectAttend
	 * @return
	 */
	public int countProjectAttend(ProjectAttendVO projectAttend);
	
	/**
	 * 
	 * @param projectAttendId
	 * @return
	 */
	public ProjectAttendVO ProjectAttendSerlect(int projectAttendId);
	/**
	 * 
	 * @param projectAttend
	 * @return
	 */
	public int insertProjectAttend(ProjectAttendVO projectAttend);
	
	public int insertProjectAttendPL(List<ProjectAttendVO> projectAttend);
	/**
	 * 
	 * @param projectAttend
	 * @return
	 */
	public int updateProjectAttendStatus(ProjectAttendVO projectAttend);
	/**
	 * 
	 * @param projectAttend
	 * @return
	 */
	public int deleteProjectAttend(int projectAttendAk);

	/**
	 *
	 * @param projectAttend
	 * @return
	 */
	public int updateProjectAttend(ProjectAttendVO  projectAttend);
	
	public List<AssociationVO> issuePmSelect(int projectId);
	
	public int projectRoleIdSelect(ProjectAttendVO pVO);
}
