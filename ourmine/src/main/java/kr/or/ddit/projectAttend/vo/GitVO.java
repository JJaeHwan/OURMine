package kr.or.ddit.projectAttend.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class GitVO implements Serializable {
	 // GIT ID 깃아이디
    private int gitId;

    // 프로젝트 ID 프로젝트 ID
    private int projectId;

    // 회원 ID 회원ID
    private int memberId;

    // GIT URL GITURL
    private String gitUrl;



    private String commitDate;

    // GIT URL 삭제 여부
    private String gitUrlRemoveWhether;

    private String memberName;
    private int companyId;
    private String  branchName;
    private String branchFrom;
    private String mergeInto;
    private String mergeBranchName;

    private int isMerged;
    private int commitSequence;

    private String commitMessage;

    private int commitPercent;

    private String imageContents;

	private String memberImageFileRoute;
	private String fileExtension;

	private String errorBranch;

	private int commitCount;

	// 깃허브 유저네임
	private String username;

	// 깃허브 리포지토리
	private List<String> repositories;



}
