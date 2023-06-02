package kr.or.ddit.noticeBoard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.noticeBoard.service.FileStorageService;
import kr.or.ddit.noticeBoard.service.NoticeBoardService;
import kr.or.ddit.noticeBoard.vo.NoticeBoardVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/noticeBoard")
public class NoticeBoardController {

	private final NoticeBoardService service;
	// 전부 비동기 처리할 예정이라 @ResponseBody , @RequestBody 적절히 사용해야함 !!

	// 공지게시글 전체목록
	@GetMapping("/noticeBoardList") // 게시판 전체정보를 조회할수있게 페이징처리해야함 자바스크립트로 할지 자바로 할지 고민중..
	public String noticeBoardList() {
		return "noticeboard/noticeboardList";
	}

	@ResponseBody
	@GetMapping(value = "/noticeBoardListJson", produces = "application/json;charset=UTF-8") // 게시판 전체정보를 조회할수있게 페이징처리해야함 자바스크립트로 할지 자바로 할지 고민중..
	public List<NoticeBoardVO> noticeBoardListJson() {
		log.debug("체크 : {}", service.NoticeBoardList());
		return service.NoticeBoardList();
	}

	// F&Q게시글 전체목록
	@GetMapping("/fnqNoticeboardList") // 게시판 FNQ 목록조회
	public String fnqNoticeBoardList() {
		return "noticeboard/fnqNoticeboardList";
	}

	@ResponseBody
	@GetMapping(value = "/fnqNoticeBoardListJson", produces = "application/json;charset=UTF-8") // 게시판 FNQ 목록조회
	public List<NoticeBoardVO> fnqNoticeBoardListJson() {
		return service.fnqNoticeBoardList();
	}

	@GetMapping(value = "/noticeBoardSelect/{noticeBoardId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<?> noticeBoardSelect(@PathVariable("noticeBoardId") Integer noticeBoardId) {
	    List<NoticeBoardVO> noticeBoardVOS = service.NoticeBoardSelect(noticeBoardId); // 해당 게시글의 정보를 가져옵니다.
	    Map<String, Object> response = new HashMap<>();

	    List<Map<String, String>> files = noticeBoardVOS.stream()
	            .map(vo -> {
	                Map<String, String> file = new HashMap<>();
	                file.put("original", vo.getOriginalFileName());
	                file.put("uuid", vo.getSaveFileName());
	                return file;
	            })
	            .collect(Collectors.toList());

	    // 모든 파일 정보를 response에 저장함
	    response.put("files", files);

	    return ResponseEntity.ok(response);  // 게시글 정보와 파일 정보를 같이 반환
	}

	// 조회수 증가
	@ResponseBody
	@PostMapping(value = "/noticeBoardCnt", produces = "application/json;charset=UTF-8")
	public String noticeBoardCnt(@RequestBody int noticeBoardWriteId) {
		int cnt = service.updateNoticeBoardCount(noticeBoardWriteId);
		return Integer.toString(cnt);
	}

	// 게시글 작성
	@GetMapping("/noticeBoardForm")  // 게시판 작성폼으로
	public String noticeBoardForm() {
		return "noticeboard/noticeboardList";
	}

	@ResponseBody
	@PostMapping(value = "/noticeBoardForm", produces = "application/json;charset=UTF-8") // 게시판 작성 완료
	public String noticeBoardJoin(NoticeBoardVO noticeBoard, Authentication user) {
		List<MultipartFile> files = noticeBoard.getFiles(); // ajax로 form 데이터 받아서 vo에 있는 List<MultipartFile> 에 저장한걸 꺼냄
		//ajax 요청할때 이름 파일 객체 이름은 files 로 해야함
		log.info("NoticeBoardVO 확인 : {}", noticeBoard);
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		int memberId = voWrapper.getRealUser().getMemberId();
		noticeBoard.setMemberId(memberId);
		int cnt = service.insertNoticeBoard(noticeBoard,files);
		int count = cnt > 0 ? cnt : 0;
		return Integer.toString(count);
	}

	// 게시글 수정
	@ResponseBody
	@PostMapping(value = "/noticeBoardUpdate", produces = "text/plain;charset=UTF-8") // 게시판 수정 완료
	public String noticeBoardUpdate(NoticeBoardVO noticeBoard, Authentication user) {
		log.info("확인 : {}", noticeBoard);
		MemberVOWrapper voWrapper = (MemberVOWrapper) user.getPrincipal();
		int memberId = voWrapper.getRealUser().getMemberId();
		noticeBoard.setMemberId(memberId);

		int cnt = service.updateNoticeBoard(noticeBoard);
		int count = cnt > 0 ? cnt : 0;
		return Integer.toString(count);
	}

	// 게시글 삭제
	@ResponseBody
	@PostMapping(value = "/noticeBoardDelete", produces = "application/json;charset=UTF-8") // 삭제 하면 Delete 하지말고 삭제 유무에 Y로 update 하기
	public String noticeBoardDelete(@RequestBody int noticeBoardId) {
		int cnt = service.deleteNoticeBoard(noticeBoardId);
		int count = cnt > 0 ? cnt : 0;
		return Integer.toString(count);
	}
}
