package kr.or.ddit.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.project.vo.ProjectRoleVO;
import kr.or.ddit.project.vo.ProjectVO;

@Mapper
public interface ProjectRoleDAO {
	
	public List<ProjectRoleVO> ProjectRoleList();
	
	public ProjectRoleVO ProjectRoleSelect(int projectRoleId);
	
	public int insertProjectRole(ProjectRoleVO projectRole);
	
	public int updateProjectRole(ProjectRoleVO projectRole);
	
	public int deleteProjectRole(int projectRoleId);
}
