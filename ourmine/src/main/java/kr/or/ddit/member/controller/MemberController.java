package kr.or.ddit.member.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import java.util.Base64;
import java.util.Optional;

import kr.or.ddit.company.vo.CompanyVO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.ui.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
@Slf4j
public class MemberController {


	private final MemberService service;

	@Value("#{appInfo['member.attatchPath']}")
	private String uploadDir;


	@GetMapping(value = "/memberList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	// 홈페이지 관리자는 현재 등록된 회사 리스트를 볼수있게
	@ResponseBody
	public List<MemberVO> memberList(Authentication user) {
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		MemberVO memberVO = service.memberMyPageSelect(principal.getRealUser().getMemberId());
		int companyId = memberVO.getCompanyId();
		List<MemberVO> memberVOS = service.memberList(companyId);
		
		memberImageBase64(memberVOS);
		
		return memberVOS;
	}

	@GetMapping(value = "/memberOrgLvl", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	// 회원전체조회 홈페이지 관리자일 경우에는 전체조회 될수있게끔
	@ResponseBody
	public List<MemberVO> memberOrgLvl(Authentication user) {
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		int companyId = principal.getRealUser().getCompanyId();
		log.info("companyId = {}", companyId);
		MemberVO member = new MemberVO();
		member.setCompanyId(companyId);
		return service.memberOrgLvlSelect(member);
	}

	@GetMapping("/memberList") // 회원전체조회 홈페이지 관리자일 경우에는 전체조회 될수있게끔
	public String memberListUi() {

		return "admin/adminMemberList";
	}
	
	@GetMapping("/memberManagerList")
	public String memberManagerList() {
		
		return "member/Member";
	}

	@GetMapping("/memberSelect") // 회원 한명 클릭시 한명만 조회, 검색조건을 추가할시 동적쿼리 추가 홈페이지 관리자일 경우에만
	public String memberId() {
		return null;
	}

	@GetMapping("/memberJoin") // 멤버 회원가입 폼으로
	public String memberForm() {
		System.getProperty("java.class.path");
		System.out.println("출력출력");
		return "memberJoin";
	}

	@PostMapping(value = "/memberJoin", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 멤버 회원가입 완료
	@ResponseBody
	public int memberJoin(@RequestBody MemberVO member) {
		int cnt = service.insertMember(member);
		return Math.max(cnt, 0);
	}

	//
	@PostMapping(value = "/member/json", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int memberLoginCheck(@RequestBody MemberVO member) { // 이메일 중복체크
		return service.memberCheckSelect(member);
	}

	@GetMapping("/memberView") // 마이페이지로 이동
	public String memberView() {
		return "member/memberView";
	}

	@ResponseBody
	@GetMapping(value = "/memberViewJson", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 마이페이지 이동시 자기정보 가져오기
	public MemberVO memberViewJson(Authentication user) {

		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		MemberVO memberVo = service.memberMyPageSelect(principal.getRealUser().getMemberId());
		String memberName = principal.getRealUser().getMemberName();

		String filePathName = memberVo.getMemberImageFileRoute();
		String fileExtName = memberVo.getFileExtension();
		
		
		memberImageFileBase64(memberVo, filePathName, fileExtName);
		
		return memberVo;

	}
	

	
	@ResponseBody
	@PostMapping(value = "/memberUpdate", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 마이페이지에서 수정된 정보 받기
	public int memberUpdate(@ModelAttribute MemberVO member, Authentication user) {
//	public int memberUpdate(Authentication user, @RequestParam HashMap<String, Object> member, MultipartFile file) {
//	public int memberUpdate(Authentication user, @RequestParam HashMap<String, Object> member, List<MultipartFile> file) {
		log.info("member ={}", member);
		FileUtil.fileSetting(uploadDir, member);

//		member.setUploadDir(uploadDir);
		// 데이터 입력받았는지확인
		// memberService 에서 확인 file
		// 파일 경로 를 받았는지
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		member.setMemberId(principal.getRealUser().getMemberId());

		//서비스쪽으로 이동
		return service.updateMember(member, user);

	}

	@GetMapping("/memberOrgLvlListSelect")
	@ResponseBody
	public List<MemberVO> memberOrgLvlListSelect(@RequestParam int orgchartId, Authentication user) {
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		MemberVO member = new MemberVO();
		member.setCompanyId(principal.getRealUser().getCompanyId());
		member.setOrgchartId(orgchartId);
		List<MemberVO> memberVOS = service.memberOrgLvlListSelect(member);
		
		memberImageBase64(memberVOS);
		return memberVOS;
	}


	@ResponseBody
	@PostMapping(value = "/memberDelete", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	// 탈퇴 하면 Delete 하지말고 회원 상태에 Y로 update 하기
	public int memberDelete(@RequestBody MemberVO member, Authentication user) {
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		int memberId = principal.getRealUser().getMemberId();
		member.setMemberId(memberId);
		return service.deleteMember(member, user);
	}
	
	@ResponseBody
	@GetMapping( "/adminCompanyList")
	// 탈퇴 하면 Delete 하지말고 회원 상태에 Y로 update 하기
	public List<CompanyVO> adminCompanyList() {
		return service.adminCompanyList();
	}
	
	@ResponseBody
	@GetMapping(  "/adminCompanyMemberList")
	public List<MemberVO> adminCompanyMemberList(
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "6") int size,
			@RequestParam(required = false, defaultValue = "0") int companyId
	) {
		MemberVO memberVO = new MemberVO();
		if(companyId > 0 ) memberVO.setCompanyId(companyId);
		
		memberVO.setCurrentPage(page);
		memberVO.setPageSize(size);
		List<MemberVO> memberVOS = service.adminCompanyMemberList(memberVO);
		memberImageBase64(memberVOS);
		return memberVOS;
	}
	
	
	
	
	
	
	private static void memberImageFileBase64(MemberVO memberVo, String filePathName, String fileExtName) {
		Optional.ofNullable(memberVo.getMemberImageFileRoute())
				.filter(fileRoute -> {
					Path path = Paths.get(filePathName);
					return Files.exists(path);
				})
				.ifPresent(fileRoute -> {
					try {
						Path path = Paths.get(filePathName);
						byte[] fileArray = Files.readAllBytes(path);
						String encodedString = Base64.getEncoder().encodeToString(fileArray);
						String changeString = "data:image/" + fileExtName + ";base64, " + encodedString;
						log.info("changeString = {}", changeString);
						memberVo.setImageContents(changeString);
					} catch (IOException e) {
						e.printStackTrace();
					}
				});
	}
	
	
	private static void memberImageBase64(List<MemberVO> memberVOS) {
		memberVOS.forEach(memberVo -> {
			Optional.ofNullable(memberVo.getMemberImageFileRoute())
					.filter(fileRoute -> {
						Path path = Paths.get(fileRoute);
						return Files.exists(path);
					})
					.ifPresent(fileRoute -> {
						try {
							String filePathName = memberVo.getMemberImageFileRoute();
							String fileExtName = memberVo.getFileExtension();
							Path path = Paths.get(fileRoute);
							byte[] fileArray = Files.readAllBytes(path);
							String encodedString = Base64.getEncoder().encodeToString(fileArray);
							String changeString = "data:image/" + fileExtName + ";base64, " + encodedString;
							log.info("changeString = {}", changeString);
							memberVo.setImageContents(changeString);
						} catch (IOException e) {
							e.printStackTrace();
						}
					});
		});
	}
}




