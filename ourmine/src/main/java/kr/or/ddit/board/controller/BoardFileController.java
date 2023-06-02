package kr.or.ddit.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.or.ddit.board.service.BoardFileService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/boardFile")
@RequiredArgsConstructor
public class BoardFileController {
	
	private final BoardFileService service;
	

	@GetMapping("/boardFileList") // 
	public String boardFileList() {
		return null;
	}
	
	@GetMapping("/{boardFileId}") 
	public String boardFileSelect() {
		return null;
	}
	
	@GetMapping("/boardFileForm")  // 
	public String boardForm() {
		return null;
	}
	
	@PostMapping("/boardFileForm") //
	public String boardFileJoin() {
		return null;
	}

	
	@GetMapping("/boardFileView") // 
	public String boardFileView() {
		return null;
	}
	
	@PostMapping("/boardFileView") //
	public String boardFileUpdate() {
		return null;
	}
	
	@GetMapping("/boardFileDelete") //  
	public String boardFileDeleteForm() {
		return null;
	}
	
	@PostMapping("/boardFileDelete") // 
	public String boardFileDelete() {
		return null;
	}
}
