package kr.or.ddit.project.service;

import java.util.List;

import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.project.vo.ProjectVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;

import org.springframework.security.core.Authentication;

public interface ProjectService {
	/**
	 * 
	 * @return
	 */
	public List<ProjectVO> projectList(Authentication user, MemberVO memberVO);
	
	
	
	public List<AssociationVO> projectMemberList(int companyId);
	
	/**
	 * 
	 * @param projectId
	 * @return
	 */
	public ProjectVO projectSelect(int projectId);
	/**
	 * 
	 * @param project
	 * @return
	 */
	public int updateProject(ProjectVO project);
	
	/**
	 * 
	 * @param projectId
	 * @return
	 */
	public int deleteProject(int projectId);
	
	// 프로젝트참여 인원수 조회
	public int projectMemberCountSelect();



	public int insertProject(ProjectVO vo, Authentication user);
	
	
}
