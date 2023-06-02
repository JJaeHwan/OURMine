package kr.or.ddit.chart.vo;

import java.time.LocalDate;

public interface ChartVO {
	
	public String name();
	
	public String x();
	
	public LocalDate start();
	
	public LocalDate end();
	
	public LocalDate min();
	
	public LocalDate max();
	
	
}
