package kr.or.ddit.member.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.management.relation.RoleList;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.commons.auth.CompanyGrantedAuthorityImpl;
import kr.or.ddit.commons.auth.CompanyProjectGrantedAuthorityImpl;
import kr.or.ddit.commons.auth.CustomGrantedAuthorityImpl;
import lombok.Getter;
//import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
public class MemberVOWrapper extends User {

	private MemberVO realUser;

	public static List<GrantedAuthority> makeRole(MemberVO vo) {
		List<GrantedAuthority> roleList = new ArrayList<>();
		// 1개
//      ProjectAttendVO attvo = new ProjectAttendVO();

		vo.setMemberGrade("ROLE_" + vo.getMemberGrade());

		log.debug("memberGrade", vo.getMemberGrade());
		log.debug("companyId", String.valueOf(vo.getCompanyId()));

		roleList.add(new SimpleGrantedAuthority(vo.getMemberGrade()));
		roleList.add(new SimpleGrantedAuthority(String.valueOf(vo.getCompanyId())));
		
//		vo.getProAttendRole().stream().filter(item -> item.getGroupGrade().isEmpty())
//					.map(role -> new CompanyGrantedAuthorityImpl(role.getCompanyId()))
//					.forEach(item -> roleList.add(item));
//		
//		vo.getProAttendRole().stream().filter(item -> item.getGroupGrade().isEmpty())
//		.map(role -> new CompanyProjectGrantedAuthorityImpl(role.getCompanyId(), role.getProjectId()))
//		.forEach(item -> roleList.add(item));
		
		vo.getProAttendRole().stream().filter(item -> !item.getGroupGrade().isEmpty())
//               .map(role -> new CompanyGrantedAuthorityImpl(role.getCompanyId()))
				.map(role -> new CustomGrantedAuthorityImpl(role.getCompanyId(), role.getProjectId(),
						role.getGroupRole(), role.getMemberId(), role.getProjectAttendAk(), role.getProjectRoleId()
						))
				.forEach(item -> roleList.add(item));

		log.debug("roleList : {}", roleList);

		return roleList;
	}

	public MemberVO getRealUser() {
		return realUser;
	}

	public MemberVOWrapper(MemberVO realUser) {
		super(realUser.getMemberEmail(), realUser.getMemberPassword(), makeRole(realUser));
		this.realUser = realUser;
	}
}