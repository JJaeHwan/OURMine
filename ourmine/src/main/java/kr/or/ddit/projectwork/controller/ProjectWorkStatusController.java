package kr.or.ddit.projectwork.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.projectwork.service.ProjectWorkStatusService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projectWorkStatus")
public class ProjectWorkStatusController {
	
	
	private final ProjectWorkStatusService service;
	
	

	@GetMapping("/projectWorkStatusList") //
	public String boardList() {
		return null;
	}
	
	@GetMapping("/{projectWorkStatusId}") // 
	public String boardSelect() {
		return null;
	}
	
	@GetMapping("/projectWorkStatusForm")  // 
	public String boardForm() {
		return null;
	}
	
	@PostMapping("/projectWorkStatusForm") // 
	public String boardJoin() {
		return null;
	}

	
	@GetMapping("/projectWorkStatusView") // 
	public String boardView() {
		return null;
	}
	
	@PostMapping("/projectWorkStatusView") // 
	public String boardUpdate() {
		return null;
	}
	
	@GetMapping("/projectWorkStatusDelete") // 
	public String boardDeleteForm() {
		return null;
	}
	
	@PostMapping("/projectWorkStatusDelete") // 
	public String boardDelete() {
		return null;
	}
}
