package kr.or.ddit.chatting.vo;

import java.io.Serializable;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
@Getter
@ToString
public class ChatMessage implements Serializable{
	public enum MessageType { NOTIFY, DIALOG }
	@Builder.Default
	private MessageType msgType = MessageType.DIALOG;
	private String sender;
	private String receiver;
	private String message;
	private String roomId;
}
