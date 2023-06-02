package kr.or.ddit.ui;

import java.net.URI;
import java.net.URISyntaxException;

import org.java_websocket.drafts.Draft_6455;
import org.json.JSONException;
import org.json.JSONObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AlarmSendUtil {
	
	public static boolean send(String sander,String userId, String message, String time) {
		try {
			// 실제 uri는 yml에 존재하나, 보안상 다른 예시를 붙여넣는다.
			// URI uri = "ws://this.is.example.domain/";
//				URI uri = new URI("ws://192.168.36.58/ourmine/ws/echo");
			URI uri = new URI("ws://localhost/ourmine/aws/echo");
			WebSocketUtil webSocketUtil = new WebSocketUtil(uri, new Draft_6455());
			webSocketUtil.connectBlocking();
			
			JSONObject obj = new JSONObject();
			obj.put("sander", sander);
			obj.put("userId", userId);
			obj.put("message", message);
			obj.put("time", time);
			
			String strMessage = obj.toString();
			webSocketUtil.send(strMessage);
			JSONObject result = webSocketUtil.getResult();
			
			log.debug("result : {}", result);
			webSocketUtil.close();
			
			return true;
		} catch (JSONException e) {
			log.error(e.getMessage(), e);
			return false;
		} catch (URISyntaxException e) {
			log.error(e.getMessage(), e);
			return false;
		} catch (InterruptedException e) {
			log.error(e.getMessage(), e);
			return false;
		}
	}
}
