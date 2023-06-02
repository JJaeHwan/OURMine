package kr.or.ddit.board.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.web.multipart.MultipartFile;

@Data
@EqualsAndHashCode(of = "boardId")
public class BoardVO implements Serializable {


    // 게시판 ID
    private int boardId;

    // 게시판 종류 ID
    private int boardTypeId;

    // 프로젝트 ID
    private int projectId;

    // 회원 ID
    private int memberId;

    // 프로젝트 역할 ID
    private int projectRoleId;

    // 회사 ID
    private int companyId;

    // 프로젝트게시판 작성자
    @NotNull
    private String boardWriter;

    //프로젝트 게시판 내용
    @NotNull
    private String boardContent;

    private String boardTitle;

    // 프로젝트 게시판 전체 게시물 갯수
    private int boardCount;

    //프로젝트게시판작성일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate boardWriteDate;

    //프로젝트게시판수정일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate boardModifyDate;

    //삭제 여부
    private boolean removeWhether;


    ////////////////// 추가 ///////////////////////
    // 회원 Name
    private int memberName;
    // 사내 공지인지 아닌지
    private String boardConotice;

    // 다중파일이라 List로 객체 만듬
    private List<MultipartFile> files;

    private String originalFileName;

    private String saveFileName;

    private Integer boardFileId;

    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
	private LocalDate fileCreateDate;


}
