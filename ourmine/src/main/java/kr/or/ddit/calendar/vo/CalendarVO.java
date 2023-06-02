package kr.or.ddit.calendar.vo;

import java.time.LocalDate;



public interface CalendarVO {
	
	public int projectId();
	
	public int projectWorkId();
	
	public String projectWorkPic();
	
	public String title();
	
	public LocalDate start();
	
	public LocalDate end();
	
	public boolean allday();
	
	public String color();
	
	public int projectWorkStatusId();
	
	public String projectWorkStatus();
	
	public int projectPriorityId();
	
	public String projectPriorityName();
	
	public String projectWorkContent();
	
	public int picId();
	
//	public Integer companyId();
//	
//	public Integer projectId();
	
	
//	private String backgroundColor;
//	private String borderColor;
}
