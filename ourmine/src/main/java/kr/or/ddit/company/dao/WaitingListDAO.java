package kr.or.ddit.company.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.company.vo.CompanyVO;

@Mapper
public interface WaitingListDAO {

	public int waitingListInsert(CompanyVO company);

	public int updateMemberStatus(CompanyVO company);

	public int updateMemberRefuse(CompanyVO company);

	public int waitingListDelete(CompanyVO company);
}
