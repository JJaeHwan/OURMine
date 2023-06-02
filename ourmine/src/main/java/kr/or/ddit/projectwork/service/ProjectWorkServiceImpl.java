package kr.or.ddit.projectwork.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectwork.dao.ProjectWorkDAO;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import kr.or.ddit.vo.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class ProjectWorkServiceImpl implements ProjectWorkService{
	
	private final ProjectWorkDAO projectWorkDao;
	
	@Override
	@Transactional(readOnly = true)
	public List<Page> projectWorkList(Page pagination) {
		return projectWorkDao.projectWorkList(pagination);
	}

	@Override
	public int totalData(int projectId) {
		return projectWorkDao.totalData(projectId);
	}
	
	@Override
	@Transactional(readOnly = true)
	public ProjectWorkVO projectWorkSelect(int projectWorkId) {
		return projectWorkDao.projectWorkSelect(projectWorkId);
	}

	@Override
	public int insertProjectWork(ProjectWorkVO projectWork) {
		return projectWorkDao.insertProjectWork(projectWork);
	}

	@Override
	public int updateProjectWork(ProjectWorkVO projectWork) {
		return projectWorkDao.updateProjectWork(projectWork);
	}

	@Override
	public int deleteProjectWork(int projectWorkId) {
		return projectWorkDao.deleteProjectWork(projectWorkId);
	}

	////////////// 추가 //////////////
	@Override
	public int selectProjectRole(ProjectWorkVO projectWork) {
		return projectWorkDao.selectProjectRole(projectWork);
	}

	@Override
	public List<ProjectAttendVO> projectMemberList(int projectId) {
		List<ProjectAttendVO> projectmemberList = projectWorkDao.projectMemberList(projectId);
		log.info("@@@@@@@@@@ projectmemberList : {}",projectmemberList );
		return projectmemberList;
	}

	// 나의 일감 리스트 조회
	@Override
	public List<Page> projectTodoWorkList(Page pagination) {
		return projectWorkDao.projectTodoWorkList(pagination);
	}
	// 나의 일감 전체 갯수
	@Override
	public int totalWorkData(Page pagination) {
		return projectWorkDao.totalWorkData(pagination);
	}
	// todo에서 일감 상태 변경
	@Override
	public int updateStatus(int projectWorkId) {
		return projectWorkDao.updateStatus(projectWorkId);
	}
	
	@Override
	public List<ProjectWorkVO> pwList(ProjectWorkVO projectWorkVO) {
		return projectWorkDao.pwList(projectWorkVO);
	}


}
