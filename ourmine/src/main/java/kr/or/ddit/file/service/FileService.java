package kr.or.ddit.file.service;

import java.util.List;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.file.vo.FileVO;

public interface FileService {
	
	public List<BoardVO> fileList(int companyId);
}
