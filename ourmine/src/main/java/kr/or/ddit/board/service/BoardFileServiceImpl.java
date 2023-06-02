package kr.or.ddit.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.board.dao.BoardFileDAO;
import kr.or.ddit.board.vo.BoardFileVO;
import kr.or.ddit.board.vo.BoardVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class BoardFileServiceImpl implements BoardFileService{
	
	private final BoardFileDAO boardFileDAO;
	
	
	
	@Override
	public List<BoardFileVO> boardFileList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardFileVO boardFileSelect(int boardFileId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertBoardFile(BoardFileVO boardFile) {
		return boardFileDAO.insertBoardFile(boardFile);
	}

	@Override
	public int updateBoardFile(BoardFileVO boardFile) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBoardFile(int boardFileId) {
		// TODO Auto-generated method stub
		return 0;
	}
	


}
