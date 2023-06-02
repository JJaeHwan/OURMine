package kr.or.ddit.company.service;

import java.util.List;

import kr.or.ddit.company.vo.OrgchartVO;

public interface OrgchartService {

	/**
	 * 전체 조직도 리스트
	 * @return
	 */
	public List<OrgchartVO> orgchartList(int memberId);

	/**
	 * 조직도 한개의 정보를 조회
	 * @param companyId
	 * @return
	 */
	public OrgchartVO orgchartSelect(int orgchartId);

	/**
	 * 조직도 한개의 정보를 저장
	 * @param orgchart
	 * @return
	 */
	public int insertOrgchart(OrgchartVO orgchart);
	/**
	 * 조직도 한개의 정보를 수정
	 * @param orgchart
	 * @return
	 */
	public int updateOrgchart(OrgchartVO orgchart);
	/**
	 * 조직도 한개의 정보의 사용유무를 N으로 바꾸기
	 * @param orgchartId
	 * @return
	 */
	public int deleteOrgchart(OrgchartVO orgchart);


	/**
	 *
	 * @param orgchart
	 * @return
	 */
	public List<OrgchartVO> orgchartMemberList(OrgchartVO orgchart);

	/**
	 *
	 * @param orgchartId
	 * @return
	 */
	public List<OrgchartVO> orgchartAddMemberList(OrgchartVO orgchart);

	public int orgchartMemberInsert(OrgchartVO orgchart);
	
}
