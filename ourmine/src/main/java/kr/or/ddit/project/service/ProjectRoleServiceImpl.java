package kr.or.ddit.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.project.dao.ProjectRoleDAO;
import kr.or.ddit.project.vo.ProjectRoleVO;
import kr.or.ddit.project.vo.ProjectVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ProjectRoleServiceImpl implements ProjectRoleService{
	
	private final ProjectRoleDAO projectRoleDAO;

	@Override
	@Transactional(readOnly = true)
	public List<ProjectRoleVO> ProjectRoleList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional(readOnly = true)
	public ProjectRoleVO ProjectRoleSelect(int projectRoleId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertProjectRole(ProjectRoleVO projectRole) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateProjectRole(ProjectRoleVO projectRole) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProjectRole(int projectRoleId) {
		// TODO Auto-generated method stub
		return 0;
	}
	

}
