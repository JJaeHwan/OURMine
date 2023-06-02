package kr.or.ddit.chatting.vo;

import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "chattingId")
@SuppressWarnings("serial")
public class ChatVO implements Serializable {

    // 채팅 ID 채팅ID
    private int chattingId;

    // 채팅 생성 일자 채팅생성일자
    private Date chattingCreateDate;
    
    // 채팅방 이름
    private String chattingName;
    
    ////////////// 추가 /////////////
    // 회원 ID 회원ID
    private int memberId;
    
    // 회원 채팅방 입장 시간 (어디쓰는지는 모름)
    private String chattingConnectTime;
    
    // 그룹채팅 맴버
    private List<Integer> memberList;
    
    // 채팅 내용
    private String chattingContent; 
    
    // 채팅 전송 시간
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDateTime chattingContentTime;
    
    // 맴버 이름
    private String memberName;
    
    // 개인채팅방 생성자 이름
    private String chattingMemName;
    
    // 그룹채팅인지 아닌지
    private String chattingWhtherGroup;
    
    // 개인채팅용 임시 MemberList
    private int compareMemId;


    
    


	    
	    
}
