package kr.or.ddit.noticeBoard.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "noticeBoardFileId")
public class NoticeBoardFileVO implements Serializable {
	 //게시판첨부파일ID
    private int noticeBoardFileId;

    //공지게시판작성ID
    private int noticeBoardWriteId;


    //공지게시판 파일 경로
    private String noticeBoardFileRoute;

    //파일생성일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate fileCreateDate;

    //원본파일이름
    private String originalFileName;

    //저장파일이름
    private String saveFileName;

    // 파일 확장자
    private String fileExtension;
    
    // 다중파일이라 List로 객체 만듬
    private List<MultipartFile> files;
    
    
}
