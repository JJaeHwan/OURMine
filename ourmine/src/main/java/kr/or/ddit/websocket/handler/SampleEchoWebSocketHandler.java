package kr.or.ddit.websocket.handler;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.security.core.Authentication;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SampleEchoWebSocketHandler extends TextWebSocketHandler {
	private List<WebSocketSession> sessionList = new ArrayList<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("연결 수립 : {}", session);
		sessionList.add(session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("연결 종료 : {}", session);
		sessionList.remove(session);
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log.error(exception.getMessage(), exception);
	}

	@Data
	@AllArgsConstructor
	public static class MessageVO implements Serializable{
		private String sender;
		private String message;
	}

	/**
	 * 웹 소켓 메시지 처리 영역...
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String realMsg = message.getPayload();

		log.debug("msg : {}",realMsg);


    	sessionList.forEach((ws)->{
			log.debug("tttt : Attributes : {}", ws.getAttributes());
		});

		JSONParser parser = new JSONParser();
        JSONObject jsonMsg = (JSONObject) parser.parse(realMsg);

        // 채팅방 사용자들의 방 번호
        String room = String.format("%s", jsonMsg.get("room"));


        // 웹소켓 처음 접속을 하였을 경우.. 체크
        String roomConnect = String.format("%s", jsonMsg.get("roomConnect"));
        if (StringUtils.equalsIgnoreCase("roomConnect", roomConnect)) {
        	sessionList.forEach((ws)->{
    			log.debug("userId : {}, id : {}, 번호 : {}",ws.getPrincipal().getName(), ws.getId(), room);

    			if (StringUtils.equalsIgnoreCase(session.getPrincipal().getName(), ws.getPrincipal().getName())) {
    				ws.getAttributes().put("room", room);
    			}
    			log.debug("Attributes : {}", ws.getAttributes());

    		});
        } else {

    		Authentication authentication = (Authentication) session.getPrincipal();
    		String sender = authentication.getName();

    		MessageVO messageVO = new MessageVO(sender, realMsg);
    		String jsonPayload = new ObjectMapper().writeValueAsString(messageVO);
    		sessionList.forEach((ws)->{
    			log.debug("sessionList : {}", ws);
    			log.debug("sessionList : {}", ws.getId());
    			log.debug("채팅방 번호 : {}", room);
    			log.debug("Principal : {}", ws.getPrincipal());
    			log.debug("Attributes : {}", ws.getAttributes());

    			try {
    				String targetRoom = String.format("%s", ws.getAttributes().get("room"));
    				log.debug("form : {}, to : {}", room, targetRoom);

    				if (StringUtils.equalsIgnoreCase(room, targetRoom)) {
    					ws.sendMessage(new TextMessage(jsonPayload));
    				}
    			} catch (IOException e) {
    				throw new RuntimeException(e);
    			}
    		});
        }

	}
}


















