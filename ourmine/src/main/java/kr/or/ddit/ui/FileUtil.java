package kr.or.ddit.ui;

import java.io.File;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;

import kr.or.ddit.member.vo.MemberVO;

public class FileUtil {

	private FileUtil() {
		throw new IllegalStateException("FileUtil Utility class");
	}

	public static void fileSetting(String uploadDir, MemberVO member) {

		if (member.getFile() != null && !member.getFile().isEmpty()) {
			member.setOriginalFileName(member.getFile().getOriginalFilename()); // 원래 파일명을 가져오기
			member.setFileExtension(FilenameUtils.getExtension(member.getFile().getOriginalFilename()));
			member.setSaveFileName(UUID.randomUUID().toString() + "." + member.getFileExtension()); // UUID에 파일 확장자를
																									// 추가하여 생성
			member.setMemberImageFileRoute(String.format("%s%s%s", uploadDir, File.separator, member.getSaveFileName()));
		}

	}
}
