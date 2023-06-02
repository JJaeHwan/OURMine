package kr.or.ddit.calendar.service;

import java.util.List;

import kr.or.ddit.calendar.vo.CalendarVO;
import kr.or.ddit.calendar.vo.ProjectWorkVOWrapperForFullCalendar;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;

public interface CalendarService {
	public List<CalendarVO> getEvents();
	
	public List<ProjectAttendVO> projectMemberList(int projectId);
}
