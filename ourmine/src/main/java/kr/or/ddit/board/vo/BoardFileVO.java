package kr.or.ddit.board.vo;

import java.io.Serializable;
import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "boardFileId")
public class BoardFileVO implements Serializable{


	// 게시판 파일 ID 프로젝트게시판파일ID
    private int boardFileId;

    // 게시판 ID 프로젝트게시판ID
    private int boardId;

    // 파일 카테고리 ID 파일카테고리ID
    private int fileCategoryId;

    // 원본 파일 이름 원본파일이름
    private String originalFileName;

    // 저장 파일 이름 저장파일이름
    private String saveFileName;

    // 파일 경로 파일 경로
    private String fileRoute;

    // 파일 생성 일자 파일생성일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate fileCreateDate;

    // 파일 확장자 파일
    private String fileExtension;


    //  이미지 보여줄 경로
 	private String imageContents;
}
