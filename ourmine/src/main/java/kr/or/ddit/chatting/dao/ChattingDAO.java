package kr.or.ddit.chatting.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.chatting.vo.ChatVO;
import kr.or.ddit.member.vo.MemberVO;

@Mapper
public interface ChattingDAO {
	public List<MemberVO> selectChatCoMemList(int companyId);
	
	public List<ChatVO> selectChatList(int chattingId);
	
	public List<ChatVO> selectGroupChatList(int memberId);
	
	public String selectLastContent(int chattingId);
	
	public int insertChatRoom(ChatVO chatVO);
	
	public void insertChatMemList(ChatVO chatVO);
	
	public List<MemberVO> selectDeptList(int companyId);
	
	public List<MemberVO> selectTeamList(MemberVO memberVO);
	
	public void insertMessage(ChatVO chatVO);
	
	public List<ChatVO> selectChatCont(int chattingId);
	
	public ChatVO selectCheckRoom(ChatVO chatVO);
	
	public String selectChattingAlarmReceiver(int memberId);
	
	public void insertChattingAlarm(AlarmVO alarmVO); 
	
	public List<String> getThisChattingMemberList(int chattingId);
	
	public int chattingRoomOut(ChatVO chatVO);
	
}
