package kr.or.ddit.project.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.mail.imap.protocol.Item;

import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.project.service.ProjectService;
import kr.or.ddit.project.vo.ProjectVO;
import kr.or.ddit.projectAttend.service.ProjectAttendService;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/company/{companyId}/project")
public class ProjectController {

	private final ProjectService service;
	private final MemberService memberService;
	private final ProjectAttendService projectAttendService;

	@GetMapping("/projectList")
	public String projectList(@PathVariable int companyId, Model model) {
		log.info("companyId = {}", companyId);
		model.addAttribute("companyId", companyId);
		return "manager/ProjectList";
	}
	// 프로젝트 전체 리스트 조회
	@GetMapping(value = "/projectListJson", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ProjectVO> projectListJson(Authentication user) {
		MemberVOWrapper voWrap = (MemberVOWrapper) user.getPrincipal();
		MemberVO mVO = memberService.memberMyPageSelect(voWrap.getRealUser().getMemberId());
		
		return   service.projectList(user, mVO);
		
	}

	
	// 프로젝트 멤버 리스트 조회
	@GetMapping(value = "/projectMemberJson", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<AssociationVO> projectMemberJson(Authentication user ,@PathVariable int companyId) {
		return service.projectMemberList(companyId);
	}
	
	// 프로젝트 한개의 정보를 조회
	@GetMapping("/{projectId}/home") 
	public String projectSelect(@PathVariable int projectId, @PathVariable int companyId, Model model) {
		log.info("projectId= {}",projectId);

		model.addAttribute("projectId",projectId);
		model.addAttribute("companyId",companyId);
		return "project/projectHome";
	}

	// 프로젝트 인서트 될때 attend로 PL도 같이 지정되어 인서트 되어야 함 + 알림테이블에도 저장되어야함
	@PostMapping(value = "/projectInsert", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int projectInsert(@RequestBody ProjectVO vo, Authentication user, @PathVariable int companyId) {
		vo.setCompanyId(companyId);
		return service.insertProject(vo, user);
		
	}

	@GetMapping("/projectView") // 프로젝트 수정폼으로
	public String projectView() {
		return null;
	}

	@PostMapping(value = "/projectView", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 프로젝트 수정 완료
	@ResponseBody
	public int projectUpdate(@RequestBody ProjectVO project) {
		int cnt = service.updateProject(project);
		int count = cnt > 0 ? cnt : 0;
		return count;

	}

	@GetMapping("/projectDelete") // 프로젝트 삭제하기전에 비밀번호 같은거 체크 먼저하기
	public String projectDeleteForm() {
		return null;
	}

	@PostMapping(value = "/projectDelete", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 삭제 하면 Delete 하지말고 삭제 유무에 Y로 update 하기
	@ResponseBody
	public int projectDelete(@RequestBody ProjectVO project) {
		int cnt = service.deleteProject(project.getProjectId());

		return Math.max(cnt, 0);
	}
}
