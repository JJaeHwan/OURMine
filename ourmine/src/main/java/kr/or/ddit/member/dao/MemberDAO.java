package kr.or.ddit.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;

@Mapper
public interface MemberDAO extends UserDetailsService {

	@Override
	default UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO member  = memberSelect(username);
		//특정 프로젝트에서 어떤 역할 -> VO나 VOWRAPPER에 저장

		// if member exists; -> if not, excute exception

//		Optional.ofNullable(member).

		if(member != null) {
			List<ProjectAttendVO> list = getAllAttendRole(member.getMemberId());

			member.setProAttendRole(list);
		};

		return new MemberVOWrapper(member);
	}


	public int memberCheckSelect(MemberVO member);

	public List<ProjectAttendVO> getAllAttendRole(int memberId);

	public List<MemberVO> memberList(int companyId);

	public MemberVO memberSelect(String memberEmail);

	public int memberTelSelect(String memberTel);

	public int insertMember(MemberVO member);

	public int updateMember(MemberVO member);

	public int updateMemberBySubscribe(int memberId);

	public int deleteMember(MemberVO member);

	public MemberVO memberMyPageSelect(int memberId);

	public List<MemberVO> memberOrgLvlSelect(MemberVO member);

	public List<MemberVO> memberOrgLvlListSelect(MemberVO member);
	
	public List<CompanyVO> adminCompanyList(); // 설렉트 박스 회사 목록
	
	public List<MemberVO> adminCompanyMemberList(MemberVO member); // 어드민 회원 조회
	
	public int adminCompanyMemberCount(MemberVO member); // 회원 숫자 페이지네이션 버튼

}
