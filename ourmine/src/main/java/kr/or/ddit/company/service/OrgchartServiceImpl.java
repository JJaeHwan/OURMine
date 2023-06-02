package kr.or.ddit.company.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.company.dao.OrgchartDAO;
import kr.or.ddit.company.vo.OrgchartVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class OrgchartServiceImpl implements OrgchartService{

	private final OrgchartDAO orgchartDAO;

	@Override
	@Transactional(readOnly = true)
	public List<OrgchartVO> orgchartList(int memberId) {
		return orgchartDAO.orgchartList(memberId);
	}

	@Override
	@Transactional(readOnly = true)
	public OrgchartVO orgchartSelect(int orgchartId) {
		return null;
	}

	@Override
	@Transactional(readOnly = true)
	public List<OrgchartVO> orgchartMemberList(OrgchartVO orgchart) {
		return orgchartDAO.orgchartMemberList(orgchart);
	}

	@Override
	@Transactional(readOnly = true)
	public List<OrgchartVO> orgchartAddMemberList(OrgchartVO orgchart) {
		return orgchartDAO.orgchartAddMemberList(orgchart);
	}

	@Override
	public int orgchartMemberInsert(OrgchartVO orgchart) {
		return orgchartDAO.orgchartMemberInsert(orgchart);
	}


	@Override
	public int insertOrgchart(OrgchartVO orgchart) {

		return orgchartDAO.insertOrgchart(orgchart);
	}

	@Override
	public int updateOrgchart(OrgchartVO orgchart) {
		return orgchartDAO.updateOrgchart(orgchart);
	}

	@Override
	public int deleteOrgchart(OrgchartVO orgchart) {

		return orgchartDAO.deleteOrgchart(orgchart);
	}



}
