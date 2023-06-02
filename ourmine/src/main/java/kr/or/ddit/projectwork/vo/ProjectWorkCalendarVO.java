package kr.or.ddit.projectwork.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "calendarId")
public class ProjectWorkCalendarVO implements Serializable {
	
	// 캘린더 ID 캘린더ID
    private int calendarId;

    // 프로젝트 업무 ID 프로젝트업무ID
    private int projectWorkId;

    // 그룹 ID 그룹ID
    private int groupId;

    // 제목 제목
    @NotNull
    private String title;

    // 작성자 작성자
    private String writer;

    // 내용 내용
    @NotNull
    private String content;

    // 시작일 
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate start1;

    // 종료일 
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate end1;

    // 올데이 올데이
    private int allDay;

    // 텍스트 컬러 텍스트컬러
    private String textColor;

    // 백그라운드 컬러 백그라운드컬러
    private String backgroundColor;

    // 보더 컬러 보더컬러
    private String borderColor;
}
