package kr.or.ddit.chatting.service;

import java.util.List;

import kr.or.ddit.chatting.vo.ChatVO;
import kr.or.ddit.member.vo.MemberVO;

public interface ChattingService {
	
	public List<MemberVO> selectChatCoMemList(int companyId);
	
	public List<MemberVO> selectDeptList(int companyId);
	
	public List<ChatVO> selectChatList(int memId);
	
	public List<ChatVO> selectGroupChatList(int memberId);
	
	public String selectLastContent(int chattingId);
	
	public int insertChatRoom(ChatVO chatVO);
	
	public List<MemberVO> selectTeamList(MemberVO memberVO);
	
	public void insertMessage(ChatVO chatVO);
	
	public List<ChatVO> selectChatCont(int chattingId);
	
	public ChatVO selectCheckRoom(ChatVO chatVO);
	
	public List<String> getThisChattingMemberList(int chattingId);
	
	public int chattingRoomOut(ChatVO chatVO);
}
