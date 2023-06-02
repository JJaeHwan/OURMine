package kr.or.ddit.project.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

import kr.or.ddit.alarm.dao.AlarmDAO;
import kr.or.ddit.alarm.vo.AlarmVO;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "projectId")
public class ProjectVO implements Serializable {
	
	// 프로젝트 ID 프로젝트ID
    private int projectId;
    
    // 회사 ID 
    private int companyId;

    // 프로젝트 이름 프로젝트이름
    private String projectName;

    // 프로젝트 시작 일자 프로젝트시작일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectStartDate;

    // 프로젝트 종료 일자 프로젝트종료일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectEndDate;

    // 프로젝트 삭제 여부 프로젝트삭제여부
    private boolean projectRemoveWhether;

    // 프로젝트 내용 프로젝트내용
    private String projectContent;
    
    // 프로젝트 참여 인원
    private int projectAttendMemberCount;
    
    // 프로젝트별 할일 갯수 
    private int projectTodoCount;
    
    // 프로젝트 남은 일수 
    private int leftDays;
    
    //프로젝트 전체 일수 
    private int totalDay;
    
    // 프로젝트 기간
    private int leftMonths;
    
    // 프로젝트 진척도
    private int progress;
    
    // 프로젝트 진행상태
    private String projectStatusName;
    
    // 프로젝트 참여상태
    private String projectAttendStatus;
    
    //참여한 사람
    private List<ProjectAttendVO> projectMembers;

    private List<AlarmVO> projectAlarms;
}
