package kr.or.ddit.projectissue.vo;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "trackerId")
public class TrackerVO {
	
	// 트래커 기본키
	private int trackerId;
	
	// 이슈 타입 이름 (결함/수정/이벤트)
	private String trackerName;
	
	private String issueTitle;
	
	private String timeAgo;
}
