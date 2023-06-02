package kr.or.ddit.projectwork.service;

import java.util.List;

import kr.or.ddit.projectwork.vo.ProjectWorkStatusVO;

public interface ProjectWorkStatusService {


	public List<ProjectWorkStatusVO> projectWorkStatusList();
	
	public ProjectWorkStatusVO projectWorkStatusSelect(int projectWorkStatusId);
	
	public int insertProjectWorkStatus(ProjectWorkStatusVO projectWorkStatus);
	
	public int updateProjectWorkStatus(ProjectWorkStatusVO projectWorkStatus);
	
	public int deleteProjectWorkStatus(int projectWorkStatusId);
}
