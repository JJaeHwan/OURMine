package kr.or.ddit.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.project.service.ProjectRoleService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/projectRole")
public class ProjectRoleController {
	
	private final ProjectRoleService service;
	
	
	@GetMapping("/projectList") // 프로젝트 역활 전체 리스트
	public String projectRoleList() {
		return null;
	}
	
	@GetMapping("/{projectId}") // 프로젝트 역활 한개조회 
	public String projectRoleSelect() {
		return null;
	}
	
	@GetMapping("/projectForm")  //
	public String projectRoleForm() {
		return null;
	}
	
	@PostMapping("/projectForm") // 
	public String projectRoleJoin() {
		return null;
	}
	
	@GetMapping("/projectView") //
	public String projectRoleView() {
		return null;
	}
	
	@PostMapping("/projectView") //
	public String projectRoleUpdate() {
		return null;
	}
	
	@GetMapping("/projectDelete") // 
	public String projectRoleDeleteForm() {
		return null;
	}
	
	@PostMapping("/projectDelete") // 
	public String projectRoleDelete() {
		return null;
	}
}
