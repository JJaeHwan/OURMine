package kr.or.ddit.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.member.vo.MemberGradeVO;


@Mapper
public interface MemberGradeDAO {
	
	
	public List<MemberGradeVO> memberGradeList();
	
	public MemberGradeVO memberGradeSelect(int memberGradeId);
	
	public int insertMemberGrade(MemberGradeVO memberGrade);
	
	public int updateMemberGrade(MemberGradeVO memberGrade);
	
	public int deleteMemberGrade(int memberGradeId);
}
