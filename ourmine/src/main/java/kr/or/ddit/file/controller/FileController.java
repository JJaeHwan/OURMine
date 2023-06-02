package kr.or.ddit.file.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.file.service.FileService;
import kr.or.ddit.file.vo.FileVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/company/{companyId}/file")
@RequiredArgsConstructor
public class FileController {
	
	private final FileService service;
	
	@GetMapping("fileList")
	public String fileUi() {
		
		return "file/fileList";
	}
	
	@GetMapping(value= "fileListJson/", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<BoardVO> fileList(@PathVariable int companyId, Model model){
		
//		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
//		companyId = voWrapper.getRealUser().getCompanyId();
		
		model.addAttribute("companyId",companyId);
		
		List<BoardVO> fileList = service.fileList(companyId);
		
		log.info("fileList@@@@@@@@@@@@{}",fileList);
		
		return fileList;
		
		
	}

}
