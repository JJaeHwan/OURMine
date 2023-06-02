package kr.or.ddit.projectwork.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "projectPriorityId")
public class ProjectWorkPriorityVO implements Serializable {
	
	// 프로젝트 우선순위 ID 
    private int projectPriorityId;

    // 프로젝트 우선순위 이름 
    private String projectPriorityName;

    // 우선순위 사용유무
    private boolean priorityUse;
}
