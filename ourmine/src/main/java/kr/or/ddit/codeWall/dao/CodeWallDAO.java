package kr.or.ddit.codeWall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.codeWall.vo.CodeWallVO;

@Mapper
public interface CodeWallDAO {
	
	public List<CodeWallVO> selectCodeWallList(int projectId);
	
	public CodeWallVO selectCodeWallArticle(int codeWallId);
	
	public int insertCodeWall(CodeWallVO vo);
	
	public int updateCodeWall(CodeWallVO vo);
	
	public int deleteCodeWall();
	
	
	
}
