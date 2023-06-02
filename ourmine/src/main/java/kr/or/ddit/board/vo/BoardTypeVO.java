package kr.or.ddit.board.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "boardTypeId")
public class BoardTypeVO implements Serializable {
	// 게시판 종류 ID 게시판종류ID
    private int boardTypeId;

    // 프로젝트 ID 프로젝트ID
    private int projectId;

    // 게시판 종류 게시판종류
    private String boardType;

    // 게시판 생성 일자 게시판생성일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate boardCreateDate;

    // 삭제 여부 삭제 여부
    private String removeWhether;
}
