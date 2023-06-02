package kr.or.ddit.websocket.vo;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
//@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class MessageVO {
	@Builder.Default
	private MessageType messageType = MessageType.INFO;
	private String message;
	private String sender;
	private String receiver;
	
	private String senderNicName;
	private String memberId;

	private String departmentName;
	
	
	
	public String getColor() {
		return messageType.getColor();
	}
	
	public String getBackgroundColor() {
		return messageType.getBackgroundColor();
	}
	public enum MessageType{
		INFO, SUCCESS, QUESTION, CHATTING, ALARM, WARNING("yellow", "white"), ERROR("red", "yellow");
		private MessageType() {
			this("black", "white");
		}
		private MessageType(String color, String backgroundColor) {
			this.color = color;
			this.backgroundColor = backgroundColor;
		}
		private String color;
		private String backgroundColor;
		public String getColor() {
			return color;
		}
		public String getBackgroundColor() {
			return backgroundColor;
		}
	}
}
