package kr.or.ddit.codeEditor.util;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@SuppressWarnings("serial")
public class CodeRequest implements Serializable{
	
	private int languageChoice;
	private String code;
	public int getLanguageChoice() {
		return languageChoice;
	}
	public void setLanguageChoice(int languageChoice) {
		this.languageChoice = languageChoice;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
	
}
