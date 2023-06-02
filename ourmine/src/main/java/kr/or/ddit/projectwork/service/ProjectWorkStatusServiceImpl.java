package kr.or.ddit.projectwork.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.projectwork.dao.ProjectWorkStatusDAO;
import kr.or.ddit.projectwork.vo.ProjectWorkStatusVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ProjectWorkStatusServiceImpl implements ProjectWorkStatusService{
	
	private final ProjectWorkStatusDAO projectWorkStatusDAO;
	
	@Override
	@Transactional(readOnly = true)
	public List<ProjectWorkStatusVO> projectWorkStatusList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional(readOnly = true)
	public ProjectWorkStatusVO projectWorkStatusSelect(int projectWorkStatusId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertProjectWorkStatus(ProjectWorkStatusVO projectWorkStatus) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateProjectWorkStatus(ProjectWorkStatusVO projectWorkStatus) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProjectWorkStatus(int projectWorkStatusId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
