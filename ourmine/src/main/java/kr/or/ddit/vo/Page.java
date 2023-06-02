package kr.or.ddit.vo;

import java.time.LocalDate;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@EqualsAndHashCode(of = "projectIssueId")
public class Page {
	private int currentPage;
    private int pageSize;
    private String search;
    private int totalPage;
    private int totalData;
    private int totalWorkData;

    // 프로젝트 이슈 ID
    private int projectIssueId;

    // 프로젝트 ID 
    private int projectId;

    // 회원 ID 
    private int memberId;

    // 회사 ID 
    private int companyId;
    
    private int rnum;
    
    private int myRoleId;
    
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
    
    private String imageFileRoute;
    
    private String fileExtension;
    
    // 회원 이미지 보여줄 경로
    private String imageContents;

    // 회원 이미지 파일 경로 회원이미지파일경로
    private String memberImageFileRoute;
    
    // 이슈 확인처리 코멘트
    private String projectIssueComment;
    ////////////// 추가 /////////////////
    
    // 프로젝트 업무ID 
    private int projectWorkId;
    
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
    
    // 프로젝트 상태명
    private String projectWorkStatus;
    
    // 프로젝트 우선순위명
    private String projectPriorityName;
    
    // 일감 작성자 id
    private int picId;
    
    // 프로젝트 우선순위 색깔
    private String projectPriorityColor;
    
    // 프로젝트 시작날짜
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectStartDate;
    
    // 프로젝트 종료날짜
    @DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate projectEndDate;

    // getter, setter
    public int getCurrentPage() {
        return this.currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return this.pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}
    
    
}
