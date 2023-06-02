package kr.or.ddit.ui;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.noticeBoard.vo.NoticeBoardFileVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class NoticeBoardFileUtil {

    private NoticeBoardFileUtil() {
        throw new IllegalStateException("NoticeBoardFileUtil class");
    }
    public static NoticeBoardFileVO saveFile(MultipartFile file, String uploadDir, String webUploadDir, int noticeBoardWriteId) {
        // 저장할 파일의 이름을 생성합니다.
        String originalFileName = file.getOriginalFilename();
        String fileExtension = FilenameUtils.getExtension(originalFileName);
        String saveFileName = UUID.randomUUID().toString() + "." + fileExtension;

        String filePath = uploadDir + File.separator + saveFileName;  // uploadDir를 사용하여 파일 경로를 생성
        String webFilePath = webUploadDir + File.separator + saveFileName; // webUploadDir를 사용하여 웹 경로를 생성

        File saveFile = new File(filePath);
        File webSaveFile = new File(webFilePath);

        try {
        	log.info("webSaveFile = {}",webSaveFile);
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

        // NoticeBoardFileVO에 추가
        NoticeBoardFileVO noticeBoardFile = new NoticeBoardFileVO();
        noticeBoardFile.setNoticeBoardWriteId(noticeBoardWriteId);
        noticeBoardFile.setNoticeBoardFileRoute(filePath);
        noticeBoardFile.setOriginalFileName(originalFileName);
        noticeBoardFile.setSaveFileName(saveFileName);
        noticeBoardFile.setFileExtension(fileExtension);
        return noticeBoardFile;
    }
}