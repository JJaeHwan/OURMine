package kr.or.ddit.ui;

import kr.or.ddit.board.vo.BoardFileVO;
import kr.or.ddit.noticeBoard.vo.NoticeBoardFileVO;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

public class BoardFileUtil {

	  private BoardFileUtil() {
	        throw new IllegalStateException("BoardFileUtil class");
	    }

	    public static BoardFileVO saveFile(MultipartFile file, String uploadDir,String webUploadDir, int boardId) {


	        // 저장할 파일의 이름을 생성합니다.
	    	  String originalFileName = file.getOriginalFilename();
	          String fileExtension = FilenameUtils.getExtension(originalFileName);
	          String saveFileName = UUID.randomUUID().toString() + "." + fileExtension;

	          String filePath = uploadDir + File.separator + saveFileName;  // uploadDir를 사용하여 파일 경로를 생성
	          String webFilePath = webUploadDir + File.separator + saveFileName; // webUploadDir를 사용하여 웹 경로를 생성

	          File saveFile = new File(filePath);
	          File webSaveFile = new File(webFilePath);

	          try {
	              // 경로에 디렉토리가 없으면 생성합니다.
	              saveFile.getParentFile().mkdirs();
	              webSaveFile.getParentFile().mkdirs();

	              // 파일을 직접 지정한 위치에 저장합니다.
	              file.transferTo(saveFile);
	              FileUtils.copyFile(saveFile, webSaveFile); // webUploadDir로 복사

	          } catch (IOException e) {
	              e.printStackTrace();
	              return null;  // 파일 저장 실패
	          }

	        // BoardFileVO 에 추가
	        BoardFileVO boardFile = new BoardFileVO();
			boardFile.setBoardId(boardId);
			boardFile.setFileRoute(filePath);
	        boardFile.setOriginalFileName(originalFileName);
	        boardFile.setSaveFileName(saveFileName);
	        boardFile.setFileExtension(fileExtension);
	        return boardFile;
	    }
}
