package kr.or.ddit.projectwork.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

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
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.alarm.service.AlarmService;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.project.service.ProjectService;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectwork.dao.ProjectWorkDAO;
import kr.or.ddit.projectwork.service.ProjectWorkService;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import kr.or.ddit.vo.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/company/{companyId}/project/{projectId}/projectWork")
public class ProjectWorkController {


	private final ProjectWorkService service;
	private final ProjectWorkDAO dao;


	/**
	 * 일감 ui 보여주기
	 * @return
	 */
	@GetMapping //
	public String projectWorkUi(@PathVariable int companyId, @PathVariable int projectId, Authentication user, Model model) {
//		MemberVOWrapper voW = (MemberVOWrapper) user.getPrincipal();
//		List<ProjectAttendVO> aVO = voW.getRealUser().getProAttendRole();
//		aVO.forEach(data -> {
//			 log.info("나재경바보", data.getProjectRoleId());
//		});
		model.addAttribute("companyId", companyId);
		model.addAttribute("projectId", projectId);

		return "project/projectWork/projectWorkList";
	}

	/**
	 * 프로젝트 일감 리스트
	 * @param projectWorkVO
	 * @return
	 */
	@GetMapping(value= "projectWorkListJson", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<Page> projectWorkListJson(//ProjectWorkVO projectWorkVO,
													@PathVariable int companyId,
													@PathVariable int projectId,
													@RequestParam(required = false) String search,
													@RequestParam(value = "page", defaultValue = "1") int page,
												    @RequestParam(value = "size", defaultValue = "5") int size

	){
		Page pvo = new Page();
		pvo.setProjectId(projectId);
		if(search != null) {
			pvo.setSearch(search);
		}
//		MemberVOWrapper mVOW = (MemberVOWrapper) user.getPrincipal();
//		ProjectAttendVO paVO = new ProjectAttendVO();
//		paVO.setProjectId(projectId);
//		paVO.setMemberId(mVOW.getRealUser().getMemberId());
//		int proRoleId = projectAttendService.projectRoleIdSelect(paVO);
//		log.info("proRoleId={}",proRoleId);

		pvo.setCurrentPage(page);
		pvo.setPageSize(size);
		pvo.setProjectId(projectId);
		pvo.setCompanyId(companyId);
//		pvo.setProjectRoleId(proRoleId);
		List<Page> pageVO = dao.projectWorkList(pvo);
		log.info("pageVO={}",pageVO);
		int totalWorkData = service.totalData(projectId);

		pageVO.forEach(memberVo -> {
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

		Map<String, Object> workData = new HashMap<>();
		workData.put("projects", pageVO);
		workData.put("totalProjects", totalWorkData);
		pageVO.forEach(data -> data.setTotalData(totalWorkData));

//		log.info("projectWorkVO:{}",service.projectWorkList(projectWorkVO));
//
//		projectWorkVO.setProjectId(projectId);
//		projectWorkVO.setCompanyId(companyId);
//
//		return service.projectWorkList(projectWorkVO);

		return pageVO;
	}

	/**
	 * 일감 등록 폼
	 * @return
	 */
	@GetMapping("projectWorkForm")  //
	public String projectWorkForm() {
		return "project/projectWork/projectWorkList";
	}

	/**
	 *
	 * 일감 등록
	 * @param projectWorkVO
	 * @param user
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="projectWorkForm", produces="application/json;charset=utf-8")
	public int insertProjectWork(@RequestBody ProjectWorkVO projectWorkVO,
								@PathVariable int companyId,
								@PathVariable int projectId,
								Authentication user
			) {
		log.info("ckkkkkkk: " + projectWorkVO);

		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		String projectWorkWriter = voWrapper.getRealUser().getMemberName();
		log.info("projectWorkWriter:{}",projectWorkWriter);
		int memberId = voWrapper.getRealUser().getMemberId();

		int pic = projectWorkVO.getPicId();
		log.info("pic@@@:{}",pic);

		projectWorkVO.setProjectWorkWriter(projectWorkWriter);
		projectWorkVO.setMemberId(memberId);
		projectWorkVO.setCompanyId(companyId);
		projectWorkVO.setProjectId(projectId);

		int projectRoleId = service.selectProjectRole(projectWorkVO);

		projectWorkVO.setProjectRoleId(projectRoleId);

		int cnt = service.insertProjectWork(projectWorkVO);

		return cnt;
	}


//	/**
//	 * 수정 폼으로
//	 * @return
//	 */
//	@GetMapping("projectWorkView") //
//	public String projectWorkView() {
//		return "project/projectWork/projectWorkList";
//	}

	/**
	 *
	 * 일감 수정
	 * @param projectWorkVO
	 * @param user
	 * @return
	 */
	@ResponseBody
	@PostMapping(value ="projectWorkView", produces="application/json;charset=utf-8") //
	public int updateProjectWork(@RequestBody ProjectWorkVO projectWorkVO,
								@PathVariable int companyId,
								@PathVariable int projectId
			) {
		log.info("@@@@@@@@@수정수정{}", projectWorkVO);
		int cnt = service.updateProjectWork(projectWorkVO);
		return cnt;
	}

//	@GetMapping("projecWorktDelete") //
//	public String boardDeleteForm() {
//		return "project/projectWork/projectWorkList";
//	}

	/**
	 * 일감 삭제
	 * @param projectWorkId
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="projecWorktDelete", produces="application/json;charset=utf-8") //
	public int projectWorkDelete(@RequestBody int projectWorkId) {



		int cnt = service.deleteProjectWork(projectWorkId);
		return cnt;
	}

	@GetMapping("projectMemberList")
	public String projectMemberListUi() {

		return "project/projectWork/projectWorkList";
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
