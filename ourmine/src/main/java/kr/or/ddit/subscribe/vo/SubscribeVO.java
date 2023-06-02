package kr.or.ddit.subscribe.vo;

import java.io.Serializable;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "subscribeId")
public class SubscribeVO implements Serializable{
	
	// 구독 ID 구독ID
    private String subscribeId;

    // 회원 ID 회원ID
    private int memberId;

    // 상품 ID 상품ID
    private int itemId;

    // 구독 시작 일자 구독시작일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate subscribeStartDate;

    // 구독 종료 일자 구독종료일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate subscribeEndDate;

    // 구독 사용유무 구독사용유무
    private boolean subscribeUse;
    
    // 구독 유일 ID 값 저장
    private String subscribeUmpId;
    
    // 구독 날짜 계산을 위한 int 값
    private int subDuration;
}
