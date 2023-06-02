package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberImageVO;

public interface MemberImageService {
	
	
	/**
	 * 
	 * @return
	 */
	public List<MemberImageVO> memberImageList();
	/**
	 * 
	 * @param memberImageId
	 * @return
	 */
	public MemberImageVO memberImageSelect(int memberImageId);
	
	/**
	 * 
	 * @param memberImage
	 * @return
	 */
	public int insertMemberImage(MemberImageVO memberImage);
	/**
	 * 
	 * @param memberImage
	 * @return
	 */
	public int updateMemberImage(MemberImageVO memberImage);
	
	/**
	 * 
	 * @param memberImageId
	 * @return
	 */
	public int deleteMemberImage(int memberImageId);
}
