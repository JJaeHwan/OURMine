package kr.or.ddit.projectAttend.service;

import java.util.List;

import kr.or.ddit.alarm.dao.AlarmDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.projectAttend.dao.ProjectAttendDAO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
@Transactional
public class ProjectAttendServiceImpl implements ProjectAttendService{
	
	private final ProjectAttendDAO dao;
	private final AlarmDAO alarmdao;
	
	@Override
	@Transactional(readOnly = true)
	public List<ProjectAttendVO> ProjectAttendList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional(readOnly = true)
	public ProjectAttendVO ProjectAttendSerlect(int projectAttendId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertProjectAttend(ProjectAttendVO projectAttend) {
		


		return dao.insertProjectAttend(projectAttend);
		
	}

	@Override
	public int deleteProjectAttend(int projectAttendAk) {
		return dao.deleteProjectAttend(projectAttendAk);
	}

	@Override
	public int insertProjectAttendPL(List<ProjectAttendVO> projectAttend) {
		return dao.insertProjectAttendPL(projectAttend);
	}


	@Override
	public int updateProjectAttendStatus(ProjectAttendVO projectAttend) {
		return dao.updateProjectAttendStatus(projectAttend);
	}

	@Override
	public int updateProjectAttend(ProjectAttendVO projectAttend) {
		return dao.updateProjectAttend(projectAttend);
	}

	@Override
	public int countProjectAttend(ProjectAttendVO projectAttend) {
		return dao.countProjectAttend(projectAttend);
	}



	@Override
	public List<AssociationVO> issuePmSelect(int projectId) {
		return dao.issuePmSelect(projectId);
	}

	@Override
	public int projectRoleIdSelect(ProjectAttendVO pVO) {
		return dao.projectRoleIdSelect(pVO);
	}


}
