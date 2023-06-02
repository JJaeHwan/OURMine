package kr.or.ddit.member.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.member.dao.MemberDAO;
import kr.or.ddit.member.dao.MemberGradeDAO;
import kr.or.ddit.member.vo.MemberGradeVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberGradeServiceImpl implements MemberGradeService{
	
	private final MemberGradeDAO memberGradeDAO;
	
	@Override
	@Transactional(readOnly = true)
	public List<MemberGradeVO> memberGradeList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional(readOnly = true)
	public MemberGradeVO memberGradeSelect(int memberGradeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertMemberGrade(MemberGradeVO memberGrade) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateMemberGrade(MemberGradeVO memberGrade) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMemberGrade(int memberGradeId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
