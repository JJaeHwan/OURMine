package kr.or.ddit.projectwork.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projectwork.vo.ProjectWorkStatusVO;

@Mapper
public interface ProjectWorkStatusDAO {
	
	
	public List<ProjectWorkStatusVO> projectWorkStatusList();
	
	public ProjectWorkStatusVO projectWorkStatusSelect(int projectWorkStatusId);
	
	public int insertProjectWorkStatus(ProjectWorkStatusVO projectWorkStatus);
	
	public int updateProjectWorkStatus(ProjectWorkStatusVO projectWorkStatus);
	
	public int deleteProjectWorkStatus(int projectWorkStatusId);
}
