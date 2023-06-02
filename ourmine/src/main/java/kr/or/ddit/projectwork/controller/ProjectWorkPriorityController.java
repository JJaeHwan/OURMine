package kr.or.ddit.projectwork.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.project.service.ProjectService;
import kr.or.ddit.projectwork.service.ProjectWorkPriorityService;
import lombok.RequiredArgsConstructor;



@Controller
@RequiredArgsConstructor
@RequestMapping("/projectWorkPriority")
public class ProjectWorkPriorityController {
	
	private final ProjectWorkPriorityService service;
	
	
	@GetMapping("/projectWorkPriorityList") //
	public String boardList() {
		return null;
	}
	
	@GetMapping("/{projectWorkPriorityId}") // 
	public String boardSelect() {
		return null;
	}
	
	@GetMapping("/projectWorkPriorityForm")  // 
	public String boardForm() {
		return null;
	}
	
	@PostMapping("/projectWorkPriorityForm") // 
	public String boardJoin() {
		return null;
	}

	
	@GetMapping("/projectWorkPriorityView") // 
	public String boardView() {
		return null;
	}
	
	@PostMapping("/projectWorkPriorityView") // 
	public String boardUpdate() {
		return null;
	}
	
	@GetMapping("/projectWorkPriorityDelete") // 
	public String boardDeleteForm() {
		return null;
	}
	
	@PostMapping("/projectWorkPriorityDelete") // 
	public String boardDelete() {
		return null;
	}
}
