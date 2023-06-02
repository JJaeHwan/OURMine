package kr.or.ddit.chatting.vo;

import java.io.Serializable;
import java.text.MessageFormat;
import java.util.UUID;

import org.springframework.messaging.simp.SimpMessagingTemplate;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
public class ChatRoom implements Serializable{
	private String roomId;
	private String owner; 
	private String roomTitle;
	@ToString.Exclude
	@JsonIgnore
	private transient SimpMessagingTemplate msgTmpl;
	private String destination;
	
	public ChatRoom(SimpMessagingTemplate msgTmpl, String owner, String roomTitle) {
		super();
		this.msgTmpl = msgTmpl;
		this.owner = owner;
		this.roomTitle = roomTitle;
		this.roomId = UUID.randomUUID().toString();
		this.destination = MessageFormat.format("/chat/{0}", roomId);
	}
	
	public void broadCastInRoom(ChatMessage message) {
		msgTmpl.convertAndSend(getDestination(), message);
	}
}










