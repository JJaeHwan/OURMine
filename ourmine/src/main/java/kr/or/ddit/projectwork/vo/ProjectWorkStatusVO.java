package kr.or.ddit.projectwork.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "projectWorkStatusId")
public class ProjectWorkStatusVO implements Serializable {
	
	//프로젝트업무상태ID
    private int projectWorkStatusId;

    //프로젝트업무상태
    private String projectWorkStatus;

    //업무상태사용유무
    private boolean workStatusUse;

}
