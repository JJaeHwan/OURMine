package kr.or.ddit.company.service;

import java.util.List;


import kr.or.ddit.member.dao.MemberDAO;
import kr.or.ddit.member.vo.AssociationVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.company.dao.CompanyDAO;
import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.member.dao.AssociationDAO;
import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class CompanyServiceImpl implements CompanyService{

	private final CompanyDAO companyDAO;
	private final AssociationDAO associationDAO;
	private final MemberDAO memberDAO;
	private PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();

	@Override
	@Transactional(readOnly = true)
	public List<CompanyVO> companyList() {
		return companyDAO.companyList();
	}


	@Override
	@Transactional(readOnly = true)
	public int companyDuplicationSelect(int memberId) {
		return companyDAO.companyDuplicationSelect(memberId);
	}

	@Override // 자신이 속한 회사 조회
	@Transactional(readOnly = true)
	public CompanyVO myCompanySelect(int memberId) {
		return companyDAO.myCompanySelect(memberId);
	}

	@Override
	public List<CompanyVO> companySearch(CompanyVO company) {
		return companyDAO.companySearch(company);
	}

	@Override
	public int insertCompany(CompanyVO company, MemberVOWrapper user) {
		int memberId = user.getRealUser().getMemberId();
		int companyCount = companyDAO.companyDuplicationSelect(memberId); // 이미 회사를 등록했는지 체크
		if(companyCount > 0){
			return -2; // 이미 한개를 등록했으면 등록하지 못하게 return
		}else{
			companyDAO.companyInsert(company);
			int companyId = company.getCompanyId();
			AssociationVO associationVO = new AssociationVO();
			associationVO.setMemberId(memberId);
			associationVO.setCompanyId(companyId);
			return associationDAO.insertAssociation(associationVO);
		}

	}

	@Override
	public int updateCompany(CompanyVO company, Authentication user) {
		boolean check = isCheck(company,  user);
		if(!check){
			return -1;
		}else{
			return companyDAO.updatecompany(company);
		}

	}

	@Override
	public int deleteCompany(CompanyVO company, MemberVOWrapper realUser) {
		boolean check = isCheck(company, (Authentication) realUser);
		if(!check){
			return -1;
		}else{
			companyDAO.deletecompany(company);
			return associationDAO.deleteCompanyAssociation(company.getCompanyId());
		}

	}


	private boolean isCheck(CompanyVO company, Authentication user) { // 입력한 비밀번호가 맞는지 체크 하는 메서드
		MemberVO memberCheck =  memberDAO.memberSelect(user.getName());
		String password = company.getMemberPassword();
		String memberPassword = memberCheck.getMemberPassword();
		log.info("결과 : {}", encoder.matches(password, memberPassword));
		return encoder.matches(password, memberPassword);
	}


	@Override
	public List<CompanyVO> companyMember(CompanyVO company) {
		
		return companyDAO.companyMember(company);
	}


}
