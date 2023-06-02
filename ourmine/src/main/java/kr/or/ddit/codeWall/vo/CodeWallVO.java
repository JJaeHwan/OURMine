package kr.or.ddit.codeWall.vo;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(of = "codewallId")
@NoArgsConstructor
public class CodeWallVO {
	
	private int rnum;
	
	@NotNull
	private Integer codewallId;
	
	@NotNull
	private Integer codeEditorId;
	
	@NotNull
	private Integer memberId;
	
	@NotNull
	private Integer projectId;
	
	@NotNull
	private Integer companyId;
	
	@NotNull
	private String codewallWriteDate;
	
	@NotNull
	private String codeTitle;
	
	private String codeContent;
	
	private String codeWallWriter;
	
	private String codeLanguage;
	
}
