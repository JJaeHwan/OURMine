package kr.or.ddit.project.service;

import java.util.List;

import kr.or.ddit.project.vo.ProjectRoleVO;
import kr.or.ddit.project.vo.ProjectVO;

public interface ProjectRoleService {
	
	/**
	 * 
	 * @return
	 */
	public List<ProjectRoleVO> ProjectRoleList();
	
	/**
	 * 
	 * @param projectRoleId
	 * @return
	 */
	public ProjectRoleVO ProjectRoleSelect(int projectRoleId);
	/**
	 * 
	 * @param projectRole
	 * @return
	 */
	public int insertProjectRole(ProjectRoleVO projectRole);
	/**
	 * 
	 * @param projectRole
	 * @return
	 */
	public int updateProjectRole(ProjectRoleVO projectRole);
	
	public int deleteProjectRole(int projectRoleId);
	
}
