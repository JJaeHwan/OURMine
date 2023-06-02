package kr.or.ddit.member.controller;



import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import kr.or.ddit.member.service.MemberGradeService;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/memberGrade")
public class MemberGradeController {
	
	private final MemberGradeService service;

	@GetMapping("/memberGradeList") // 회원 등급 전체 조회
	public String memberGradeList() {
		return null;
	}
	
	@GetMapping("/{id}") // 회원 등급 한개 조회
	public String memberid() {
		return null;
	}

	@GetMapping("/memberGradeJoin") // 회원 등급 등록 폼으로
	public String memberGradeForm( ) {
		return ""; 
	}
	
	@PostMapping("/memberGradeJoin") // 회원 등급 작성 완료 되면 받는 주소
	public String memberGradeJoin( ) {
		return ""; 
	}
	
	@GetMapping("/memberGradeView") // 회원 등급 수정 폼으로
	public String memberView() {
		return null;
	}
	
	@PostMapping("/memberGradeDelete") // 회원등급 삭제, 삭제하기전에 비밀번호 체크하기 체크완료되면 사용유무 N으로 update 체크
	public String memberUpdate() {
		return null;
	}
	

}
