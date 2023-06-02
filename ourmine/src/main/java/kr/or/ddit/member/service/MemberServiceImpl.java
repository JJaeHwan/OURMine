package kr.or.ddit.member.service;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

import kr.or.ddit.member.dao.MemberImageDAO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.company.vo.CompanyVO;
import kr.or.ddit.member.dao.MemberDAO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.projectAttend.vo.ProjectAttendVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class MemberServiceImpl implements MemberService {
	
	private final MemberDAO memberDao;
	private final MemberImageDAO memberImageDAO;
	
	@Value("#{appInfo['member.attatchPath']}")
	private String uploadDir;
	
	private final MemberEncryption memberEncryption;
	private PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	
	@Override
	@Transactional(readOnly = true)
	public List<MemberVO> memberList(int companyId) {
		return memberDao.memberList(companyId);
	}
	
	@Override
	@Transactional(readOnly = true)  // 시큐리티 조회
	public MemberVO memberSelect(String memberEmail) {
		
		return memberDao.memberSelect(memberEmail);
	}
	
	
	@Override
	public int insertMember(MemberVO member) {
		String  memberPass =  memberEncryption.encode(member.getMemberPassword());
		
		member.setMemberPassword(memberPass);
		log.info(member.getMemberPassword());
		return memberDao.insertMember(member);
	}
	
	@Override
	public int updateMember(MemberVO member, Authentication user) {
		boolean check = isCheck(member, user);
		if(!check) {
			return -1;
		}else {
			Optional.ofNullable(member.getFile()) // Optional.ifPresent 사용해서 null 아닐경우에만 밑에 코드 실행 하게함
					.ifPresent(file -> {
						String fileName = member.getSaveFileName(); // 저장할때 이미 파일명 uuid 로 변환함 vo 확인해보셈
						Path filePath = Paths.get(uploadDir, fileName);
						try  {
							
							file.transferTo(filePath.toFile()); // 여기서 파일을 복사
							
						} catch (IOException e) {
							throw new RuntimeException(e);
						}
					});
			return memberDao.updateMember(member);
		}
		
	}
	
	private boolean isCheck(MemberVO member, Authentication user) { // 입력한 비밀번호가 맞는지 체크 하는 메서드
		MemberVO memberCheck =  memberDao.memberSelect(user.getName());
		String memberPass =  member.getMemberPassword();
		String pass =  memberCheck.getMemberPassword();
		log.info("결과 : {}", encoder.matches(memberPass, pass));
		return encoder.matches(memberPass, pass);
	}
	
	@Override
	public int deleteMember(MemberVO member ,Authentication user) {
		boolean check = isCheck(member, user);
		if(!check) {
			return -1;
		}else {
			return memberDao.deleteMember(member);
		}
		
	}
	
	@Override
	public List<ProjectAttendVO> getAllAttendRole(int memberId) {
		
		return memberDao.getAllAttendRole(memberId);
	}
	
	@Override
	public int updateMemberBySubscribe(int memberId) {
		
		return memberDao.updateMemberBySubscribe(memberId);
	}
	
	@Override
	public int memberCheckSelect(MemberVO member) {
		
		return memberDao.memberCheckSelect(member);
	}
	
	
	@Override
	public int memberTelSelect(String memberTel) {
		return memberDao.memberTelSelect(memberTel);
	}
	
	@Override
	public MemberVO memberMyPageSelect(int memberId) {
		return memberDao.memberMyPageSelect(memberId);
	}
	
	@Override
	public List<MemberVO> memberOrgLvlSelect(MemberVO member) {
		return memberDao.memberOrgLvlSelect(member);
		
	}
	
	@Override
	public List<MemberVO> memberOrgLvlListSelect(MemberVO member) {
		return memberDao.memberOrgLvlListSelect(member);
	}
	
	@Override
	public List<CompanyVO> adminCompanyList() {
		return memberDao.adminCompanyList();
	}
	
	@Override
	public List<MemberVO>  adminCompanyMemberList(MemberVO member) {
		log.info("member.getCompanyId() = {}",member.getCompanyId());
		int memberCount = memberDao.adminCompanyMemberCount(member);
		List<MemberVO> memberVOS = memberDao.adminCompanyMemberList(member);
		 memberVOS.forEach(members -> members.setTotalData(memberCount));
		 return memberVOS;
	}
	
	@Override
	public int adminCompanyMemberCount(MemberVO member) {
		return memberDao.adminCompanyMemberCount(member);
	}


}
