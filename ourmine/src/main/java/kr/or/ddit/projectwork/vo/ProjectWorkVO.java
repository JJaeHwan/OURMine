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
@EqualsAndHashCode(of = "projectWorkId")
public class ProjectWorkVO implements Serializable {
	 // 프로젝트 업무ID 
    private int projectWorkId;

    // 회사 ID 
    private int companyId;

    // 프로젝트 ID 
    private int projectId;

    // 회원 ID 
    private int memberId;

    // 프로젝트 역할ID 
    private int projectRoleId;
    
    // 프로젝트업무상태 D 
    private int projectWorkStatusId;

    // 프로젝트 우선순위 ID 
    private int projectPriorityId;

    //프로젝트 업무 제목
    @NotNull
    private String projectWorkTitle;

    //프로젝트 업무 내용
    @NotNull
    private String projectWorkContent;

    //담당자
    @NotNull
    private String projectWorkPic;
    
    //작성자
    @NotNull
    private String projectWorkWriter;
    
    //프로젝트업무작성일자
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectWorkWriteDate;

    //프로젝트업무시작일자(PL이 지정해 준 일자)
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectWorkStartDate;

    //프로젝트업무종료일자(PL이 지정해 준 일자)
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectWorkEndDate;
    
    // 프로젝트 업무종료 완료일자
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectWorkFiDate;
    
    //////////// 추가 //////////////////////
    
    // 프로젝트 우선순위 색깔
    private String projectPriorityColor;
    
    // 프로젝트 상태명
    private String projectWorkStatus;
    
    // 프로젝트 우선순위명
    private String projectPriorityName;
    
    // 일감 작성자 id
    private int picId;
    
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectStartDate;
    
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectEndDate;
    
    private int totalCount;
    private int completeWorkPercentage;
    private int completeCount;
    private int stayCount;
    private int feedCount;
    private int startedCount;
    private int requestCount;
    
    // 개인별 전체 일감
    private int workCount;
    // 개인 일감중 완료일감
    private int completeWorkCount;
    // 개인 일감 백분율
    private int completePercentage;
    
  
}
