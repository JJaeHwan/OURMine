package kr.or.ddit.company.service;

import java.util.List;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import org.springframework.security.core.Authentication;

public interface CompanyService {

	/**
	 * 전체 회사 리스트
	 * @return
	 */
	public List<CompanyVO> companyList();


	/**
     * 회사 한개의 정보를 저장
     *
     * @param company
     * @param user
     * @return
     */
	public int insertCompany(CompanyVO company, MemberVOWrapper user);


	/**
	 * 회사 한개의 정보를 수정
	 *
	 * @param company
	 * @param realUser
	 * @return
	 */
	public int updateCompany(CompanyVO company, Authentication realUser);


	/**
	 * 회사 를 삭제한다고 하면 삭제하지말고 삭제여부에 Y로 업데이트
	 * @param companyVO, user
	 * @return
	 */
	public int deleteCompany(CompanyVO companyVO, MemberVOWrapper user);


	/**
	 * 회사를 이미 등록했는지 체크
	 * @param memberId
	 * @return
	 */
	public int companyDuplicationSelect(int memberId);

	/**
	 * 자기가 속한 회사 조회
	 *
	 * @param memberId
	 * @return
	 */
	public CompanyVO myCompanySelect(int memberId);

	/**
	 *
	 * @param companyVO
	 * @return
	 */
	public List<CompanyVO> companySearch(CompanyVO companyVO);

	/**
	 *
	 * @param company
	 * @return
	 */
	public List<CompanyVO> companyMember(CompanyVO company);
}
