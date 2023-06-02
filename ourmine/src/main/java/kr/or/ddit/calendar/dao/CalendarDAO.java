package kr.or.ddit.calendar.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.calendar.vo.CalendarVO;
import kr.or.ddit.calendar.vo.ProjectWorkVOWrapperForFullCalendar;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;


public interface CalendarDAO {
	public List<CalendarVO> getEvents();
	
	public List<ProjectAttendVO> projectMemberList(int projectId);
}
