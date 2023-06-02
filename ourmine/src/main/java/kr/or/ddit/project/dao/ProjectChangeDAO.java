package kr.or.ddit.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.project.vo.ProjectChangeVO;


@Mapper
public interface ProjectChangeDAO {
	
	
	public List<ProjectChangeVO> ProjectChangeList();
	
	public ProjectChangeVO ProjectChangeSelect(int ProjectChangeId);
	
	public int insertProjectChange(ProjectChangeVO projectChange);
	
	public int updateProjectChange(ProjectChangeVO projectChange);
	
	public int deleteProjectChange(int ProjectChangeId);
}
