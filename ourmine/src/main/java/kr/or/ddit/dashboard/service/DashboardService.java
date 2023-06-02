package kr.or.ddit.dashboard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.company.dao.CompanyDAO;
import kr.or.ddit.dashboard.vo.DashboardVO;
import kr.or.ddit.project.vo.ProjectVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectissue.vo.ProjectIssueVO;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import lombok.RequiredArgsConstructor;


public interface DashboardService {
	
	/**
	 * 
	 * @return
	 */
	public ProjectAttendVO dashboardList(ProjectAttendVO attendVO);
	/**
	 * 
	 * @param dashboardId
	 * @return
	 */
	public DashboardVO dashboardSelect(int dashboardId);
	/**
	 * 
	 * @param dashboard
	 * @return
	 */
	public int insertrDashboard(DashboardVO  dashboard);
	
	/**
	 * 
	 * @param dashboard
	 * @return
	 */
	public int updateDashboard(DashboardVO  dashboard);
	
	/**
	 * 
	 * @param dashboardId
	 * @return
	 */
	public int deleteDashboard(int dashboardId);
	
	public List<ProjectVO> projectData (int projectId);
	
	public List<ProjectIssueVO> issueData(int projectId);
	
	public ProjectWorkVO workData(int projectId);
	
	public List<ProjectWorkVO> workMemberData(int projectId);
}
