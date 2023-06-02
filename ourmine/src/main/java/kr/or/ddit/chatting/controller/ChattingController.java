package kr.or.ddit.chatting.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.chatting.service.ChattingService;
import kr.or.ddit.chatting.vo.ChatVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/company/{companyId}/chat")
@RequiredArgsConstructor
@Slf4j
public class ChattingController {
	
	private final ChattingService service;
	
	@Inject
	private SimpMessagingTemplate msgTmpl;
	
	@GetMapping("chat") //
	public String chattingList(@PathVariable int companyId) {
		return "chat/chat";
	}

	@GetMapping(value ="chatJson",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public List<ChatVO> chatGetList ( Authentication user,@PathVariable int companyId){
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		   int memId = voWrapper.getRealUser().getMemberId();
		   log.info("memId:{}",memId);
		   List<ChatVO> chat = service.selectChatList(memId);
		   log.info("chat:{}",chat);
		   
		return chat;
	}
	@GetMapping(value ="getGroupChatList",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public List<ChatVO> getGroupChatList ( Authentication user,@PathVariable int companyId){
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		int memId = voWrapper.getRealUser().getMemberId();
		log.info("memId:{}",memId);
		List<ChatVO> groupChat = service.selectGroupChatList(memId);
		log.info("chat:{}",groupChat);
		
		return groupChat;
	}
	
	@GetMapping(value ="coMemList",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public List<MemberVO> coMemList (@PathVariable int companyId){
		
		List<MemberVO> list = service.selectChatCoMemList(companyId);
		log.info("listlistlist:{}",list);
		
		return list;
	}
	
	@GetMapping(value ="deptList",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public List<MemberVO> deptList (@PathVariable int companyId){
		
		List<MemberVO> list = service.selectDeptList(companyId);
		log.info("listlistlist:{}",list);
		
		return list;
	}
	
	@GetMapping(value ="getTeamList",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public List<MemberVO> getTeamList ( int orgchartId,
										@PathVariable int companyId){
		MemberVO memberVO = new MemberVO();
		
		memberVO.setCompanyId(companyId);
		memberVO.setOrgchartId(orgchartId);
		
		List<MemberVO> list = service.selectTeamList(memberVO);
		
		return list;
	}
	
	@GetMapping(value ="getThisChattingMemberList",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public List<String> getThisChattingMemberList (@PathVariable int companyId, int room){
		
		log.info("sendData",room);
		int chattingId = room;
		List<String> list = service.getThisChattingMemberList(chattingId);
		
		return list;
	}
	
	@PostMapping(value="makeRoom", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ChatVO makeRoom(@RequestBody ChatVO chatVO, Authentication user) {
		
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		int memId = voWrapper.getRealUser().getMemberId();
		String memName = voWrapper.getRealUser().getMemberName();
		log.info("memId:{}",memId);
		
//		List<Integer> memberList  = new ArrayList<Integer>();
//
//		if(chatVO.getMemberList() != null) {
//			memberList = chatVO.getMemberList();
//		}
		
//		memberList.add(memId);
		chatVO.setChattingMemName(memName);
		chatVO.setMemberId(memId);
		chatVO.setChattingWhtherGroup("Y");
		
//		log.info("memberList:{}",memberList);
		
//		chatVO.setMemberList(memberList);
		
		service.insertChatRoom(chatVO);
		
		return chatVO;				
	}
	@PostMapping(value="makeSingleRoom", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ChatVO makeSingleRoom(@RequestBody ChatVO chatVO, Authentication user) {
		
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		int memId = voWrapper.getRealUser().getMemberId();
		String memName = voWrapper.getRealUser().getMemberName();
		
		ChatVO checkList = service.selectCheckRoom(chatVO);
		log.info("checkList:{}",checkList);
		if( checkList != null ) {

			return checkList;
		}else {
		
			log.info("memId:{}",memId);
			
			List<Integer> memberList  = new ArrayList<Integer>();
			log.info("memberList:{}",memberList);
			memberList.add(chatVO.getCompareMemId());
			
			chatVO.setChattingMemName(memName);
			log.info("setChattingMemName:{}",chatVO.getChattingMemName());
			chatVO.setMemberId(memId);
			chatVO.setChattingWhtherGroup("N");
			chatVO.setMemberList(memberList);
			
			service.insertChatRoom(chatVO);
			
			return chatVO;		
		}
	}
	@PostMapping(value="msgCommit", produces = "application/json;charset=utf-8")
	@ResponseBody
	public ChatVO msgCommit(@RequestBody ChatVO chatVO, Authentication user) {
		
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		int memberId = voWrapper.getRealUser().getMemberId();
		
		log.info("memberId:{}",memberId);
		
		chatVO.setMemberId(memberId);
		
		service.insertMessage(chatVO);
		
		return chatVO;		
	}
	
	@GetMapping(value ="getChatContList",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public List<ChatVO> getChatContList (ChatVO chatVO){
		
		int chattingId = chatVO.getChattingId();
		List<ChatVO> list = service.selectChatCont(chattingId);
		
		return list;
	}
	
	@GetMapping(value ="roomOut",produces = "application/json;charset=utf-8") //
	@ResponseBody
	public int roomOut (@PathVariable int companyId,
						int room,
						Authentication user){
		
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		int memberId = voWrapper.getRealUser().getMemberId();
		   
		 ChatVO chatVO = new ChatVO();
		 log.info("roomroom:{}",room);
		 chatVO.setChattingId(room);
		 chatVO.setMemberId(memberId);
		 int cnt = service.chattingRoomOut(chatVO);
		
		return cnt;
	}
	
	
//	
//	@GetMapping("enter/{roomId}")
//	public String enterRoom(@PathVariable String roomId, Model model) {
//		ChatRoom findedRoom = chatRooms.get(roomId);
//		model.addAttribute("room", findedRoom);
//		return "chatting/roomView";
//	}
	
	
}
