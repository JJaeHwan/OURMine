package kr.or.ddit.alarm.controller;

import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.alarm.service.AlarmService;
import lombok.RequiredArgsConstructor;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Controller
@RequestMapping("/alarm")
@Slf4j
public class AlarmController {

	private final AlarmService service;

	@Value("#{appInfo['member.attatchPath']}")
	private String uploadDir;

	@GetMapping("/alarmList") //
	@ResponseBody
	public List<AlarmVO> AlarmList(Authentication user) {
		MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
		int memberId = principal.getRealUser().getMemberId();
		return service.alarmList(memberId);
	}
}
