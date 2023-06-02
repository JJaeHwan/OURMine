package kr.or.ddit.chart.vo;

import java.time.LocalDate;

import kr.or.ddit.projectwork.vo.ProjectWorkVO;

public class ProjectWorkVOWrapperForChart implements ChartVO {
	private ProjectWorkVO projectWork;
	
	
	public ProjectWorkVOWrapperForChart(ProjectWorkVO projectWork) {
		super();
		this.projectWork = projectWork;
	}

	@Override
	public String name() {
		return projectWork.getProjectWorkPic();
	}

	@Override
	public String x() {
		return projectWork.getProjectWorkTitle();
	}

	@Override
	public LocalDate start() {
		return projectWork.getProjectWorkStartDate();
	}

	@Override
	public LocalDate end() {
		return projectWork.getProjectWorkEndDate();
	}

	@Override
	public LocalDate min() {
		return projectWork.getProjectStartDate();
	}

	@Override
	public LocalDate max() {
		return projectWork.getProjectEndDate();
	}

}
