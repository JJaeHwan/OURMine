package kr.or.ddit.alarm.vo;

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
@EqualsAndHashCode(of = "alarmId")
public class AlarmVO implements Serializable{

    public AlarmVO() {
    }

    public AlarmVO(String alarmSender) {
        this.alarmSender = alarmSender;
    }

    // 알림 ID 알림ID
    private int alarmId;

    private int projectId;

    // 프로젝트 이슈 ID 프로젝트이슈ID
    private int projectIssueId;

    //보낸사람 이름
    private String alarmSender;

    //보낸사람 아이디
    private int senderId;
    
    // 알림 내용
    private String alarmContent;

    // 알림 일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
   	@JsonFormat(shape = Shape.STRING)
    private LocalDate alarmDate;

    // 알림 삭제 여부 알림삭제여부
    private boolean alarmRemoveWhether;


    private String memberImageFileRoute;
    private String fileExtension;
    private String imageContents;
    
    // 수신자 이름
    private String alarmReceiver;

    // 수신자 아이디
    private int receiverId;
    
    // 채팅 아이디
    private int chattingId;
    
    


}
