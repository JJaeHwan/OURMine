package kr.or.ddit.projecttodolist.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projecttodolist.vo.ProjectTodoListVO;

@Mapper
public interface ProjectTodoListDAO {
	
	// 일감별 todoList
	public List<ProjectTodoListVO> projectTodoList(int projectWorkId);
	
	public int insertrProjectTodoList(ProjectTodoListVO projectTodoListVO);
	
	public int completeProjectTodoList(int todoId);
	public int returnProjectTodoList(int todoId);
	
	public int deleteProjectTodoList(int todoId);
	
}
