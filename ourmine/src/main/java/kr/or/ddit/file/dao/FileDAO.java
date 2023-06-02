package kr.or.ddit.file.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.file.vo.FileVO;

@Mapper
public interface FileDAO {
	
	public List<BoardVO> fileList(int companyId);
}
