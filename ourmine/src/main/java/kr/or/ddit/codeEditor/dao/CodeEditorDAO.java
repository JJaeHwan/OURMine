package kr.or.ddit.codeEditor.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.codeEditor.vo.CodeVO;

@Mapper
public interface CodeEditorDAO {
	
	public String codeSelectByLanguage(int codeEditorId);
	
	public List<CodeVO> savedCodeList(CodeVO vo);
	
	public List<CodeVO> getWholeCodeListByProject(int projectId);
	
	public CodeVO getSelectedCode(int codeId);
	
	public int codeInsert(CodeVO code);
	
	public int updateCode(CodeVO code);

	public int deleteCode(CodeVO code);
	
	
	
	
}
