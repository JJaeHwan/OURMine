package kr.or.ddit.member.service;


import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Service
public class MemberEncryptionImpl  implements MemberEncryption {
//	@Inject
	private PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	

	public String encode(String memberPassword) {
		
		// encrypt(암호화)/decrypt vs encode(부호화)/decode
		// 암호화는 권한이 없는 사람이 읽을 수 없게 , 부호화는 
		String encoded = encoder.encode(memberPassword);
		log.info("encoded password: {}", encoded);
		return encoded;
//		String saved = "{bcrypt}$2a$10$KbCz9uVWa6wuXM6fdgjC0umUcwF6ljVGfKvpqQG8LuxzkMtzAcFmK";
//		log.info("인증 성공 여부 : {}", encoder.matches(plain, saved));
	}
}


