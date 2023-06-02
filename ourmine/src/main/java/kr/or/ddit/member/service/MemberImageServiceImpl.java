package kr.or.ddit.member.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.member.dao.MemberDAO;
import kr.or.ddit.member.dao.MemberImageDAO;
import kr.or.ddit.member.vo.MemberImageVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberImageServiceImpl implements MemberImageService{

	private final MemberImageDAO memberImageDAO;
	
	@Override
	public List<MemberImageVO> memberImageList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberImageVO memberImageSelect(int memberImageId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertMemberImage(MemberImageVO memberImage) {
		
		return memberImageDAO.insertMemberImage(memberImage);
	}

	@Override
	public int updateMemberImage(MemberImageVO memberImage) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMemberImage(int memberImageId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
