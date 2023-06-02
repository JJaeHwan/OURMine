package kr.or.ddit.company.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.company.vo.CompanyVO;

@Mapper
public interface CompanyDAO {

	public List<CompanyVO> companyList();

	public CompanyVO companySelect(int companyId);

	public int companyInsert(CompanyVO company);

	public int updatecompany(CompanyVO company);

	public int deletecompany(CompanyVO company);

	public int companyDuplicationSelect(int memberId);

	public CompanyVO myCompanySelect(int memberId);

	public List<CompanyVO> companySearch(CompanyVO companyVO);

	public List<CompanyVO> companyMember(CompanyVO company);

}
