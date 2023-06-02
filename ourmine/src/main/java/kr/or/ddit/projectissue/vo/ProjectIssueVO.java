package kr.or.ddit.projectissue.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import kr.or.ddit.alarm.vo.AlarmVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "projectIssueId")
public class ProjectIssueVO implements Serializable{
	
	

    // 프로젝트 이슈 ID
    private int projectIssueId;

    // 프로젝트 ID 
    private int projectId;

    // 회원 ID 
    private int memberId;

    // 회사 ID 
    private int companyId;
    
    private int rnum;
    private String search;

    // 프로젝트 역할 ID
    private int projectRoleId;

    // 프로젝트 이슈 코드 ID 
    private int projectIssueCodeId;
    
    // 이슈작성자 이름
    private String projectIssueWriter;
    
    // 트래커 아이디
    private int trackerId;
    private String trackerName;
    
    //프로젝트 이슈 처리상태
    private int projectStatusId;
    
    //이슈 제목
    private String issueTitle;
    
    // 이슈 내용 이슈내용
    @NotNull
    private String issueContent;
    
    //프로젝트 이슈 처리상태이름
    private String projectStatusName;
    
    // 이슈 발생 일자 
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate issueEventDate;

    // 처리 완료 여부 
    @NotNull
    private String processFiWhether;

    // 처리 예상 일자 
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate processEtDate;

    // 이슈 삭제 여부 이슈삭제여부
    private boolean issueRemoveWhether;

    // 프로젝트 이슈 작성 일자 프로젝트이슈작성일자
    private LocalDate projectIssueWriteDate;

    // 프로젝트 이슈 수정 일자 프로젝트이슈수정일자
    private LocalDate projectIssueModifyDate;
    
    // 프로젝트 이슈 상태 이름 
    private String projectIssueCodeName;
    
    // 이슈 담당자 (해당프로젝트 PM의 MEMID)
    private int projectIssuePicId;
    
    // 이슈 담당자 이름 (해당프로젝트 PM의 MEMNAME)
    private String projectIssuePicName;
    
    private String issueCodeUse;
    
    private List<AlarmVO> alarms;
    
    private String imageFileRoute;
    
    private String fileExtension;
    
    // 회원 이미지 보여줄 경로
    private String imageContents;

    // 회원 이미지 파일 경로 회원이미지파일경로
    private String memberImageFileRoute;
    
    // 이슈 확인처리 코멘트
    private String projectIssueComment;
    
    private int totalIssueCount;
    private int completeIssueCount;
    private int completeIssuePercentage;
    private int highStatusCount;
    private int midStatusCount;
    private int lowStatusCount;
    private String timeAgo;
    
    private List<TrackerVO> trackerList;
    
    
    
    
    
}
