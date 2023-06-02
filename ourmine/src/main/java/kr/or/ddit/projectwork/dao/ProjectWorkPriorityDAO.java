package kr.or.ddit.projectwork.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projectwork.vo.ProjectWorkPriorityVO;

@Mapper
public interface ProjectWorkPriorityDAO {
	
	
	public List<ProjectWorkPriorityVO> projectWorkPriorityList();
	
	public ProjectWorkPriorityVO projectWorkPrioritySelect(int projectWorkPriorityId);
	
	public int insertProjectWorkPriority(ProjectWorkPriorityVO projectWorkPriority);
	
	public int updateProjectWorkPriority(ProjectWorkPriorityVO projectWorkPriority);
	
	public int deleteProjectWorkPriority(int projectWorkPriorityId);
}
