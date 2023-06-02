package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.ui.DefaultPaginationRenderer;
import kr.or.ddit.ui.PaginationRenderer;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * 페이징 처리에 필요한 속성들을 정의한 객체.
 *
 */
@Getter
@NoArgsConstructor
public class Pagination<T> implements Serializable{
	
	public Pagination(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	private int totalRecord; // DB
	
	private int screenSize=10;
	private int blockSize=5;
	
	private int currentPage; // parameter
	
	private int totalPage;
	
	private int startRow;
	private int endRow;
	
	private int startPage;
	private int endPage;
	
	@JsonIgnore
	private transient PaginationRenderer renderer = new DefaultPaginationRenderer();
	
	private List<T> dataList;
	
	private SimpleCondition simpleCondition; // 단순 키워드 검색 조건.
	private T detailCondition; // 상세 검색.
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		totalPage = (totalRecord+(screenSize-1)) / screenSize;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * screenSize;
		startRow = endRow - (screenSize - 1);
		
		endPage = ((currentPage+(blockSize-1))/blockSize) * blockSize;
		startPage = endPage - (blockSize - 1);
	}
	
	
	public void setRenderer(PaginationRenderer renderer) {
		this.renderer = renderer;
	}
	
	public String getPagingHTML() {
		return renderer.renderPagination(this);
	}
	
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	
	public void setSimpleCondition(SimpleCondition simpleCondition) {
		this.simpleCondition = simpleCondition;
	}
	
	public void setDetailCondition(T detailCondition) {
		this.detailCondition = detailCondition;
	}
}






















