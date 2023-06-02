package kr.or.ddit.dashboard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.dashboard.dao.DashboardDAO;
import kr.or.ddit.dashboard.vo.DashboardVO;
import kr.or.ddit.project.vo.ProjectVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectissue.vo.ProjectIssueVO;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
@Transactional
public class DashboardServiceImpl implements DashboardService{
	
	private final DashboardDAO dashboardDAO; 
	
	@Override
	public ProjectAttendVO dashboardList(ProjectAttendVO attendVO) {
		return dashboardDAO.dashboardList(attendVO);
	}

	@Override
	public DashboardVO dashboardSelect(int dashboardId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertrDashboard(DashboardVO dashboard) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateDashboard(DashboardVO dashboard) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteDashboard(int dashboardId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProjectVO> projectData(int projectId) {
		return dashboardDAO.projectData(projectId);
	}

	@Override
	public List<ProjectIssueVO> issueData(int projectId) {
		// TODO Auto-generated method stub
		return dashboardDAO.issueData(projectId);
	}

	@Override
	public ProjectWorkVO workData(int projectId) {
		return dashboardDAO.workData(projectId);
	}

	@Override
	public List<ProjectWorkVO> workMemberData(int projectId) {
		return dashboardDAO.workMemberData(projectId);
	}

}
