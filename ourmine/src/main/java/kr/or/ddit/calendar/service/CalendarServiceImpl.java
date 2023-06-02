package kr.or.ddit.calendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.calendar.dao.CalendarDAO;
import kr.or.ddit.calendar.vo.CalendarVO;
import kr.or.ddit.calendar.vo.ProjectWorkVOWrapperForFullCalendar;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectwork.dao.ProjectWorkDAO;

@Service
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	private CalendarDAO calenDao;
	
	@Autowired
	private ProjectWorkDAO projectWorkDao;
	
	@Override
	public List<CalendarVO> getEvents() {
		return calenDao.getEvents();
	}

	@Override
	public List<ProjectAttendVO> projectMemberList(int projectId) {
		return projectWorkDao.projectMemberList(projectId);
	}

}
