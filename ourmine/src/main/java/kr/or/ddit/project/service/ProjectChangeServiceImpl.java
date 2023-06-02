package kr.or.ddit.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.project.dao.ProjectChangeDAO;
import kr.or.ddit.project.vo.ProjectChangeVO;
import lombok.RequiredArgsConstructor;



@Service
@RequiredArgsConstructor
@Transactional
public class ProjectChangeServiceImpl implements ProjectChangeService{

	private final ProjectChangeDAO projectChangeDAO;
	
	@Override
	@Transactional(readOnly = true)
	public List<ProjectChangeVO> ProjectChangeList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional(readOnly = true)
	public ProjectChangeVO ProjectChangeSelect(int ProjectChangeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertProjectChange(ProjectChangeVO projectChange) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateProjectChange(ProjectChangeVO projectChange) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProjectChange(int ProjectChangeId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
