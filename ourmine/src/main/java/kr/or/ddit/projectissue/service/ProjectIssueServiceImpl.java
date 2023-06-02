package kr.or.ddit.projectissue.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.alarm.dao.AlarmDAO;
import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.projectissue.dao.ProjectIssueDAO;
import kr.or.ddit.projectissue.vo.ProjectIssueVO;
import kr.or.ddit.ui.AlarmSendUtil;
import kr.or.ddit.vo.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class ProjectIssueServiceImpl implements ProjectIssueService{
	
	private final ProjectIssueDAO projectIssueDAO;
	private final AlarmDAO alarmDAO;
	
	@Override
	@Transactional(readOnly = true)
	public List<Page> projectIssueList(Page pagination) {
		return projectIssueDAO.projectIssueList(pagination);
	}
	@Override
	public List<ProjectIssueVO> projectIssueListBottom(int projectId) {
		return projectIssueDAO.projectIssueListBottom(projectId);
	}
	
	@Override
	public int totalData(int projectId) {
		return projectIssueDAO.totalData(projectId);
	}


	@Override
	public int insertProjectIssue(ProjectIssueVO projectIssue, Authentication user) {
		projectIssueDAO.insertProjectIssue(projectIssue);
		List<AlarmVO> alarms = projectIssue.getAlarms();
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		
		alarms.forEach(item ->{
			log.info("이슈아이디={}", projectIssue.getProjectIssueId());
			item.setProjectIssueId(projectIssue.getProjectIssueId());
			item.setAlarmContent(projectIssue.getIssueContent());
			item.setAlarmSender(principal.getRealUser().getMemberName());
		});
		MemberVOWrapper vow = (MemberVOWrapper) user.getPrincipal();
		int memId = vow.getRealUser().getMemberId();
		String memIdString = String.valueOf(memId);
		
//		AlarmSendUtil.send( memIdString, "testMessage", "11");
		return alarmDAO.insertAlarm(alarms);

	}

	@Override
	@Transactional(readOnly = true)
	public ProjectIssueVO projectIssueSelect(int projectIssueId) {
		// TODO Auto-generated method stub
		return projectIssueDAO.projectIssueSelect(projectIssueId);
	}

	@Override
	public int updateProjectIssueStatus(int projectIssueId) {
		return projectIssueDAO.updateProjectIssueStatus(projectIssueId);
	}

	@Override
	public int updateProjectIssue(ProjectIssueVO projectIssue) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProjectIssue(int projectIssueId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProjectIssueVO> projectCodeList() {
		return projectIssueDAO.projectCodeList();
	}

	@Override
	public List<ProjectIssueVO> projectTrackerList() {
		return projectIssueDAO.projectTrackerList();
	}

	@Override
	public ProjectIssueVO projectRoleSelect(ProjectIssueVO projectIssue) {
		return projectIssueDAO.projectRoleSelect(projectIssue);
	}
	@Override
	public int updateProjectIssueComment(ProjectIssueVO projectIssue) {
		return projectIssueDAO.updateProjectIssueComment(projectIssue);
	}
	@Override
	public List<ProjectAttendVO> alarmReceiverList(int projectId) {
		return projectIssueDAO.alarmReceiverList(projectId) ;
	}

	





	

	

}
