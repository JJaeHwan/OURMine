package kr.or.ddit.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.member.vo.MemberImageVO;

@Mapper
public interface MemberImageDAO {
	

	public List<MemberImageVO> memberImageList();
	
	public MemberImageVO memberImageSelect(int memberImageId);
	
	public int insertMemberImage(MemberImageVO  memberImage);
	
	public int updateMemberImage(MemberImageVO  memberImage);
	
	public int deleteMemberImage(int memberImageId);
}
