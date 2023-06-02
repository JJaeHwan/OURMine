package kr.or.ddit.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/boardCoNotice")
@RequiredArgsConstructor
@Slf4j
public class BoardCoNoticeController {
	
	// 전부 비동기 처리할 예정이라 @ResponseBody , @RequestBody 적절히 사용해야함 !!
	
	private final BoardService service;
	
	@GetMapping("/boardCoNoticList") //
	public String boardCoNoticList() {
		
		return "noticeboard/boardCoNoticList";
	}
	
	@ResponseBody
	@GetMapping(value = "/boardCoNoticListJson", produces = "application/json;charset=utf-8") //
	public List<BoardVO> boardCoNoticListJson(Authentication user) {
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		int memberId = voWrapper.getRealUser().getMemberId();
		
		int companyId = service.boardMemCompanySelect(memberId);
		return service.boardCoNoticList(companyId);
	}
	
	@PostMapping(value = "/boardCoNoticSelect", produces = "application/json;charset=utf-8") //
	@ResponseBody
	public BoardVO boardSelect(@RequestBody Map<String, Integer> jmap) {
		log.debug("check: " + jmap.get("mdata"));
		int boardId = jmap.get("mdata");
		return service.boardSelect(boardId);
	}
	
	@GetMapping(value = "/boardCoFile/{boardId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<?> boardCoFile(@PathVariable("boardId") Integer boardId) {
		List<BoardVO> boardVOS = service.boardFileSelect(boardId); // 해당 게시글의 정보를 가져옵니다.
		Map<String, Object> response = new HashMap<>();
		
		List<Map<String, String>> files = boardVOS.stream()
				.map(vo -> {
					Map<String, String> file = new HashMap<>();
					file.put("original", vo.getOriginalFileName());
					file.put("uuid", vo.getSaveFileName());
					return file;
				})
				.collect(Collectors.toList());
		
		// 모든 파일 정보를 response에 저장함
		response.put("files", files);
		
		return ResponseEntity.ok(response);  // 게시글 정보와 파일 정보를 같이 반환
	}

    @PostMapping(value ="/boardCoNoHitUpdate",produces = "application/json;charset=utf-8") //
    @ResponseBody
    public int boardHitUpdate(@RequestBody int boardIdParam) {
		
		return service.boardHitUpdate(boardIdParam);
    }
	
	@GetMapping("/boardCoNoticForm") //
	public String boardCoNoticForm() {
		
		return "noticeboard/boardCoNoticList";
	}
	
	@ResponseBody
	@PostMapping(value = "/boardCoNoticForm", produces = "application/json;charset=utf-8") //
	public int boardCoNoticJoin(@RequestBody BoardVO board, Authentication user) {
		List<MultipartFile> files = board.getFiles();
//	   MemberVO membername =  memberService.memberSelect(user.getName());
//	   log.info("memberName",membername.getMemberName());
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		String boardWriter = voWrapper.getRealUser().getMemberName();
		log.info("boardWriter{}", boardWriter);
		int memberId = voWrapper.getRealUser().getMemberId();
		
		board.setBoardWriter(boardWriter);
		board.setMemberId(memberId);
		board.setBoardConotice("Y");
		board.setBoardTypeId(1);
		board.setProjectId(1);
		board.setProjectRoleId(1);
		Integer companyId = service.boardMemCompanySelect(memberId);
		board.setCompanyId(companyId);
		return service.insertBoard(board,files);
	}
	
	@ResponseBody
	@PostMapping(value = "/boardCoNoticDelete", produces = "application/json;charset=utf-8") //
	public int boardDelete(@RequestBody int boardId, Authentication user) {
		return service.deleteBoard(boardId);
	}
	
	
	@ResponseBody
	@PostMapping(value = "/boardCoNoticView", produces = "application/json;charset=utf-8") //
	public int boardUpdate(@RequestBody BoardVO board, Authentication user) {
		return service.updateBoard(board);
	}
}