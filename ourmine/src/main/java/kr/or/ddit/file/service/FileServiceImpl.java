package kr.or.ddit.file.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.file.dao.FileDAO;
import kr.or.ddit.file.vo.FileVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FileServiceImpl implements FileService {

	private final FileDAO fileDao;
	
	@Override
	public List<BoardVO> fileList(int companyId) {
		return fileDao.fileList(companyId);
	}

}
