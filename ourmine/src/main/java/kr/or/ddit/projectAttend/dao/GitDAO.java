package kr.or.ddit.projectAttend.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.projectAttend.vo.GitVO;

@Mapper
public interface GitDAO {

	public List<GitVO> gitList(GitVO git);

	public List<GitVO> gitCommitCount(GitVO git);

	public List<GitVO> gitMemberCommitSelect(GitVO git);

	public int insertGit(GitVO git);

	public int updateGit(GitVO git);

	public int deleteGit(int gitId);

}
