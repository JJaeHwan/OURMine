package kr.or.ddit.projectwork.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.projectwork.vo.ProjectWorkPriorityVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ProjectWorkPriorityServiceImpl implements ProjectWorkPriorityService{

	@Override
	@Transactional(readOnly = true)
	public List<ProjectWorkPriorityVO> projectWorkPriorityList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional(readOnly = true)
	public ProjectWorkPriorityVO projectWorkPrioritySelect(int projectWorkPriorityId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertProjectWorkPriority(ProjectWorkPriorityVO projectWorkPriority) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateProjectWorkPriority(ProjectWorkPriorityVO projectWorkPriority) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProjectWorkPriority(int projectWorkPriorityId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
