package kr.or.ddit.dashboard.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "dashboardId")
public class DashboardVO implements Serializable{
	
	

    // 대시보드 ID 대쉬보드ID
    private int dashboardId;

    // 프로젝트 업무 ID 프로젝트업무ID
    private int projectWorkId;

    // 기간별 통계 기간별통계
    private int periodSss;

    // 업무 통계 업무통계
    private int workSss;
    
}
