package kr.or.ddit.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.noticeBoard.vo.NoticeBoardVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping("/company/{companyId}/project/{projectId}/board")
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	// 전부 비동기 처리할 예정이라 @ResponseBody , @RequestBody 적절히 사용해야함 !!

	private final BoardService service;


	@GetMapping("boardList") //
	public String boardList(@PathVariable int companyId, @PathVariable int projectId) {
		return "project/board/boardList";
	}

	@GetMapping(value ="boardListJson",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public List<BoardVO> boardListJson(int boardTypeId) {

		return service.boardList(boardTypeId);
	}


	@GetMapping(value = "/boardFileSelect/{boardId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<?> noticeBoardSelect(@PathVariable("boardId") Integer boardId) {
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



   @PostMapping(value ="boardSelect",produces = "application/json;charset=utf-8") //
   @ResponseBody
   public BoardVO boardSelect(@RequestBody Map<String,Integer> jmap) {
	   log.debug("check: " + jmap.get("mdata"));
	   int boardId = jmap.get("mdata");
	   BoardVO boardVO = service.boardSelect(boardId);

       return boardVO;
   }
   @PostMapping(value ="boardHitUpdate",produces = "application/json;charset=utf-8") //
   @ResponseBody
   public int boardHitUpdate(@RequestBody int boardIdParam) {
	   int cnt = service.boardHitUpdate(boardIdParam);

	   return cnt;
   }

   @GetMapping("boardForm")  //
   public String boardForm() {
      return "project/board/boardList";
   }

   @ResponseBody
   @PostMapping(value = "boardForm",produces = "application/json;charset=utf-8") //
   public int boardJoin(  BoardVO board,
		   				 @PathVariable int companyId,
		   				 @PathVariable int projectId,
		   				 Authentication user
		   ) {
       List<MultipartFile> files = board.getFiles();

//	   MemberVO membername =  memberService.memberSelect(user.getName());
//	   log.info("memberName",membername.getMemberName());
	   MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
	   String boardWriter = voWrapper.getRealUser().getMemberName();
	   log.info("boardWriter{}",boardWriter);
	   int memberId = voWrapper.getRealUser().getMemberId();
	   board.setCompanyId(companyId);
	   board.setProjectId(projectId);
	   board.setBoardWriter(boardWriter);
	   board.setMemberId(memberId);
	   board.setBoardConotice("N");

	   int projectRoleId = service.selectProjectRole(board);
	   log.info("projectRoleId{}",projectRoleId);

	   board.setProjectRoleId(projectRoleId);

	  int cnt = service.insertBoard(board,files);
      return cnt;
   }

   @ResponseBody
   @PostMapping(value = "boardDelete", produces = "application/json;charset=utf-8") //
   public int boardDelete(@RequestBody int boardId, Authentication user) {
	   int cnt = service.deleteBoard(boardId);
	   return cnt;
   }

   @ResponseBody
   @PostMapping(value = "boardView", produces = "application/json;charset=utf-8") //
   public int boardUpdate(@RequestBody BoardVO board, Authentication user ){
	  int cnt = service.updateBoard(board);
      return cnt;
   }
}