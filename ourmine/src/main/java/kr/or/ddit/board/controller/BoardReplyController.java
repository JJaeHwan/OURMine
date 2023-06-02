package kr.or.ddit.board.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.service.BoardReplyService;
import kr.or.ddit.board.vo.BoardReplyVO;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/reply")
@RequiredArgsConstructor
@Slf4j
public class BoardReplyController {
	
	private final BoardReplyService service;
	
	
	@GetMapping(value ="/boardReplyListJson",produces = "application/json;charset=utf-8") // 
	@ResponseBody
	public List<BoardReplyVO> boardReplyListJson(int boardId) {
		log.info("타잔과 제인:" +boardId);
		return service.boardReplyList(boardId);
	}
	
	
	@PostMapping(value ="/replyInsert",produces = "application/json;charset=utf-8") // 게시판 에서 댓글 작성이 완료되면 여기에
	@ResponseBody
	public int replyJoin(@RequestBody BoardReplyVO boardReply, Authentication user) {
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		String replyWriter = voWrapper.getRealUser().getMemberName();
		int replyWriterId = voWrapper.getRealUser().getMemberId();
		boardReply.setReplyWriter(replyWriter);
		boardReply.setReplyWriterId(replyWriterId);
		int cnt =service.insertBoardReply(boardReply);
		
		return cnt;
	}
	
	
	@PostMapping(value = "/replyDelete", produces = "application/json;charset=utf-8") // 댓글은 삭제하면 delete쿼리 해서 db까지 삭제
	@ResponseBody
	public int replyDelete(@RequestBody int boardId) {
		int cnt = service.deleteBoardReply(boardId);
		return cnt;
	}
	
   @ResponseBody
   @PostMapping(value = "/replyUpdate", produces = "application/json;charset=utf-8") // 
   public int replyUpdate(@RequestBody BoardReplyVO boardReply){
	  int cnt = service.updateBoardReply(boardReply);
      return cnt;
   }
}
