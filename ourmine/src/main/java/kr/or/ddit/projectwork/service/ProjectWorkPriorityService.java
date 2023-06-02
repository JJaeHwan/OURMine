package kr.or.ddit.projectwork.service;

import java.util.List;

import kr.or.ddit.projectwork.vo.ProjectWorkPriorityVO;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;

public interface ProjectWorkPriorityService {
	
	
	/**
	 * 
	 * @return
	 */
	public List<ProjectWorkPriorityVO> projectWorkPriorityList();
	/**
	 * 
	 * @param projectWorkPriorityId
	 * @return
	 */
	public ProjectWorkPriorityVO projectWorkPrioritySelect(int projectWorkPriorityId);
	/**
	 * 
	 * @param projectWorkPriority
	 * @return
	 */
	public int insertProjectWorkPriority(ProjectWorkPriorityVO projectWorkPriority);
	/**
	 * 
	 * @param projectWorkPriority
	 * @return
	 */
	public int updateProjectWorkPriority(ProjectWorkPriorityVO projectWorkPriority);
	
	/**
	 * 
	 * @param projectWorkPriorityId
	 * @return
	 */
	public int deleteProjectWorkPriority(int projectWorkPriorityId);
}
