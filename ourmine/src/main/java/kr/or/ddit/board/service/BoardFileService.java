package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.vo.BoardFileVO;

public interface BoardFileService {
	
	
	/**
	 * 
	 * @return
	 */
	public List<BoardFileVO> boardFileList();
	/**
	 * 
	 * @param boardFileId
	 * @return
	 */
	public BoardFileVO boardFileSelect(int boardFileId);
	/**
	 * 
	 * @param boardFile
	 * @return
	 */
	public int insertBoardFile(BoardFileVO  boardFile);
	/**
	 * 
	 * @param boardFile
	 * @return
	 */
	public int updateBoardFile(BoardFileVO  boardFile);
	/**
	 * 
	 * @param boardFileId
	 * @return
	 */
	public int deleteBoardFile(int boardFileId);
	
}
