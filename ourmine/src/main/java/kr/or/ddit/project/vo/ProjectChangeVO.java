package kr.or.ddit.project.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class ProjectChangeVO implements Serializable {
	
	// 프로젝트 변경사항 ID 
    private int projectChangesId;

    // 프로젝트 ID 
    private int projectId;

    // 프로젝트 내용 
    private String projectContent;
}
