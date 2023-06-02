package kr.or.ddit.dashboard.controller;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.dashboard.service.DashboardService;
import kr.or.ddit.project.vo.ProjectVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import kr.or.ddit.projectissue.vo.ProjectIssueVO;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/company/{companyId}/project/{projectId}/dashBoard")
public class DashboardController {


	private final DashboardService service;

	@GetMapping
	public String dashboard(@PathVariable int projectId, @PathVariable int companyId, Model model) {
		model.addAttribute("projectId",projectId);
		model.addAttribute("companyId",companyId);
		return "project/dashBoard/projectDashBoard";

	}

	@PostMapping("/dashBoardJson")
	@ResponseBody
	public ProjectAttendVO dashBoardJson(@RequestBody ProjectAttendVO attendVO) {

		return service.dashboardList(attendVO);
	}

	@GetMapping("/projectData")
	@ResponseBody
	public List<ProjectVO> projectData(int projectId){
		List<ProjectVO> proData = service.projectData(projectId);
		for (ProjectVO proDatum : proData) {
			List<ProjectAttendVO> attendList = proDatum.getProjectMembers();
			attendList.forEach(issue -> {
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
		}


		return proData;
	}
	
	@GetMapping("/issueData")
	@ResponseBody
	public List<ProjectIssueVO> issueData( int projectId) {
		List<ProjectIssueVO> issueList = service.issueData(projectId);
		
		return issueList;
	}
	
	@GetMapping(value = "/workData", produces = MediaType.APPLICATION_JSON_UTF8_VALUE )
	@ResponseBody
	public ProjectWorkVO workData(int projectId) {
		
		return service.workData(projectId);
	}
	
	@GetMapping("workMemberData")
	@ResponseBody
	public List<ProjectWorkVO> workMemberData(int projectId){
		
		return service.workMemberData(projectId);
		
	}

}
