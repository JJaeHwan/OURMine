package kr.or.ddit.codeEditor.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.codeEditor.dao.CodeEditorDAO;
import kr.or.ddit.codeEditor.vo.CodeVO;

@Service
public class CodeEditorServiceImpl implements CodeEditorService{

	@Inject
	private CodeEditorDAO codeDao;
	
	@Override
	public String codeSelectByLanguage(int codeEditorId) {
		return codeDao.codeSelectByLanguage(codeEditorId);
	}

	@Override
	public List<CodeVO> savedCodeList(CodeVO vo) {
		List<CodeVO> list = codeDao.savedCodeList(vo);
		return list;
	}
	
	@Override
	public List<CodeVO> getWholeCodeListByProject(int projectId) {
		return null;
	}
	
	@Override
	public CodeVO getSelectedCode(int codeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int codeInsert(CodeVO code) {
		return codeDao.codeInsert(code);
	}

	@Override
	public int updateCode(CodeVO code) {
		int rowcnt = codeDao.updateCode(code);
		return rowcnt;
	}

	@Override
	public int deleteCode(CodeVO code) {
		// TODO Auto-generated method stub
		return 0;
	}

}
