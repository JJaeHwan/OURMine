package kr.or.ddit.board.vo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "replyId")
public class BoardReplyVO implements Serializable {
	
	//프로젝트게시판댓글ID
    private int replyId;

    //프로젝트게시판ID
    private int boardId;

    //  프로젝트댓글 작성자
    private String replyWriter;

    // 프로젝트댓글 내용 
    private String replyContent;

    //프로젝트댓글작성일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate replyWriteDate;

    //프로젝트댓글수정일자
    @DateTimeFormat(iso = ISO.DATE_TIME)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
    private LocalDate replyModifyDate;
    
    
    /////////////// 추가 ////////////////
    
    //  프로젝트댓글 작성자ID
    private int replyWriterId;
}
