package kr.or.ddit.company.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "orgchartId")
public class OrgchartVO implements Serializable {


 // 조직도 ID 조직도ID
    private int orgchartId;

    // 회사 ID 회사ID
    private int companyId;

    // 부서 이름 부서이름
    @NotNull
    private String departmentName;

    // 상급 부서 ID 상급부서ID
    private Integer seniorDepartmentId;

    // 부서 생성 일자 부서생성일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
  	@JsonFormat(shape = Shape.STRING)
    private LocalDate departmentCreateDate;

    // 부서 삭제 여부 부서삭제여부
    private String departmentRemoveWhether;


    // 회원 이름
    private String memberName;

    //회원 아이디
    private int memberId;

}
