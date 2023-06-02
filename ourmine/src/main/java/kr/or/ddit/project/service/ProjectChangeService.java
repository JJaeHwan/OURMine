package kr.or.ddit.project.service;

import java.util.List;

import kr.or.ddit.project.vo.ProjectChangeVO;

public interface ProjectChangeService {
	
	/**
	 * 
	 * @return
	 */
	public List<ProjectChangeVO> ProjectChangeList();
	
	/**
	 * 
	 * @param ProjectChangeId
	 * @return
	 */
	public ProjectChangeVO ProjectChangeSelect(int ProjectChangeId);
	
	/**
	 * 
	 * @param projectChange
	 * @return
	 */
	public int insertProjectChange(ProjectChangeVO projectChange);
	
	/**
	 * 
	 * @param projectChange
	 * @return
	 */
	public int updateProjectChange(ProjectChangeVO projectChange);
	
	
	/**
	 * 
	 * @param ProjectChangeId
	 * @return
	 */
	public int deleteProjectChange(int ProjectChangeId);
}
