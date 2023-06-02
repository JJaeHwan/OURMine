package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.company.dao.WaitingListDAO;
import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.project.vo.ProjectVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.member.dao.AssociationDAO;
import kr.or.ddit.member.vo.AssociationVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class AssociationServiceImpl implements AssociationService{

	private final AssociationDAO associationDAO;
	private final WaitingListDAO waitingListDAO;

	@Override
	@Transactional(readOnly = true)
	public List<AssociationVO> associationList(AssociationVO vo) {
		return associationDAO.associationList(vo);
	}

	@Override
	@Transactional(readOnly = true)
	public AssociationVO associationSelect(int associationId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertAssociation(AssociationVO association) {
		return associationDAO.insertAssociation(association);
	}

	@Override
	public int updateAssociation(AssociationVO association) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteAssociation(CompanyVO company) {
		return associationDAO.deleteAssociation(company);
	}

	@Override
	public int deleteCompanyAssociation(int companyId) {
		return associationDAO.deleteCompanyAssociation(companyId);
	}

	@Override
	public AssociationVO associationSelectOne(int memberId) {
		return associationDAO.associationSelectOne(memberId);

	}

	@Override
	public AssociationVO projectMemberList(AssociationVO vo) {
		return associationDAO.projectMemberList(vo);
	}


	@Override
	public int companyMemberInsert(CompanyVO company) {
		associationDAO.companyMemberInsert(company);
		return waitingListDAO.updateMemberStatus(company);
	}


}
