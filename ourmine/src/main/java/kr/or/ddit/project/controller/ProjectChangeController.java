package kr.or.ddit.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.project.service.ProjectChangeService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projectChange")
public class ProjectChangeController {
	
	private final ProjectChangeService service;
	
	@GetMapping("/projectChangeList") // 프로젝트 변경사항 리스트 조회
	public String projectChangeList() {
		return null;
	}
	
	@GetMapping("/{projectChangeId}") // 프로젝트 변경사항 한개의 정보를 조회
	public String projectChangeSelect() {
		return null;
	}
	
	@GetMapping("/projectChangeForm")  // 프로젝트 변경사항 작성폼으로
	public String projectChangeForm() {
		return null;
	}
	
	@PostMapping("/projectChangeForm") // 프로젝트 변경사항 작성 완료
	public String projectChangeJoin() {
		return null;
	}

	
	@GetMapping("/projectChangeView") // 프로젝트 수정폼으로
	public String projectChangeView() {
		return null;
	}
	
	@PostMapping("/projectChangeView") // 프로젝트 수정 완료
	public String projectChangeUpdate() {
		return null;
	}
	
	@GetMapping("/projectChangeDelete") //  프로젝트 삭제하기전에 비밀번호 같은거 체크 먼저하기
	public String projectChangeDeleteForm() {
		return null;
	}
	
	@PostMapping("/projectChangeDelete") // 삭제 하면 Delete 하지말고 삭제 유무에 Y로 update 하기
	public String projectChangeDelete() {
		return null;
	}
}
