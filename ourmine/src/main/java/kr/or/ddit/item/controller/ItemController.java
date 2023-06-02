package kr.or.ddit.item.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.item.service.ItemService;
import kr.or.ddit.item.vo.ItemVO;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/item")
@RequiredArgsConstructor
public class ItemController {

	private final ItemService service;
	
	@GetMapping("/itemList")
	public String itemList(Model model) {
		
		return null;
	}
	@GetMapping("/{id}") // 상품 한개조회
	public String itemSelect(@PathVariable int itemId) {	
		return null;
	}
	@GetMapping("/itemJoin") // 상품 등록 폼으로 
	public String itemForm() {
		return null;
	}
	@PostMapping("/itemJoin") // 상품 등록 한당~! 
	public String itemInsert(@Validated @ModelAttribute ItemVO itemVO, BindingResult error, Model model) {
		String viewName = "";
		if(error.hasErrors()) {// 검증 실패하면 아이템폼으로 다시 보내버리기!!
			viewName = "itemForm";
			model.addAttribute("error", error);
			model.addAttribute("itemVO", itemVO);
			return viewName;
		}
		int id = itemVO.getItemId();
		viewName = "redirect/" + id ; // 성공하면 리다이렉트
		return viewName;
	}
	
	@GetMapping("/itemView") // 상품 수정 폼으로
	public String itemModifyForm() {
		return null;
	}
	
	@PostMapping("/itemView") // 상품 수정 완료 
	public String itemUpdate() {
		return null;
	}
	
	@PostMapping("/itemDelete") // 상품 삭제 하기전에 비밀번호 확인후 삭제유무 Y로 update
	public String itemDelete() { // 
		return null;
	}
	
	
}
