package kr.or.ddit.calendar.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.calendar.vo.CalendarVO;
import kr.or.ddit.calendar.vo.ProjectWorkVOWrapperForFullCalendar;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectwork.dao.ProjectWorkDAO;

@Repository("calendarDao")
public class CalendarDAOImpl implements CalendarDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private ProjectWorkDAO projectWorkDao;
	

	@Override
	public List<CalendarVO> getEvents() {
		return  sqlSession.selectList("kr.or.ddit.calendar.dao.CalendarDAO.getEvents");
	}


	@Override
	public List<ProjectAttendVO> projectMemberList(int projectId) {
		return projectWorkDao.projectMemberList(projectId);
	}

}
