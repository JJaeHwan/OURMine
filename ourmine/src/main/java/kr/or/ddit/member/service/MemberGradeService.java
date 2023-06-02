package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberGradeVO;

public interface MemberGradeService {
	
	
	/**
	 * 
	 * @return
	 */
	public List<MemberGradeVO> memberGradeList();
	
	/**
	 * 
	 * @param memberGradeId
	 * @return
	 */
	public MemberGradeVO memberGradeSelect(int memberGradeId);
	/**
	 * 
	 * @param memberGrade
	 * @return
	 */
	public int insertMemberGrade(MemberGradeVO memberGrade);
	
	/**
	 * 
	 * @param memberGrade
	 * @return
	 */
	public int updateMemberGrade(MemberGradeVO memberGrade);
	
	/**
	 * 
	 * @param memberGradeId
	 * @return
	 */
	public int deleteMemberGrade(int memberGradeId);
}
