package kr.or.ddit.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.project.vo.ProjectVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;

@Mapper
public interface ProjectDAO {
	
	public List<ProjectVO> projectList(AssociationVO vo);
	
	public List<AssociationVO> projectMemberList(int companyId);
	
	public ProjectVO projectSelect(int projectId);
	
	public int insertProject(ProjectVO vo);
	
	public int updateProject(ProjectVO project);
	
	public int deleteProject(int projectId);
	
	public int projectMemberCountSelect();

}
