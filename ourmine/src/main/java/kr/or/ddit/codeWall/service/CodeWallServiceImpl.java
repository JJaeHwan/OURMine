package kr.or.ddit.codeWall.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.codeWall.dao.CodeWallDAO;
import kr.or.ddit.codeWall.vo.CodeWallVO;

@Service
public class CodeWallServiceImpl implements CodeWallService {

	@Inject
	private CodeWallDAO codeWallDao; 
	
	@Override
	public List<CodeWallVO> selectCodeWallList(int projectId) {
		return codeWallDao.selectCodeWallList(projectId);
	}

	@Override
	public CodeWallVO selectCodeWallArticle(int codeWallId) {
		return codeWallDao.selectCodeWallArticle(codeWallId);
	}

	@Override
	public int insertCodeWall(CodeWallVO vo) {
		return codeWallDao.insertCodeWall(vo);
	}

	@Override
	public int updateCodeWall(CodeWallVO vo) {
		return codeWallDao.updateCodeWall(vo);
	}

	@Override
	public int deleteCodeWall() {
		// TODO Auto-generated method stub
		return 0;
	}

}
