package kr.or.ddit.company.controller;


import kr.or.ddit.company.service.WaitingListService;
import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/waiting")
public class WaitingListController {

    private final WaitingListService service;


    // waitingList 테이블에 insert
    @PostMapping("/waitingInsert")
    @ResponseBody
    public int waitingInsert(@RequestBody CompanyVO company, Authentication user){
        MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
        company.setMemberId(principal.getRealUser().getMemberId());
        log.info("memberId = {}",company.getMemberId());
        return service.waitingListInsert(company);
    }
    @PostMapping("/waitingDelete")
    @ResponseBody
    public int waitingDelete(@RequestBody CompanyVO company, Authentication user) {
        MemberVOWrapper principal = (MemberVOWrapper) user.getPrincipal();
        company.setMemberId(principal.getRealUser().getMemberId());
        log.info("memberId = {}", company.getMemberId());
        return service.waitingListDelete(company);

    }
}
