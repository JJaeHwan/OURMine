package kr.or.ddit.item.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.item.service.ItemStatisticsService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/itemStatistics")
@RequiredArgsConstructor
public class ItemStatisticsController {

	private final ItemStatisticsService service;
	

	@GetMapping("/itemStatisticsList") // 상품 통계 전체 리스트
	public String boardList() {
		return null;
	}
	
	@GetMapping("/{itemStatisticsId}") // 상품 통계 한개 조회
	public String boardSelect(@RequestParam String searchParam,@PathVariable int itemStatisticsId) {
		return null;
	}
	

}
