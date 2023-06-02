package kr.or.ddit.noticeBoard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import kr.or.ddit.noticeBoard.service.NoticeBoardFileService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/noticeBoardFile")
public class NoticeBoardFileController {
	
	private final NoticeBoardFileService service;
	
	// 전부 비동기 처리할 예정이라 @ResponseBody , @RequestBody 적절히 사용해야함 !!
	
	@GetMapping("/noticeBoardFileList") // 
	public String noticeBoardFileList() {
		return null;
	}
	
	@GetMapping("/{noticeBoardFileId}") 
	public String noticeBoardFileSelect() {
		return null;
	}
	
	@GetMapping("/noticeBoardFileForm")  // 
	public String noticeBoardFileForm() {
		return null;
	}
	
	@PostMapping("/noticeBoardFileForm") //
	public String noticeBoardFileJoin() {
		return null;
	}

	
	@GetMapping("/noticeBoardFileView") //
	public String noticeBoardFileView() {
		return null;
	}
	
	@PostMapping("/noticeBoardFileView") // 
	public String noticeBoardFileUpdate() {
		return null;
	}
	
	@GetMapping("/noticeBoardFileDelete") //  
	public String noticeBoardFileDeleteForm() {
		return null;
	}
	
	@PostMapping("/noticeBoardFileDelete") // 
	public String noticeBoardFileDelete() {
		return null;
	}
}
