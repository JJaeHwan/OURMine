package kr.or.ddit.codeEditor.util;

public class CodeRequestBody {
	private int LanguageChoice;
    private String Program;
    private String Input;
    private String CompilerArgs;
	
    
    public CodeRequestBody(int languageChoice, String code) {
		super();
		LanguageChoice = languageChoice;
		Program = code;
		Input = "";
		CompilerArgs = "";
	}


	public int getLanguageChoice() {
		return LanguageChoice;
	}


	public void setLanguageChoice(int languageChoice) {
		LanguageChoice = languageChoice;
	}


	public String getProgram() {
		return Program;
	}


	public void setProgram(String program) {
		Program = program;
	}


	public String getInput() {
		return Input;
	}


	public void setInput(String input) {
		Input = input;
	}


	public String getCompilerArgs() {
		return CompilerArgs;
	}


	public void setCompilerArgs(String compilerArgs) {
		CompilerArgs = compilerArgs;
	}
    
    
    
}
