package kr.or.ddit.projecttodolist.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.projecttodolist.dao.ProjectTodoListDAO;
import kr.or.ddit.projecttodolist.vo.ProjectTodoListVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ProjectTodoListServiceImpl implements ProjectTodoListService{
	
	private final ProjectTodoListDAO projectTodoListDAO;

	@Override
	@Transactional(readOnly = true)
	public List<ProjectTodoListVO> projectTodoList(int projectWorkId) {
		return projectTodoListDAO.projectTodoList(projectWorkId);
	}

	@Override
	@Transactional(readOnly = true)
	public int insertrProjectTodoList(ProjectTodoListVO projectTodoListVO) {
		return projectTodoListDAO.insertrProjectTodoList(projectTodoListVO);
	}

	@Override
	public int completeProjectTodoList(int todoId) {
		return projectTodoListDAO.completeProjectTodoList(todoId);
	}
	
	@Override
	public int returnProjectTodoList(int todoId) {
		return projectTodoListDAO.returnProjectTodoList(todoId);
	}

	@Override
	public int deleteProjectTodoList(int todoId) {
		return projectTodoListDAO.deleteProjectTodoList(todoId);
	}

}
