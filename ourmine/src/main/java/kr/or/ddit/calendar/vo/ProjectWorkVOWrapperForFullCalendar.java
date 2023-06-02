package kr.or.ddit.calendar.vo;

import java.time.LocalDate;

import kr.or.ddit.projectwork.vo.ProjectWorkVO;

public class ProjectWorkVOWrapperForFullCalendar implements CalendarVO {
	private ProjectWorkVO projectWork;

	public ProjectWorkVOWrapperForFullCalendar(ProjectWorkVO projectWork) {
		super();
		this.projectWork = projectWork;
	}
	// 프로젝트id
	@Override
	public int projectId() {
		return projectWork.getProjectId();
	}
	
	// 프로젝트 일감 id
	@Override
	public int projectWorkId() {
		return projectWork.getProjectWorkId();
	}
	// 일감 제목
	@Override
	public String title() {
		return projectWork.getProjectWorkTitle();
	}
	// 일감 담당자
	@Override
	public String projectWorkPic() {
		return projectWork.getProjectWorkPic();
	}
	
	// 일감 시작날짜
//	@DateTimeFormat(iso = ISO.DATE_TIME)
//	@JsonFormat(shape = Shape.STRING)
	@Override
	public LocalDate start() {
		return projectWork.getProjectWorkStartDate();
	}
	
	// 일감 종료날짜
//	@DateTimeFormat(iso = ISO.DATE_TIME)
//	@JsonFormat(shape = Shape.STRING)
	@Override
	public LocalDate end() {
		return projectWork.getProjectWorkEndDate();
	}

	@Override
	public boolean allday() {
		return false;
	}
	
	// 우선순위 색깔
	@Override
	public String color() {
		return projectWork.getProjectPriorityColor();
	}

	// 프로젝트 일감상태명
	@Override
	public String projectWorkStatus() {
		return projectWork.getProjectWorkStatus();
	}
	
	// 프로젝트 우선순위명
	@Override
	public String projectPriorityName() {
		return projectWork.getProjectPriorityName();
	}
	
	// 프로젝트 일감내용
	@Override
	public String projectWorkContent() {
		return projectWork.getProjectWorkContent();
	}

	// 프로젝트 일감 상태 id
	@Override
	public int projectWorkStatusId() {
		return projectWork.getProjectWorkStatusId();
	}
	
	// 프로젝트 우선순위 id
	@Override
	public int projectPriorityId() {
		return projectWork.getProjectPriorityId();
	}
	@Override
	public int picId() {
		return projectWork.getPicId();
	}

//	@Override
//	public Integer companyId() {
//		return projectWork.getCompanyId();
//	}
//
//	@Override
//	public Integer projectId() {
//		// TODO Auto-generated method stub
//		return projectWork.getCompanyId();
//	}
	
	

}
