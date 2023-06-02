package kr.or.ddit.codeWall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.print.attribute.standard.Media;

import org.springframework.beans.factory.annotation.Autowired;
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

import kr.or.ddit.codeEditor.ApiKeyProvider;
import kr.or.ddit.codeWall.service.CodeWallService;
import kr.or.ddit.codeWall.vo.CodeWallVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.noticeBoard.vo.NoticeBoardVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/company/{companyId}/project/{projectId}/codeWall")
public class CodeWallController {
	
	@Autowired
	private ApiKeyProvider apiKeyProvider;
	
	@Inject
	private CodeWallService service;
	
	
	@RequestMapping()
	public String codeWallList( @PathVariable("companyId") int companyId, 
								@PathVariable("projectId") int projectId,
								Model model) {
		Map<String, Integer> map = new HashMap<>();
		map.put("companyId", companyId);
		map.put("projectId", projectId);
		
		model.addAttribute("companyId", companyId);
		model.addAttribute("projectId", projectId);
		return "codewall/codeWall";
	}
	
	@ResponseBody
	@GetMapping(value = "/codeWallListJson", produces = "application/json;charset=UTF-8") // 게시판 전체정보를 조회할수있게 페이징처리해야함 자바스크립트로 할지 자바로 할지 고민중..
	public List<CodeWallVO> codeWallListJson(@PathVariable("companyId") int companyId, 
											@PathVariable("projectId") int projectId) {
		log.debug("체크 : {}", service.selectCodeWallList(projectId));
		return service.selectCodeWallList(projectId);
	}
	
	@ResponseBody
	@RequestMapping(value = "/article", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public CodeWallVO codeWallArticle(@RequestParam("codewallId") String codewallId, 
										Model model) {
		int codeWallid = Integer.parseInt(codewallId);
		return service.selectCodeWallArticle(codeWallid);
	}
	
	// 게시글 작성
		@GetMapping("/codeWallForm")  // 게시판 작성폼으로
		public String noticeBoardForm() {
			return "codewall/codeWall";
		}
	
	@ResponseBody
	@PostMapping(value = "/insertCodeWall", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public int insertCodeWall(@RequestBody CodeWallVO vo,
							@PathVariable("companyId") int companyId, 
							@PathVariable("projectId") int projectId,
							Authentication user) {
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		int memberId = voWrapper.getRealUser().getMemberId();
		vo.setMemberId(memberId);
		vo.setProjectId(projectId);
		vo.setCompanyId(companyId);
		return service.insertCodeWall(vo);
				
	}
	
	// 게시글 수정
		@ResponseBody
		@PostMapping(value = "/updateCodeWall", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 게시판 수정 완료
		public String codeWallUpdate(@RequestBody CodeWallVO vo, Authentication user) {
			MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
			int memberId = voWrapper.getRealUser().getMemberId();
			vo.setMemberId(memberId);
			
			int cnt = service.updateCodeWall(vo);
			int count = cnt > 0 ? cnt : 0;
			return Integer.toString(count);
		}

}
