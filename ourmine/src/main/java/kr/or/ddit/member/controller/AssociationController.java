package kr.or.ddit.member.controller;

import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.project.vo.ProjectVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import kr.or.ddit.member.service.AssociationService;
import kr.or.ddit.member.service.MemberService;
import lombok.RequiredArgsConstructor;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/association")
public class AssociationController {

	private final AssociationService service;
	private final MemberService memberService;
	//
	@PostMapping(value = "/associationList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<AssociationVO> associationList(@RequestBody AssociationVO vo, Authentication user ) {
		MemberVOWrapper realUser = (MemberVOWrapper) user.getPrincipal();
		MemberVO memberVO = memberService.memberSelect(realUser.getRealUser().getMemberEmail());
		vo.setMemberId(memberVO.getMemberId());

		log.info("memberVO.get.memberId()={}", memberVO.getMemberId());

		List<AssociationVO> associationVOS = service.associationList(vo);
		associationVOS.forEach(associationVO -> {
			Optional.ofNullable(associationVO.getMemberImageFileRoute())
					.filter(fileRoute -> {
						Path path = Paths.get(fileRoute);
						return Files.exists(path);
					})
					.ifPresent(fileRoute -> {
						try {
							String filePathName = associationVO.getMemberImageFileRoute();
							String fileExtName = associationVO.getFileExtension();
							Path path = Paths.get(fileRoute);
							byte[] fileArray = Files.readAllBytes(path);
							String encodedString = Base64.getEncoder().encodeToString(fileArray);
							String changeString = "data:image/" + fileExtName + ";base64, " + encodedString;
							log.info("changeString = {}", changeString);
							associationVO.setImageContents(changeString);
						} catch (IOException e) {
							e.printStackTrace();
						}
					});
		});

		return associationVOS;
	}


	@GetMapping("/{associationId}") //
	public String associationSelect() {
		return null;
	}

}
