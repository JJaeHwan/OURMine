package kr.or.ddit.noticeBoard.vo;

import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "noticeBoardWriteId")
public class NoticeBoardVO implements Serializable {

	private int rnum;

	// 공지게시판 ID
    private int noticeBoardWriteId;

    // 회원ID 관리자ID 외래키
    private int memberId;

    // 카테고리 카테고리
    private String category;

    // 공지게시판 제목
    @NotNull
    private String noticeBoardTitle;

    // 공지게시판 작성자
    @NotNull
    private String noticeBoardWriter;

    // 공지게시판 내용
    @NotNull
    private String noticeBoardContent;

    // 공지게시판조회수
    private int noticeBoardCount;


    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    // 시작 기간 종료기간
    private LocalDate startDay;	// LocalDate

    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    // 종료 기간 종료기간
    private LocalDate endDay;

    // 공지게시판 작성일자
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate noticeBoardWriteDate;

    // 공지게시판 수정일자
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate noticeBoardModifyDate;

    // 삭제 여부
    private String removeWhether;

    // 파일경로
    private String noticeBoardFileRoute;
    // 이미지 보여줄 객체
    private String imageContents;

    private String  originalFileName;

    // 파일확장자
    private String fileExtension;

    private String saveFileName;

    // 다중파일이라 List로 객체 만듬
    private List<MultipartFile> files;

}
