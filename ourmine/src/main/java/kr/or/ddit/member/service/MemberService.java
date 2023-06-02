package kr.or.ddit.member.service;

import java.util.List;

import org.springframework.security.core.Authentication;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;

public interface MemberService {

	/**
	 * 멤버 전체 조회 회원등급이 홈페이지 관리자일경우에만 조회가능
	 * @return
	 */
	public List<MemberVO> memberList(int companyId);

	/**
	 * 검색 조건에 맞는 회원 조회 동적쿼리 필요 회원을 클릭하면 한명만 보여주고 검색조건을 추가하면 동적쿼리 실행
	 * @param memberId
	 * @return
	 */
	public MemberVO memberSelect(String memberEmail);

	/**
	 *
	 * @param member
	 * @return
	 */
	public int insertMember(MemberVO member);

	/**
	 *
	 * @param member
	 * @return
	 */
	public int updateMember(MemberVO member,Authentication user);

	/**
	 *
	 * @param memberId
	 * @return
	 */
	public int deleteMember(MemberVO member,Authentication user);

	// 어떤회사의 누가 어떤 프로젝트에 어떤 직책으로 참여중인지 알기위한 조인
	List<ProjectAttendVO> getAllAttendRole(int memberId);

	public int updateMemberBySubscribe(int memberId);

	/**
	 * 회원 이메일 중복 체크
	 * @param member
	 * @return
	 */
	public int memberCheckSelect(MemberVO member);


	/**
	 * 회원 전화번호 중복 체크
	 * @param memberTel
	 * @return
	 */
	public int memberTelSelect(String memberTel);

	/**
	 * 멤버 마이페이지 조회
	 *
	 */
	public MemberVO memberMyPageSelect(int memberId);

	public List<MemberVO> memberOrgLvlSelect(MemberVO member);

	public List<MemberVO> memberOrgLvlListSelect(MemberVO member);
	
	public List<CompanyVO> adminCompanyList(); // 설렉트 박스 회사 목록
	
	public List<MemberVO>  adminCompanyMemberList(MemberVO member); // 어드민 회원 조회
	
	public int adminCompanyMemberCount(MemberVO member); // 회원 숫자 페이지네이션 버튼



}
