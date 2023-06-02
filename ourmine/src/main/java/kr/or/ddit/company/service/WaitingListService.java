package kr.or.ddit.company.service;

import kr.or.ddit.company.vo.CompanyVO;

public interface WaitingListService {

	public int waitingListInsert(CompanyVO company);

	public int updateMemberStatus(CompanyVO companyVO);

	public int updateMemberRefuse(CompanyVO company);

	public int waitingListDelete(CompanyVO company);
}
