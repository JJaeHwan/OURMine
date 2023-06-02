package kr.or.ddit.file.vo;

import java.io.Serializable;
import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "boardFileId")
public class FileVO implements Serializable{
	private Integer boardFileId;
	
	private Integer boardId;
	
	private Integer fileCategoryId;
	
	private String originalFileName;
	
	private String saveFileName;
	
	private String fileRoute;
	
	@DateTimeFormat(iso = ISO.DATE)// parsing 설정 String -> LocalDateTime
	@JsonFormat(shape = Shape.STRING)
	private LocalDate fileCreateDate;
	
	private String fileExtension;
	
	private String boardWriter;
	
}
