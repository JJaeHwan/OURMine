package kr.or.ddit.project.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "projectRoleId")
public class ProjectRoleVO implements Serializable {

    // 프로젝트역할D
    private int projectRoleId;

    // 프로젝트역할
    private String projectRole;

    // 프로젝트역할삭제여부
    private boolean projectRoleRemoveWhether;
}
