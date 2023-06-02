package kr.or.ddit.company.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.company.vo.OrgchartVO;

@Mapper
public interface OrgchartDAO {

	public List<OrgchartVO> orgchartList(int memberId);

	public List<OrgchartVO>  orgchartAddMemberList(OrgchartVO orgchart);

	public int insertOrgchart(OrgchartVO orgchart);
	public int updateOrgchart(OrgchartVO orgchart);

	public int deleteOrgchart(OrgchartVO orgchart);

	public List<OrgchartVO> orgchartMemberList(OrgchartVO orgchart);

	public int orgchartMemberInsert(OrgchartVO orgchart);
}
