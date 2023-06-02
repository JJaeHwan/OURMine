package kr.or.ddit.security;

import javax.inject.Inject;

import org.junit.Test;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.or.ddit.AbstractModelLayerTest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordEncoderTest extends AbstractModelLayerTest{
//	@Inject
	private PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	
	@Test
	public void encodeTest() {
		String plain = "java";
		// encrypt(암호화)/decrypt vs encode(부호화)/decode
		// 암호화는 권한이 없는 사람이 읽을 수 없게 , 부호화는 
		String encoded = encoder.encode(plain);
		log.info("encoded password: {}", encoded);
		
//		String saved = "{bcrypt}$2a$10$KbCz9uVWa6wuXM6fdgjC0umUcwF6ljVGfKvpqQG8LuxzkMtzAcFmK";
//		log.info("인증 성공 여부 : {}", encoder.matches(plain, saved));
	}
}
