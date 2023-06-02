package kr.or.ddit.calendar.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.calendar.service.CalendarService;
import kr.or.ddit.calendar.vo.CalendarVO;
import kr.or.ddit.calendar.vo.ProjectWorkVOWrapperForFullCalendar;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.projectAttend.service.ProjectAttendService;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectwork.service.ProjectWorkService;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/company/{companyId}/project/{projectId}/calendar")
@RequiredArgsConstructor
public class CalendarController {
	
	@Inject
	private ProjectWorkService service;

	//private final MemberService memberService;
	
	//private final ProjectAttendService projectAttendService;
	
	/**
	 * 캘린더 ui 보여주기 
	 *
	 * @return
	 */
	@GetMapping
	public String CalendarUi(@PathVariable int companyId, @PathVariable int projectId) {

		return "project/calendar/calendarList";
	}

	/**
	 * 캘린더 일감 리스트 조회
	 * @param projectWorkVO
	 * @return
	 */
	@GetMapping(value = "calendar_FC", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<ProjectWorkVOWrapperForFullCalendar> getList(ProjectWorkVO projectWorkVO,
															@PathVariable int companyId,
															@PathVariable int projectId
			) {
		
//		MemberVOWrapper member = (MemberVOWrapper) user.getPrincipal();
//		 String memberEmail =  member.getRealUser().getMemberEmail();
//		 
//		MemberVO memberVo =  memberService.memberSelect(memberEmail);
//		List<ProjectAttendVO> projectAttend =  memberService.getAllAttendRole(memberVo.getMemberId());
		
		
		List<ProjectWorkVO> calendarList = service.pwList(projectWorkVO);
		//log.info("유저:{}",user);
		log.info("프로젝트워크리스트:{}", calendarList);
		//log.info("프로젝트어텐드:{}",projectAttend);
		// 캘린더 일감 리스트
		List list = new ArrayList<>();
		for(ProjectWorkVO vo : calendarList) {
			Map<String, String> map = new HashMap<>();
			map.put("projectWorkId", vo.getProjectWorkId() + "");
			map.put("companyId", vo.getCompanyId() + "");
			map.put("projectId", vo.getProjectId() + "");
			map.put("title", vo.getProjectWorkTitle());
			map.put("writer",vo.getProjectWorkPic());
			map.put("start", vo.getProjectWorkStartDate()+"");
			map.put("end",vo.getProjectWorkEndDate()+"");
			map.put("color",vo.getProjectPriorityColor());
			map.put("projectWorkStatusId",vo.getProjectWorkStatusId()+"");
			map.put("projectWorkStatus",vo.getProjectWorkStatus());
			map.put("projectPriorityId",vo.getProjectPriorityId()+"");
			map.put("projectPriorityName",vo.getProjectPriorityName());
			map.put("projectWorkContent",vo.getProjectWorkContent());
			map.put("picId",vo.getPicId()+"");
//			map.put("allDay", vo.get + "");
//			map.put("textColor",vo.getTextColor());
//			map.put("backColor",vo.getBackgroundColor());
//			map.put("borderColor",vo.getBorderColor());
			list.add(map);
		}
		
		log.info("리스트:{}",list);
		return list;
	}
	/**
	 * 캘린더 일감 수정
	 * 
	 * @param vo
	 * @param model
	 * @return
	 */
	@PostMapping(value = "calendarUpdate", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int calendarUpdate(@RequestBody ProjectWorkVO vo,
							@PathVariable int companyId,
							@PathVariable int projectId
			) {
		//
		/*
		 * ProjectWorkVO proejctWork = new ProjectWorkVO();
		 * model.addAttribute("proejctWork",proejctWork);
		 */
		
		// 캘린더 일감 수정
		int cnt = service.updateProjectWork(vo);	
		return cnt;
	}
	/**
	 * 캘린더 일정 삭제
	 * 
	 * @param projectWorkId
	 * @return 
	 */
	@PostMapping(value = "calendarDelete", produces = "application/json;charset=utf-8")
	@ResponseBody
	public int calendarDelete(@RequestBody int projectWorkId) {
		
		int cnt = service.deleteProjectWork(projectWorkId);	
		return cnt;
	}
	
	/**
	 * 프로젝트별 멤버리스트
	 * @param projectId
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="projectMemberList", produces="application/json;charset=utf-8")
	public List<ProjectAttendVO> projectMemberList(@PathVariable int projectId){
		List<ProjectAttendVO> projectMemberList = service.projectMemberList(projectId);
		log.info("memberList:{}", projectMemberList.get(0));
		
		return  projectMemberList;
	}
	
	

}
