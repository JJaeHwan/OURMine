package kr.or.ddit.projecttodolist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.projecttodolist.service.ProjectTodoListService;
import kr.or.ddit.projecttodolist.vo.ProjectTodoListVO;
import kr.or.ddit.projectwork.dao.ProjectWorkDAO;
import kr.or.ddit.projectwork.service.ProjectWorkService;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import kr.or.ddit.vo.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/company/{companyId}/project/{projectId}/projectTodoList")
public class ProjectTodoListController {
	
	private final ProjectTodoListService service;
	private final ProjectWorkService pwService;
	private final ProjectWorkDAO pwDao;
	
	// 나의 일감 조회
	@GetMapping
	public String projectWorkUI(@PathVariable int companyId, @PathVariable int projectId, Authentication user, Model model) {
		model.addAttribute("companyId", companyId);
		model.addAttribute("projectId", projectId);
		return "project/projectTodo/projectTodoList";
	}

	@ResponseBody
	@GetMapping(value = "/projectWorkList", produces = "application/json;charset=UTF-8")
	public List<Page> projectWorkList(
				@PathVariable int companyId,
				@PathVariable int projectId,
				@RequestParam(required = false) String search,
				@RequestParam(value = "page", defaultValue = "1") int page,
			    @RequestParam(value = "size", defaultValue = "5") int size
				, Authentication user
	){	
		Page pvo = new Page();
		pvo.setProjectId(projectId);
		if(search != null) {
			pvo.setSearch(search);
		}
		
		pvo.setCurrentPage(page);
		pvo.setPageSize(size);
		pvo.setProjectId(projectId);
		pvo.setCompanyId(companyId);
		
		MemberVOWrapper realUser =  (MemberVOWrapper) user.getPrincipal();
		pvo.setPicId(realUser.getRealUser().getMemberId());
		log.info("picId : {}", pvo.getPicId());
		
		List<Page> pageVO = pwDao.projectTodoWorkList(pvo);
		log.info("pageVO : {}", pageVO);
		
		int totalWorkData = pwService.totalWorkData(pvo);
		log.info("@@totalWorkData : {}", totalWorkData);
		
		Map<String, Object> workData = new HashMap<>();
		workData.put("projects", pageVO);
		workData.put("totalProjects", totalWorkData);
		pageVO.forEach(data -> data.setTotalWorkData(totalWorkData));
		
		log.info("일감VO: {}", pwService.projectTodoWorkList(pvo));
		
		return pageVO;
	}
	
	// 일감별 todoList
	@ResponseBody
	@GetMapping("/todoList")
	public List<ProjectTodoListVO> projecTodoList(
			@RequestParam int projectWorkId
			, @PathVariable int companyId
			, @PathVariable int projectId
			, Authentication user, Model model
	) {
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		String memberName = voWrapper.getRealUser().getMemberName();
		
		model.addAttribute("memberName", memberName);
		
		return service.projectTodoList(projectWorkId);
	}
	
	// todo 등록
	@ResponseBody
	@PostMapping(value = "/projectTodoListForm", produces = "application/json;charset=UTF-8")
	public String projectTodoListJoin(
			@RequestBody ProjectTodoListVO projectTodoListVO
			, @PathVariable int companyId
			, @PathVariable int projectId
			, Authentication user, Model model
	) {
		log.info("ProjectTodoListVO 확인 : {}", projectTodoListVO);
		
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		String memberName = voWrapper.getRealUser().getMemberName();
		
		projectTodoListVO.setMemberName(memberName);
		model.addAttribute("memberName", memberName);
		
		int cnt = service.insertrProjectTodoList(projectTodoListVO);
		int count = cnt > 0 ? cnt : 0;
		return Integer.toString(count);
	}

	// todo 완료여부
	// 완료
	@ResponseBody
	@PostMapping(value = "/projecTodoListComplete", produces = "application/json;charset=UTF-8") 
	public String projecTodoListComplete(@RequestBody int todoId) {
		int cnt = service.completeProjectTodoList(todoId);
		int count = cnt > 0 ? cnt : 0;
		return Integer.toString(count);
	}

	// 미완
	@ResponseBody
	@PostMapping(value = "/projecTodoListReturn", produces = "application/json;charset=UTF-8") 
	public String projecTodoListReturn(@RequestBody int todoId) {
		int cnt = service.returnProjectTodoList(todoId);
		int count = cnt > 0 ? cnt : 0;
		return Integer.toString(count);
	}
	
	// todo 삭제
	@ResponseBody
	@PostMapping(value = "/projectTodoListDelete", produces = "application/json;charset=UTF-8") 
	public String projecTodoListDelete(@RequestBody int todoId) {
		int cnt = service.deleteProjectTodoList(todoId);
		int count = cnt > 0 ? cnt : 0;
		return Integer.toString(count);
	}

	// todo 완료에 따른 일감 상태 변경
	@ResponseBody
	@PostMapping(value = "/updateStatus", produces = "application/json;charset=UTF-8")
	public String updateStatus(@RequestBody int projectWorkId) {
		int cnt = pwService.updateStatus(projectWorkId);
		int count = cnt > 0 ? cnt : 0;
		return Integer.toString(count);
	}
}
