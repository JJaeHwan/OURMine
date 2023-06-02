package kr.or.ddit.codeEditor.Controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import kr.or.ddit.codeEditor.ApiKeyProvider;
import kr.or.ddit.codeEditor.service.CodeEditorService;
import kr.or.ddit.codeEditor.service.CodeEditorServiceImpl;
import kr.or.ddit.codeEditor.util.CodeRequest;
import kr.or.ddit.codeEditor.util.CodeRequestBody;
import kr.or.ddit.codeEditor.vo.CodeVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping("/company/{companyId}/project/{projectId}/codeEditor")
public class CodeEditorController {
	
	@Autowired
	private ApiKeyProvider apiKeyProvider;
	
	@Inject
	private CodeEditorService codeService;
	
//	@Value("${rextester.api.key}")
//	private String apiKey;
	
	@GetMapping
	public String codeEditorForm(@PathVariable("companyId") int companyId, 
								@PathVariable("projectId") int projectId, 
								Model model, Authentication user) {
		model.addAttribute("companyId", companyId);
		model.addAttribute("projectId", projectId);
		MemberVOWrapper principal =  (MemberVOWrapper) user.getPrincipal();
		int memberId = principal.getRealUser().getMemberId();
		model.addAttribute("memberId", memberId);
		log.info("companyId = {}", companyId);
		log.info("projectId = {}", projectId);
		log.info("memberId = {}", memberId);
//		model.addAttribute("apiKey", apiKey);
		return "codeeditor/codeEditor";
	}
	
	@GetMapping("/getExampleCode")
	@ResponseBody
	public String getExampleCode(@RequestParam("language") int selectedValue, Model model) {
		String savedCode = codeService.codeSelectByLanguage(selectedValue);
		return savedCode != null ? savedCode : "선택한 언어에 해당하는 코드 예시가 존재하지 않습니다.";
		
	};
	
	@RequestMapping("/codeList")
	@ResponseBody
	public List<CodeVO> getCodeList(@RequestParam("memberId") int memberId, 
									@PathVariable("projectId") int projectId, 
									@PathVariable("companyId") int companyId) {
		CodeVO vo = new CodeVO();
		vo.setProjectId(projectId);
		vo.setMemberId(memberId);
	    List<CodeVO> codeList = codeService.savedCodeList(vo);
	    return codeList;
	}
	
	
	@RequestMapping(value = "/excuteCode", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody ResponseEntity excuteCode(@RequestBody CodeRequest codeRequest, Model model) {
		ResponseEntity<Map> response = null;
		try {
			String apiKey = apiKeyProvider.getApiKey();
			log.info("apikey = {}", apiKey);
			
			RestTemplate restTemplate = new RestTemplate();
			String apiUrl = "https://rextester.com/rundotnet/api?ApiKey=" + apiKey; // RexTester API 엔드포인트 URL
			
			// 요청 설정
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);
			headers.add("x-api-key", apiKey);
			
			// 요청 바디 설정
			CodeRequestBody requestBody = new CodeRequestBody(codeRequest.getLanguageChoice(), codeRequest.getCode());
			HttpEntity<CodeRequestBody> requestEntity = new HttpEntity<>(requestBody, headers);
			
			// api 호출 및 응답
//			response = restTemplate.exchange(
//					apiUrl,
//					HttpMethod.POST, 
//					requestEntity, 
//					CodeResponse.class);

			response = restTemplate.exchange(apiUrl, HttpMethod.POST, requestEntity, Map.class);
			
			// 응답 결과 모델에 추가
			model.addAttribute("response", response.getBody());
			
			
			log.info(response.getBody().toString());
			log.info("response = {}", response);
			
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return response;
	}	
	
	@RequestMapping(value = "/saveCode", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
	@ResponseBody
	public int saveCode(@RequestBody CodeVO vo, 
						@PathVariable("companyId") int companyId, 
						@PathVariable("projectId") int projectId) {
		
		vo.setProjectId(projectId);
		vo.setCompanyId(companyId);
		log.info("codeVo = {}", vo);
		int rowcnt = codeService.codeInsert(vo);
		log.info("rowcnt = {}", rowcnt);
		return rowcnt;
	}
	
	@RequestMapping(value = "/updateCode", produces = MediaType.APPLICATION_JSON_UTF8_VALUE, method=RequestMethod.POST)
	@ResponseBody
	public int updateCode(@RequestBody CodeVO vo) {
		
		log.info("codeVo = {}", vo);
		int rowcnt = codeService.updateCode(vo);
		log.info("rowcnt = {}", rowcnt);
		return rowcnt;
	}
	
	
	
}
