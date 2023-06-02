package kr.or.ddit.member.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class AssociationVO implements Serializable{

   // 회원 ID 직원ID
    private int memberId;

    // 회사 ID 회사이름
    private int companyId;

    // 조직도 ID 조직도ID
    private int orgchartId;

    // 소속 입사 일자 소속일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
    @JsonFormat(shape = Shape.STRING)
    private LocalDateTime associationJoinDate;

    // 소속 퇴사 일자 소속퇴사일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
    @JsonFormat(shape = Shape.STRING)
    private LocalDateTime associationLeaveDate;

    // 소속 퇴사 여부 소속퇴사여부
    private boolean associationLeaveWhether;

    // 회원이름
    private String memberName;

    // 회원 이메일
    private String memberEmail;

    // 프로젝트참여상태
    private String projectAttendStatus;

    // 프로젝트 아이디
    private int projectId;

    // 프로젝트 롤아이디
    private int projectRoleId;

    //attend 대체키
    private int  projectAttendAk;

    // 회원 등급 아이디
    private int memberGradeId;

    private String memberImageFileRoute;

    private String fileExtension;

    private String imageContents;
    
    private int selfProjectRoleId;
}
