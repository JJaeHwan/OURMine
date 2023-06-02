package kr.or.ddit.codeWall.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.codeWall.vo.CodeWallVO;

public interface CodeWallService {

public List<CodeWallVO> selectCodeWallList(int projectId);
	
	public CodeWallVO selectCodeWallArticle(int codeWallId);
	
	public int insertCodeWall(CodeWallVO vo);
	
	public int updateCodeWall(CodeWallVO vo);
	
	public int deleteCodeWall();
	
}
