package kr.or.ddit.member.vo;

import java.io.Serializable;
import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(of = "memberImageId")
public class MemberImageVO implements Serializable{
	
	
    // 회원 이미지 ID 회원이미지ID
    private int memberImageId;

    // 회원 ID 회원ID
    private int memberId;

    // 회원 이미지 파일 경로 회원이미지파일경로
    private String memberImageFileRoute;

    // 파일 크기 파일크기
    private String fileSize;

    // 파일 생성 일자 파일생성일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
  	@JsonFormat(shape = Shape.STRING)
    private LocalDate fileCreateDate;

    // 원본 파일 이름 원본파일이름
    private String originalFileName;

    // 저장 파일 이름 저장파일이름
    private String saveFileName;

    // 파일 확장자 파일확장자
    private String fileExtension;

}
