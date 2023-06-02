package kr.or.ddit.codeEditor.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(of = "codeId")
@NoArgsConstructor
@AllArgsConstructor
public class CodeVO {
	
	@NotNull
	private Integer codeId;
	
	@NotNull
	private Integer codeEditorId;
	
	@NotNull
	private Integer memberId;
	
	@NotNull
	private Integer projectId;
	
	@NotNull
	private Integer companyId;
	
	private String codeContent;
	
	private String codeTitle;
}
