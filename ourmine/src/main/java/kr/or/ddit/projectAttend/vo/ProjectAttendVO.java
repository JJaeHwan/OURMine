package kr.or.ddit.projectAttend.vo;

import kr.or.ddit.alarm.vo.AlarmVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectAttendVO implements Serializable {
	
	// 회사ID
    private int companyId;

    // 프로젝트 ID
    private int projectId;

    // 직원ID
    private int memberId;

    // 프로젝트역할ID
    private int projectRoleId;

    // 대체키
    private int projectAttendAk;
    
    // 			ROLE_5_팀원
    private String groupRole;
    
    // 			ROLE_3_기업관리자
    private String groupGrade;
    
    ////////  추가 ////////////
    
    private String memberName;

    private List<AlarmVO> alarms;
    
    private int memberCount;
    
    private String projectName;
    
    private String projectContent;
    
    // 프로젝트 시작 일자 프로젝트시작일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectStartDate;

    // 프로젝트 종료 일자 프로젝트종료일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectEndDate;
    
	// 파일 확장자 파일확장자
	private String fileExtension;
	
	// 회원 이미지 보여줄 경로
	private String imageContents;

	// 회원 이미지 파일 경로 회원이미지파일경로
	private String memberImageFileRoute;
	
	private String projectRole;
    
}
//  ROLE_MANAGER + N  N -> X 기업관리자는 프로젝트를 생성해주기만하지 프로젝트에 들어가지 않아요 기업관리자 프로젝트역할 X 
//  ROLE_MEMBER  + N  N 이 여러개 ROLE_MEMBER_3_PROJECTLEADER, ROLE_MEMBER_4_DA