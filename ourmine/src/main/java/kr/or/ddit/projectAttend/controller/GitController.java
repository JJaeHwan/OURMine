package kr.or.ddit.projectAttend.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.eclipse.jgit.api.Git;
import org.eclipse.jgit.lib.Repository;
import org.eclipse.jgit.revwalk.RevCommit;
import org.eclipse.jgit.storage.file.FileRepositoryBuilder;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GHUser;
import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.projectAttend.service.GitService;
import kr.or.ddit.projectAttend.vo.GitVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/company/{companyId}/project/{projectId}/git")
@RequiredArgsConstructor
public class GitController {

	private final GitService service;


	@GetMapping("/gitList") //
	public String gitList(@PathVariable int companyId, @PathVariable int projectId, Model model) {
		model.addAttribute("projectId", projectId);
		model.addAttribute("companyId", companyId);
		return "project/git/gitList";
	}


	@GetMapping(value = "/gitListJson", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)  //
	@ResponseBody
	public List<GitVO> gitListJson(@PathVariable int companyId, @PathVariable int projectId) {
		GitVO gitVO = new GitVO();
		gitVO.setProjectId(projectId);
		gitVO.setCompanyId(companyId);
		return getGitVOS(service.gitList(gitVO));
	}

	@GetMapping("/gitCommitCount")
	@ResponseBody
	public List<GitVO> gitCommitCount(@PathVariable int companyId, @PathVariable int projectId) {
		GitVO gitVO = new GitVO();
		gitVO.setProjectId(projectId);
		return service.gitCommitCount(gitVO);
	}

	@GetMapping("/gitMemberCommitSelect")
	@ResponseBody
	public List<GitVO> gitMemberCommitSelect(@PathVariable int companyId, @PathVariable int projectId) {
		GitVO gitVO = new GitVO();
		gitVO.setProjectId(projectId);
		List<GitVO> gitVOS = getGitVOS(service.gitMemberCommitSelect(gitVO));
		 memberFileImage(gitVOS);
		return gitVOS;
	}

	// 깃허브
	@GetMapping("/gitHub")
	public GitVO  gitHub(@PathVariable int companyId, @PathVariable int projectId) throws IOException {
		  GitHub github = new GitHubBuilder().withOAuthToken("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").build();
		    GHUser user = github.getUser("GitHub_Username");
		    GitVO gitVO = new GitVO();
		    gitVO.setUsername(user.getName());
		    List<String> repositories = new ArrayList<>();
		    for (GHRepository repo : user.getRepositories().values()) {
		        repositories.add(repo.getName());
		    }
		    gitVO.setRepositories(repositories);
		    return gitVO;
	}

	// J git
	@GetMapping("/gitCommits")
	@ResponseBody
		public List<String> getCommits() {
	        List<String> commits = new ArrayList<>();
	        try {
	            FileRepositoryBuilder builder = new FileRepositoryBuilder();
	            Repository repository = builder.setGitDir(new File("/path/to/your/.git"))
	                    .readEnvironment() // scan environment GIT_* variables
	                    .findGitDir() // scan up the file system tree
	                    .build();

	            Iterable<RevCommit> logs = new Git(repository).log().call();
	            for (RevCommit rev : logs) {
	                commits.add(rev.getName());
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return commits;
	    }














	// 회원 이미지 base 64로 변환
	private static void memberFileImage(List<GitVO> gitVOS) {
		gitVOS.forEach(memberVo -> {
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
							memberVo.setImageContents(changeString);
						} catch (IOException e) {
							e.printStackTrace();
						}
					});
		});
	}


	// 2023-04-17-0000을 2023-04-17으로 바꾸는 메소드
	private List<GitVO> getGitVOS(List<GitVO> gitList) {
		DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
		DateTimeFormatter outputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return gitList.stream()
				.peek(vo -> {
					LocalDateTime date = LocalDateTime.parse(vo.getCommitDate(), inputFormat);
					vo.setCommitDate(date.format(outputFormat));
				}).collect(Collectors.toList());
	}

}
