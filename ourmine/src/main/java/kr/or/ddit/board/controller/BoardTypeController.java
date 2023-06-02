package kr.or.ddit.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.service.BoardTypeService;
import kr.or.ddit.board.vo.BoardTypeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/company/{companyId}/project/{projectId}/boardType")
@RequiredArgsConstructor
@Slf4j
public class BoardTypeController {
	
	// 전부 비동기 처리할 예정이라 @ResponseBody , @RequestBody 적절히 사용해야함 !!
	
	private final BoardTypeService service;
	
	
	@GetMapping(value="boardTypeList",produces = "application/json;charset=utf-8") // 
	@ResponseBody                 // Ajax용
	public List<BoardTypeVO> boardTypeList(@PathVariable int projectId) {
		List<BoardTypeVO> list = service.BoardTypeList(projectId);
		log.info("projectId:{}",projectId);
		
		return list;
	}
	@GetMapping("boardTypeList") // 홈페이지 관리자는 현재 등록된 회사 리스트를 볼수있게
	public String boardTypeListUi() {
		
		return "bodynav";
	}
	
	@PostMapping(value="boardTypeForm",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public BoardTypeVO boardJoin(@RequestBody BoardTypeVO boardType,
								 @PathVariable int projectId) {
		boardType.setProjectId(projectId);
		service.insertBoardType(boardType);
		
		return boardType;
	}
	
	@PostMapping("/boardTypeDelete") // 
	@ResponseBody
	public String boardDelete(@RequestBody int boardTypeId) {
		int cnt = service.deleteBoardType(boardTypeId);
		return Integer.toString(cnt);
	}
}
