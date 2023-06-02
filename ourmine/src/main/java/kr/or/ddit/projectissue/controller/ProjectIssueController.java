package kr.or.ddit.projectissue.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.projectAttend.service.ProjectAttendService;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectissue.dao.ProjectIssueDAO;
import kr.or.ddit.projectissue.service.ProjectIssueService;
import kr.or.ddit.projectissue.vo.ProjectIssueVO;
import kr.or.ddit.vo.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/company/{companyId}/project/{projectId}/projectIssue")
@RequiredArgsConstructor
public class ProjectIssueController {
	
	
	private final ProjectIssueService service;
	private final ProjectAttendService projectAttendService;
	private final MemberService memberService;
	private final ProjectIssueDAO dao;

	//이슈로가는거
	@GetMapping()
	public String issue(@PathVariable int projectId, @PathVariable int companyId, Model model) {
		model.addAttribute("projectId",projectId);
		model.addAttribute("companyId",companyId);
		
		return "project/projectIssue/projectIssueList";
	}
	
	@GetMapping(value="issueListBottom")
	@ResponseBody
	public List<ProjectIssueVO> issueListBottom(int projectId ){
		 List<ProjectIssueVO> issueVO = service.projectIssueListBottom(projectId);
		 issueVO.forEach(issue -> {
			Optional.ofNullable(issue.getMemberImageFileRoute())
					.filter(fileRoute -> {
						Path path = Paths.get(fileRoute);
						return Files.exists(path);
					})
					.ifPresent(fileRoute -> {
						try {
							String filePathName = issue.getMemberImageFileRoute();
							String fileExtName = issue.getFileExtension();
							Path path = Paths.get(fileRoute);
							byte[] fileArray = Files.readAllBytes(path);
							String encodedString = Base64.getEncoder().encodeToString(fileArray);
							String changeString = "data:image/" + fileExtName + ";base64, " + encodedString;
							log.info("changeString = {}", changeString);
							issue.setImageContents(changeString);
						} catch (IOException e) {
							e.printStackTrace();
						}
					});
		});
		return issueVO;
	}
	
	// 이슈 목록 LIST
	@GetMapping("/issueList")
	@ResponseBody
	public List<Page> issueList(@PathVariable int projectId , @PathVariable int companyId, Authentication user
			,@RequestParam(required = false) String search
			, @RequestParam(value = "page", defaultValue = "1") int page
		    , @RequestParam(value = "size", defaultValue = "5") int size
	){
		Page pvo = new Page();
		pvo.setProjectId(projectId);
		if(search != null) {
			pvo.setSearch(search);
		}
		MemberVOWrapper mVOW = (MemberVOWrapper) user.getPrincipal();
		ProjectAttendVO paVO = new ProjectAttendVO();
		paVO.setProjectId(projectId);
		
		paVO.setMemberId(mVOW.getRealUser().getMemberId());
		int proRoleId = projectAttendService.projectRoleIdSelect(paVO);
		log.info("proRoleId={}",proRoleId);
		
		pvo.setCurrentPage(page);
		pvo.setPageSize(size);
		pvo.setProjectRoleId(proRoleId);
		pvo.setMemberId(mVOW.getRealUser().getMemberId());
		List<Page> pageVO = dao.projectIssueList(pvo);
		log.info("pageVO={}",pageVO);
		int totalIssueData = service.totalData(projectId);
		
		
		Map<String, Object> issueData = new HashMap<>();
		issueData.put("projects", pageVO);
		issueData.put("totalProjects", totalIssueData);
		pageVO.forEach(data -> data.setTotalData(totalIssueData));
		
		
		pageVO.forEach(issue -> {
			Optional.ofNullable(issue.getMemberImageFileRoute())
					.filter(fileRoute -> {
						Path path = Paths.get(fileRoute);
						return Files.exists(path);
					})
					.ifPresent(fileRoute -> {
						try {
							String filePathName = issue.getMemberImageFileRoute();
							String fileExtName = issue.getFileExtension();
							Path path = Paths.get(fileRoute);
							byte[] fileArray = Files.readAllBytes(path);
							String encodedString = Base64.getEncoder().encodeToString(fileArray);
							String changeString = "data:image/" + fileExtName + ";base64, " + encodedString;
							log.info("changeString = {}", changeString);
							issue.setImageContents(changeString);
							issue.setProjectRoleId(proRoleId);
						} catch (IOException e) {
							e.printStackTrace();
						}
					});
		});
		return pageVO;
	}
	
	@GetMapping("/issueReceiverList")
	@ResponseBody
	public List<ProjectAttendVO> issueReceiverList(int projectId) {
		
		return service.alarmReceiverList(projectId);
	}
	
	// 해당 아이디의 이슈 상세조회
	@GetMapping("/issueView") 
	@ResponseBody
	public ProjectIssueVO issueView(@RequestParam int projectIssueId, @PathVariable int companyId, @PathVariable int projectId) {
		

		return service.projectIssueSelect(projectIssueId);
	}
	

	 // 이슈 생성
	@PostMapping(value = "/projectIssueCreate")
	@ResponseBody
	public int createIssue(
			@RequestBody ProjectIssueVO vo  
			,@PathVariable int companyId, @PathVariable int projectId, Authentication user) {
		
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		log.info("voWrapper={}", voWrapper);
		log.info("vo = {}",vo);
		int memberId = voWrapper.getRealUser().getMemberId();
		String memberName = voWrapper.getRealUser().getMemberName();
		String senderName=  voWrapper.getRealUser().getMemberName();
		vo.setMemberId(memberId);
		vo.setProjectIssueWriter(memberName);
		vo.setCompanyId(companyId);
		vo.setProjectId(projectId);
		log.info(" projectId:{}, companyId:{}, memberId={}",projectId,companyId,memberId );

		List<AssociationVO> associationVO = projectAttendService.issuePmSelect(projectId);
		ProjectAttendVO paVO = new ProjectAttendVO();
		paVO.setProjectId(projectId);
		paVO.setMemberId(memberId);
//		int i = projectAttendService.projectRoleIdSelect(paVO);
//		vo.setProjectIssuePicId(i);
//		vo.setProjectIssuePicName();
		associationVO.forEach(data -> {
			vo.setProjectIssuePicId( data.getMemberId());
			vo.setProjectIssuePicName( data.getMemberName());
			log.info("PicId={}, PicName={}",data.getMemberId(), data.getMemberName() );
		});
		
		MemberVOWrapper wrap = (MemberVOWrapper) user.getPrincipal();
		log.info("wrap.getRealUser().getMemberId()={}",wrap.getRealUser().getMemberId());
		
		ProjectIssueVO iVO = service.projectRoleSelect(vo);
		int projectRoleId = iVO.getProjectRoleId();
		vo.setProjectRoleId(projectRoleId);
		
		log.info("vo={}",vo);
		
		return service.insertProjectIssue(vo,  user);
	}

	@GetMapping(value = "/issueCode", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ProjectIssueVO> issueCode(){
		return service.projectCodeList();
	}
	
	@GetMapping(value = "/trackerCode", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ProjectIssueVO> trackerCode(){
		return service.projectTrackerList();
	}
	// 이슈 상태 수정 진행중 -> 완료
	@GetMapping("/projectIssueStatusUpdate")
	@ResponseBody
	public int projectIssueStatusUpdate(int projectIssueId) {
		return service.updateProjectIssueStatus(projectIssueId);
		
	}
	
	@PostMapping("/projectIssueComment")
	@ResponseBody
	public int projectIssueComment(@RequestBody ProjectIssueVO issueVo) {
		int cnt = service.updateProjectIssueComment(issueVo);
		int count = cnt > 0 ? cnt : 0;
		return count;
	}
	
	
	@GetMapping("/projectIssueView") // 
	public String boardView() {
		return null;
	}
	
	@PostMapping("/projectIssueView") // 
	public String boardUpdate() {
		return null;
	}
	
	@GetMapping("/projectIssueDelete") // 
	public String boardDeleteForm() {
		return null;
	}
	
	@PostMapping("/projectIssueDelete") // 
	public String boardDelete() {
		return null;
	}

	
}
