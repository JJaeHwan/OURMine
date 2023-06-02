package kr.or.ddit.projectAttend.service;

import java.util.List;

import kr.or.ddit.projectAttend.vo.GitVO;

public interface GitService {

	/**
	 *
	 * @return
	 */
	public List<GitVO> gitList(GitVO git);
	/**
	 *
	 * @param GitVO
	 * @return
	 */
	public List<GitVO> gitCommitCount(GitVO git);
	/**
	 *
	 * @param git
	 * @return
	 */
	public int insertGit(GitVO  git);
	/**
	 *
	 * @param git
	 * @return
	 */
	public int updateGit(GitVO  git);
	/**
	 *
	 * @param gitId
	 * @return
	 */
	public int deleteGit(int gitId);

	public List<GitVO> gitMemberCommitSelect(GitVO git);

}
