package kr.or.ddit.dashboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.dashboard.vo.DashboardVO;
import kr.or.ddit.project.vo.ProjectVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectissue.vo.ProjectIssueVO;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;

@Mapper
public interface DashboardDAO {
	
	
	public ProjectAttendVO dashboardList(ProjectAttendVO attendVO);
	
	public DashboardVO dashboardSelect(int dashboardId);
	
	public int insertrDashboard(DashboardVO  dashboard);
	
	public int updateDashboard(DashboardVO  dashboard);
	
	public int deleteDashboard(int dashboardId);
	
	public List<ProjectVO> projectData (int projectId);
	
	public List<ProjectIssueVO> issueData(int projectId);
	
	public ProjectWorkVO workData(int projectId);
	
	public List<ProjectWorkVO> workMemberData(int projectId);
	
}
