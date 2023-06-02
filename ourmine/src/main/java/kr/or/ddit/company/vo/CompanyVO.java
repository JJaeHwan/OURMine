package kr.or.ddit.company.vo;

import java.io.Serializable;
import java.time.LocalDate;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "companyId")
public class CompanyVO implements Serializable {

    // 회사 ID 회사ID
    private int companyId;



    // 회사 이름 회사이름
    @NotNull
    private String companyName;

    // 회사 주소 회사주소
    @NotNull
    private String companyAddr;

    // 회사 전화번호 회사번호
    @NotNull
    private String companyTel;


    // 회사 대표 회사대표
    private String companyCeo;

    // 회사 URL 회사URL
    @NotNull
    private String companyUrl;

    private String memberName;

    private String memberGrade;

    // 회사 삭제 여부 회사삭제여부
    private boolean companyRemoveWhether;

    // 대표가 회사를 삭제할때 비밀번호 체크를 위한 객체
    private String memberPassword;

    // 회사 검색
    private String search;

    // 회원 Id
    private int memberId;

    // 요청 상태 ID 요청상태ID
    private int requestStatusId;

    // 회사 요청 상태를 저장하는 카운트
    private int memberCount;

    private String requestStatus;
	// 구독 시작 일자 구독시작일자
	@DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
		@JsonFormat(shape = Shape.STRING)
	private LocalDate subscribeStartDate;
	
	// 구독 종료 일자 구독종료일자
	@DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
		@JsonFormat(shape = Shape.STRING)
	private LocalDate subscribeEndDate;
	
	private int subDay;
    
    


}
