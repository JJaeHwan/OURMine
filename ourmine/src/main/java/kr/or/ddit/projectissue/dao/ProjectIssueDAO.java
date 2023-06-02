package kr.or.ddit.projectissue.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectissue.vo.ProjectIssueVO;
import kr.or.ddit.vo.Page;

@Mapper
public interface ProjectIssueDAO {
	
	
	public List<Page> projectIssueList(Page pagination);
	
	public List<ProjectIssueVO> projectIssueListBottom(int projectId);
	
	// 페이징을 위한 전체 데이터수 
	public int totalData(int projectId);
	
	public ProjectIssueVO projectIssueSelect(int projectIssueId);
	
	public int insertProjectIssue( ProjectIssueVO projectIssue);
	
	public int updateProjectIssue(ProjectIssueVO projectIssue);

	public int updateProjectIssueStatus(int projectIssueId);
	
	public int updateProjectIssueComment(ProjectIssueVO projectIssue);
	
	public int deleteProjectIssue(int projectIssueId);
	
	public List<ProjectAttendVO> alarmReceiverList(int projectId);
	
	public List<ProjectIssueVO> projectCodeList();
	
	public List<ProjectIssueVO> projectTrackerList();
	
	public ProjectIssueVO projectRoleSelect( ProjectIssueVO projectIssue);
	
	
}
