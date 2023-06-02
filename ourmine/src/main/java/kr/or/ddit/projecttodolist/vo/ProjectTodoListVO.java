package kr.or.ddit.projecttodolist.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "todoId")
public class ProjectTodoListVO implements Serializable {
	
	// 할일 ID 할일ID
    private int todoId;

    // 프로젝트 업무 ID 프로젝트업무ID
    private int projectWorkId;

    // 할일 제목 할일제목
    @NotNull
    private String todoTitle;

    // 할일 내용 할일내용
    @NotNull
    private String todoContent;

    // 할일 작성자 할일작성자
    @NotNull
    private String todoWriter;

    // 할일 작성 일자 할일작성일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDateTime todoWriteDate;

    // 할일 수정 일자 할일수정일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDateTime todoModifyDate;

    // 할일 삭제 여부 할일삭제여부
    private String todoRemoveWhether;

    // 할일 완료 여부
    private String completeWhether;
    
    //=================================================================================
    // 담당자 이름
    private String memberName;
    
}

