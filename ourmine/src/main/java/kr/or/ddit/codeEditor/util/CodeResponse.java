package kr.or.ddit.codeEditor.util;

public class CodeResponse {
	
	private String Result;
    private String Errors;
    private String Warnings;
    private String Stats;
    private String Files;
    
    
	public String getResult() {
		return Result;
	}
	public void setResult(String result) {
		Result = result;
	}
	public String getErrors() {
		return Errors;
	}
	public void setErrors(String errors) {
		Errors = errors;
	}
	public String getWarnings() {
		return Warnings;
	}
	public void setWarnings(String warnings) {
		Warnings = warnings;
	}
	public String getStats() {
		return Stats;
	}
	public void setStats(String stats) {
		Stats = stats;
	}
	public String getFiles() {
		return Files;
	}
	public void setFiles(String files) {
		Files = files;
	}
    
    
	
}
