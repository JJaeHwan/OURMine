package kr.or.ddit.codeEditor.vo;

import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "codeEditorId")
public class CodeEditorVO {
	
	@NotNull
	private Integer codeEditorId;
	
	@NotNull
	private String codeLanguage;
	
	@NotNull
	private String codeMain;
	
}
