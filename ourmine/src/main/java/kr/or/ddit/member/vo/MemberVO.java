package kr.or.ddit.member.vo;

import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.Setter;

//그룹 추가

@Data
@AllArgsConstructor()
@NoArgsConstructor()
@EqualsAndHashCode(of = "memberId")
@SuppressWarnings("serial")
public class MemberVO implements Serializable {


	@Value("#{appInfo['member.attatchPath']}")
	private String uploadDir;



	// 회원 ID 직원ID
	private int memberId;

	// 회원 등급 ID 직원등급 외래키
	private int memberGradeId;

	// 회원 등급
	private String memberGrade;

	// 회원 번호 직원번호
	// @NotNull
	private String memberTel;

	// 회원 이름 직원이름
	// @NotNull
	private String memberName;

    private int companyId;

	// 회원 이메일 직원이메일
	// @NotNull
	// @Email
	private String memberEmail;


	// 구독 회원의 구독 남은 일자
	private int subscribeDate;

	// 모든걸 뽑을 수 있는 쿼리문을 작성함.


    // 모든걸 뽑을 수 있는 쿼리문을 작성함.
    // VO에서 HAS MANY 관계로 한번에 끝낸다 ?

    private List<ProjectAttendVO> proAttendRole;

    // 회원 비밀번호 직원비밀번호
  //  @NotNull
    private String memberPassword;



    private int projectRoleId;

	// 회사 대표 회사대표
	private String companyCeo;


	// 회원 탈퇴 여부 회원탈퇴여부
	private boolean memberSecessionWhether;

	// file vo 객체
	private MultipartFile file;

	private String companyName;

	private String departmentName;

	// 원본 파일 이름 원본파일이름
	private String originalFileName;

	// 저장 파일 이름 저장파일이름
	private String saveFileName;

	// 파일 확장자 파일확장자
	private String fileExtension;
	
	// 회원 이미지 보여줄 경로
	private String imageContents;

	// 회원 이미지 파일 경로 회원이미지파일경로
	private String memberImageFileRoute;

	////추가////
	// 조직도 ID
	private int orgchartId;

	private int  seniorDepartmentId;

	private int lvl;
	
    private int currentPage;
    
    private int pageSize;
    
    private int totalData;
    

}
