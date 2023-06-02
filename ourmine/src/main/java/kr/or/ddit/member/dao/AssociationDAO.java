package kr.or.ddit.member.dao;

import java.util.List;

import kr.or.ddit.project.vo.ProjectVO;
import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.member.vo.AssociationVO;

@Mapper
public interface AssociationDAO {

	// pl이 프로젝트에 멤버추가할때
	public List<AssociationVO> associationList(AssociationVO vo);

	public AssociationVO associationSelectOne(int memberId);

	public AssociationVO associationSelect(int associationId);

	public int insertAssociation(AssociationVO  association);

	public int updateAssociation(AssociationVO  association);

	public int deleteAssociation(CompanyVO company);

	public int deleteCompanyAssociation(int companyId) ;

	//////////// 추가 /////////////////////

	public int companyMemberInsert(CompanyVO company);

	public AssociationVO projectMemberList(AssociationVO vo);

}
