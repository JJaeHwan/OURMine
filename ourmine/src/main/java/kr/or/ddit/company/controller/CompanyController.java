package kr.or.ddit.company.controller;

import java.util.List;


import javax.inject.Inject;
import javax.inject.Named;


import kr.or.ddit.company.service.WaitingListService;
import kr.or.ddit.member.service.AssociationService;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;

import kr.or.ddit.member.vo.MemberVOWrapper;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.company.service.CompanyService;
import kr.or.ddit.company.vo.CompanyVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/company")
public class CompanyController {


	@Named("authManager")
	@Inject
	private AuthenticationManager authenticationManager;


	private final CompanyService service;
	private final MemberService memberService;
	private final WaitingListService waitingListService;
	private final AssociationService associationService;

	@GetMapping("/companyListJoin")
	public String companyListJoin() {
		return "company/companyListJoin";
	}

	@GetMapping("/companySearch")
	@ResponseBody
	public List<CompanyVO> companySearch(@RequestParam(required = false) String search,Authentication user) {
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		int memberId = principal.getRealUser().getMemberId();
		CompanyVO company = new CompanyVO();
		company.setMemberId(memberId);
		if (search != null) company.setSearch(search);
		return service.companySearch(company);
	}


	@GetMapping(value = "/companyList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<CompanyVO> companyList() {
		return service.companyList();
	}

	@GetMapping("/companyList") // 홈페이지 관리자는 현재 등록된 회사 리스트를 볼수있게
	public String companyListUi() {
		return "admin/Company";
	}


	@GetMapping("/companyForm") // 회사 등록폼으로
	public String companyForm() {
		return "company/companyForm";
	}

	@ResponseBody
	@PostMapping(value = "/companyForm", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 회사 등록 완료
	public int companyJoin(@RequestBody CompanyVO company, Authentication realUser) {
		MemberVOWrapper user = (MemberVOWrapper) realUser.getPrincipal();


		MemberVO memberVO = memberService.memberMyPageSelect(user.getRealUser().getMemberId());
		company.setCompanyCeo(memberVO.getMemberName());
		int rowcnt = service.insertCompany(company, user);

		// id, password
		String pass = String.valueOf(SecurityContextHolder.getContext().getAuthentication().getCredentials());
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user.getUsername(), pass);
		Authentication auth= authenticationManager.authenticate(token);
		SecurityContextHolder.getContext().setAuthentication(auth);
		return rowcnt;

	}

	@GetMapping("/companyView") // 회사 수정 폼으로
	public String companyView() {
		return "company/companyView";
	}

	@ResponseBody
	@PostMapping(value = "/companyViewJson", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 회사를 이미등록했는지 체크
	public CompanyVO companyViewJson(Authentication user) {
		MemberVOWrapper member = (MemberVOWrapper) user.getPrincipal();
		return service.myCompanySelect(member.getRealUser().getMemberId());
	}

	@ResponseBody
	@PostMapping(value = "/companyView", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 회사 수정 완료
	public int companyUpdate(@RequestBody CompanyVO company, Authentication user) {
		return service.updateCompany(company, user);
	}

	@GetMapping("/companyDelete") // 회사 삭제하기전에 비밀번호 같은거 체크 먼저하기
	public String companyDeleteForm() {
		return null;
	}

	@ResponseBody
	@PostMapping("/companyDelete") // 삭제 하면 Delete 하지말고 삭제 유무에 Y로 update 하기
	public String companyDelete(@RequestBody CompanyVO company, Authentication realUser) {
		MemberVOWrapper user = (MemberVOWrapper) realUser.getPrincipal();
		service.deleteCompany(company, user);
		return null;
	}

	@GetMapping("/companyMemberList")
	public String companyMemberList(){
		return "company/companyMemberList";
	}

	@GetMapping("/companyMemberListJson")
	@ResponseBody
	public List<CompanyVO> companyMemberListJson(Authentication user){
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		MemberVO member = memberService.memberMyPageSelect(principal.getRealUser().getMemberId());
		CompanyVO company = new CompanyVO();
		company.setCompanyId(member.getCompanyId());
		return service.companyMember(company);
	}

	@PostMapping("/companyMemberInsert")
	@ResponseBody
	public int companyMemberInsert(@RequestBody CompanyVO company,Authentication user){
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		MemberVO member = memberService.memberMyPageSelect(principal.getRealUser().getMemberId());
		company.setCompanyId(member.getCompanyId());
		return associationService.companyMemberInsert(company);
	}

	@PostMapping("/companyMemberRefuse")
	@ResponseBody
	public int companyMemberRefuse(@RequestBody CompanyVO company,Authentication user){
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		MemberVO member = memberService.memberMyPageSelect(principal.getRealUser().getMemberId());
		company.setCompanyId(member.getCompanyId());
		return waitingListService.updateMemberRefuse(company);
	}
}
