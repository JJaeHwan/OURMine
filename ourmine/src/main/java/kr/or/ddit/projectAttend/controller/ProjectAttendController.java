package kr.or.ddit.projectAttend.controller;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.noticeBoard.service.NoticeBoardService;
import kr.or.ddit.projectAttend.service.ProjectAttendService;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/company/{companyId}/projectAttend")
public class ProjectAttendController {
	private final ProjectAttendService service;

	// 전부 비동기 처리할 예정이라 @ResponseBody , @RequestBody 적절히 사용해야함 !!
	@PostMapping(value = "/projectAttendDelete", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int projectAttendDelete(@RequestBody ProjectAttendVO vo, @PathVariable int companyId) {
		log.info("vo={}", vo);
		return	service.deleteProjectAttend(vo.getProjectAttendAk());
	}
	
	@PostMapping(value = "/projectAttendInsert", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int projectAttendInsert(@RequestBody ProjectAttendVO vo, @PathVariable int companyId){

		return service.insertProjectAttend(vo);
	}
	
}
