package kr.or.ddit.subscribe.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kr.or.ddit.item.service.ItemService;
import kr.or.ddit.item.vo.ItemVO;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.subscribe.service.SubscribeService;
import kr.or.ddit.subscribe.vo.SubscribeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/subscribe")
//@RequiredArgsConstructor
public class SubscribeController {
	
	@Named("authManager")
	@Inject
	private AuthenticationManager authenticationManager;
	
	@Inject
	private SubscribeService subService;
	
	@Inject
	private ItemService itemService;
	
	@Inject
	private MemberService memService;
	
	private IamportClient api;
	
	public SubscribeController() {
		this.api = new IamportClient("7135354773650706", "1cVULUrcLk8gbqlEJHKmlTxgIJSGq3PZLlh2PPyU3k3Rig6NDeP6P19rd5OxUHx85VYpUXbiSTEBEe0C");
	}
	
	@RequestMapping("/itemList.do")
	public String itemList(Model model){
		
		List<ItemVO> itemList = itemService.itemList();
		log.debug("itemList : {}", itemList);
		 
		model.addAttribute("itemList", itemList);
		return "manager/Subscribe";
	}
	 
	
	@ResponseBody
	@RequestMapping(value="/verifyiamport/{imp_uid}", method=RequestMethod.POST)
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session
			, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{	
		
			return api.paymentByImpUid(imp_uid);
	}
	
//	@RequestMapping(value = "/complete", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public  payComplete
	
	
	@ResponseBody
	@RequestMapping(value="/paySuccess", method=RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public int paySuccess(
			@RequestBody SubscribeVO vo
			, Authentication realUser
			) {
		SubscribeVO check = subService.subscribeSelectByMemberId(vo.getMemberId());
		log.info("구독 체크 : ", check);
		LocalDate now = LocalDate.now();
		
		vo.setSubscribeStartDate(now);
		log.info("insert 할 vo 값 : ", vo);
		int rowcnt;
		if(check==null) {
			vo.setSubscribeEndDate(now.plusDays(vo.getSubDuration()));
			rowcnt = memService.updateMemberBySubscribe(vo.getMemberId());
		}else {
			Period period = Period.between(check.getSubscribeEndDate(), check.getSubscribeStartDate());
			vo.setSubscribeEndDate(now.plusDays(vo.getSubDuration()).plusDays(period.getDays()));
			rowcnt = subService.updateSubscribeUseById(vo.getMemberId());
		}
		subService.insertSubscribe(vo);
		
		
		MemberVOWrapper user = (MemberVOWrapper) realUser.getPrincipal();
		// user.getPassword 의 경우 암호화로 인해서 유저 패스워드를 받아올 수 없는 구조로 되어있음
//		user.getRealUser().
		String pass = String.valueOf(SecurityContextHolder.getContext().getAuthentication().getCredentials());
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user.getUsername(), pass);
		Authentication auth= authenticationManager.authenticate(token);
		SecurityContextHolder.getContext().setAuthentication(auth);
		
		return rowcnt;
		
	}
}
