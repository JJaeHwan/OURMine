package kr.or.ddit.projecttodolist.service;

import java.util.List;

import org.springframework.security.core.Authentication;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.projecttodolist.vo.ProjectTodoListVO;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;

/**
 * @author User
 *
 */
public interface ProjectTodoListService {
	
	// 일감별 todoList
	public List<ProjectTodoListVO> projectTodoList(int projectWorkId);
	
	/**
	 * 
	 * @param projectTodoList
	 * @return
	 */
	public int insertrProjectTodoList(ProjectTodoListVO projectTodoListVO);
	
	/**
	 * @param todoId
	 * @return
	 */
	public int completeProjectTodoList(int todoId);
	
	/**
	 * @param todoId
	 * @return
	 */
	public int returnProjectTodoList(int todoId);
	
	/**
	 * 
	 * @param todoId
	 * @return
	 */
	public int deleteProjectTodoList(int todoId);
	
}
