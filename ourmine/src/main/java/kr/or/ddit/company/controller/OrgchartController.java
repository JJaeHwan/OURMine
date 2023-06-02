package kr.or.ddit.company.controller;

import kr.or.ddit.company.vo.OrgchartVO;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.company.service.OrgchartService;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Optional;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/company/{companyId}/orgchart")
public class OrgchartController {
	
	private final OrgchartService service;
	private final MemberService memberService;
	
	
	@GetMapping("/orgchartList") // 조직도 jsp 보내기
	public String orgchartList(@PathVariable int companyId, Model model){
		model.addAttribute("companyId",companyId);
		return "orgchart/orgchartList";
	}
	
	@GetMapping("/orgchartListJson") // 회사 전체 조직도 조회
	@ResponseBody
	public List<OrgchartVO> orgchartListJson(Authentication user) {
		MemberVOWrapper realUser = (MemberVOWrapper) user.getPrincipal();
		return service.orgchartList(realUser.getRealUser().getMemberId());
}
	
	// 부서를 클릭하면 소속된 직원들이 나옴
	@PostMapping(value = "/orgchartMemberListJson",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<OrgchartVO> orgchartMemberListJson(@RequestBody OrgchartVO orgchart,@PathVariable int companyId){
		orgchart.setCompanyId(companyId);
		List<OrgchartVO> orgchartVOS = service.orgchartMemberList(orgchart);
		log.info("orgchartVOS = {}",orgchartVOS);
		return orgchartVOS;
	}
	
	// 부서에 직원을 추가
	@GetMapping("/orgchartAddMemberListJson")
	@ResponseBody
	public List<OrgchartVO> orgchartAddMemberListJson(@PathVariable int companyId,Authentication user){
		OrgchartVO orgchart = new OrgchartVO();
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		MemberVO memberVO = memberService.memberMyPageSelect(principal.getRealUser().getMemberId());
		orgchart.setCompanyId(memberVO.getCompanyId());
		return service.orgchartAddMemberList(orgchart);
	}
	
	// 직원을 부서에 추가
	@PostMapping("/orgchartMember")
	@ResponseBody
	public int orgchartMember(@RequestBody OrgchartVO orgchart){
		return service.orgchartMemberInsert(orgchart);
	}
	
	
	@PostMapping("/orgchartInsert") // 조직도 작성 완료
	@ResponseBody
	public int orgchartInsert(@RequestBody OrgchartVO orgchart,Authentication user) {
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		
		MemberVO memberVO = memberService.memberMyPageSelect(principal.getRealUser().getMemberId());
		orgchart.setCompanyId(memberVO.getCompanyId());
		
		int mId = principal.getRealUser().getMemberId();
		MemberVO mVO = memberService.memberMyPageSelect(mId);
		orgchart.setCompanyId(mVO.getCompanyId());
		
		log.info("orgchart = {}",orgchart);
		
		return service.insertOrgchart(orgchart);
	}
	
	
	@ResponseBody
	@PostMapping(value = "/orgchartUpdate",produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 조직도 수정 완료
	public int orgchartUpdate(@RequestBody OrgchartVO orgchart) {
		
		return service.updateOrgchart(orgchart);
	}
	
	@ResponseBody
	@PostMapping("/orgchartDelete") //  조직도 삭제하기전에 비밀번호 같은거 체크 먼저하기
	public int orgchartDelete(@RequestBody OrgchartVO orgchart, Authentication user ) {
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		int mId = principal.getRealUser().getMemberId();
		MemberVO mVO = memberService.memberMyPageSelect(mId);
		orgchart.setCompanyId(mVO.getCompanyId());
		return service.deleteOrgchart(orgchart);
	}

	
	@GetMapping("/orgchartTreeJson")
	@ResponseBody
	public List<OrgchartVO> orgchartTreeJson( Authentication user){
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		return service.orgchartList(principal.getRealUser().getMemberId());
	}
	
	
}
