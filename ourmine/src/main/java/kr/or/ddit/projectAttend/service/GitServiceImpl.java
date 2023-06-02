package kr.or.ddit.projectAttend.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.projectAttend.dao.GitDAO;
import kr.or.ddit.projectAttend.vo.GitVO;
import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
@Transactional
public class GitServiceImpl implements GitService{

	private final GitDAO gitDAO;

	@Override
	@Transactional(readOnly = true)
	public List<GitVO> gitList(GitVO git) {

		return gitDAO.gitList(git);
	}

	@Override
	public List<GitVO> gitMemberCommitSelect(GitVO git) {

		return gitDAO.gitMemberCommitSelect(git);
	}

	@Override
	@Transactional(readOnly = true)
	public List<GitVO> gitCommitCount(GitVO git) {

		return gitDAO.gitCommitCount(git);
	}

	@Override
	public int insertGit(GitVO git) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateGit(GitVO git) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteGit(int gitId) {
		// TODO Auto-generated method stub
		return 0;
	}



}
