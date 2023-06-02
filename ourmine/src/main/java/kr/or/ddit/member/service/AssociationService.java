package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.project.vo.ProjectVO;

public interface AssociationService {

	/**
	 *
	 * @return
	 */
	public List<AssociationVO> associationList(AssociationVO vo);
	/**
	 *
	 * @param associationId
	 * @return
	 */
	public AssociationVO associationSelect(int associationId);
	/**
	 *
	 * @param association
	 * @return
	 */
	public int insertAssociation(AssociationVO  association);
	/**
	 *
	 * @param association
	 * @return
	 */
	public int updateAssociation(AssociationVO  association);
	/**
	 *
	 * @param company
	 * @return
	 */
	public int deleteAssociation(CompanyVO company);


	/**
	 * 회사를 삭제했을때 회사에 소속된 모든 직원을 퇴사 시킨다.
	 * @param companyId
	 * @return
	 */
	public int deleteCompanyAssociation(int companyId) ;

	///////////////// 추가 ////////////////////////

	public AssociationVO associationSelectOne(int memberId);

	public AssociationVO projectMemberList(AssociationVO vo);

	public int companyMemberInsert(CompanyVO company);
}
