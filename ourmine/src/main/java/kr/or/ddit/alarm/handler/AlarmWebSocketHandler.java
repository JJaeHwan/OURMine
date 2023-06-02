package kr.or.ddit.alarm.handler;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.websocket.handler.SampleEchoWebSocketHandler.MessageVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AlarmWebSocketHandler extends TextWebSocketHandler {
	private List<WebSocketSession> alarmList = new ArrayList<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("알림 연결 수립 : {}", session);
		alarmList.add(session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("알람 연결 종료 : {}", session);
		alarmList.remove(session);
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log.error(exception.getMessage(), exception);
	}

	@Data
	@AllArgsConstructor
	public static class MessageVO implements Serializable {
		private String message;
	}

	/**
	 * 웹 소켓 메시지 처리 영역...
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String realMsg = message.getPayload();

		log.debug("msg : {}", realMsg);

		JSONParser parser = new JSONParser();
		JSONObject jsonMsg = (JSONObject) parser.parse(realMsg);

		alarmList.forEach((ws) -> {
			log.debug("sessionList : {}", ws);
			log.debug("sessionList : {}", ws.getId());
			log.debug("Principal : {}", ws.getPrincipal());
			log.debug("Attributes : {}", ws.getAttributes());

				try {
					MessageVO messageVO = new MessageVO(realMsg);
					String jsonPayload = new ObjectMapper().writeValueAsString(messageVO);
					ws.sendMessage(new TextMessage(jsonPayload));
				} catch (JsonProcessingException e) {

				} catch (IOException e) {
					e.printStackTrace();
				}

		});

	}
}
