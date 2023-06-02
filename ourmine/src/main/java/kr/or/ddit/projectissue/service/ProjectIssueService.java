package kr.or.ddit.projectissue.service;

import java.util.List;

import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectissue.vo.ProjectIssueVO;
import kr.or.ddit.vo.Page;
import org.springframework.security.core.Authentication;

public interface ProjectIssueService {
	
	/**
	 * 
	 * @return
	 */
	public List<Page> projectIssueList(Page pagination);
	public List<ProjectIssueVO> projectIssueListBottom(int projectId);
	// 페이징을 위한 전체 데이터수
	public int totalData(int projectId);
	
	/**
	 * 
	 * @param projectIssueId
	 * @return
	 */
	public ProjectIssueVO projectIssueSelect(int projectIssueId);
	/**
	 * 
	 * @param projectIssue
	 * @return
	 */
	public int insertProjectIssue(ProjectIssueVO projectIssue, Authentication user);
	/**
	 * 
	 * @param projectIssue
	 * @return
	 */
	public int updateProjectIssue(ProjectIssueVO projectIssue);
	
	public int updateProjectIssueStatus(int  projectIssueId);
	
	public int updateProjectIssueComment(ProjectIssueVO projectIssue);
	
	/**
	 * 
	 * @param projectIssueId
	 * @return
	 */
	public int deleteProjectIssue(int projectIssueId);
	
	public List<ProjectAttendVO> alarmReceiverList(int projectId);
	
	public List<ProjectIssueVO> projectCodeList();
	
	public List<ProjectIssueVO> projectTrackerList();
	
	public ProjectIssueVO projectRoleSelect(ProjectIssueVO projectIssue);
	
}
