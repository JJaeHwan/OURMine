package kr.or.ddit.ui;

import kr.or.ddit.vo.Pagination;

public class DefaultPaginationRenderer implements PaginationRenderer {
	// false가 나오면 e.prevent어쩌구 그 막아주는거랑 같은 의미
	private final String PATTERN = "<a href='?:;' onclick='return fn_paging(%d, event);'>%s</a>";
	
	@Override
	public String renderPagination(Pagination pagination) {
		int startPage = pagination.getStartPage();
		int endPage = pagination.getEndPage();
		int totalPage = pagination.getTotalPage();
		int lastPage = endPage > totalPage ? totalPage : endPage;
		int blockSize = pagination.getBlockSize();
		
		StringBuffer html = new StringBuffer();
		if(startPage > blockSize) {
			html.append(
				String.format(PATTERN, startPage - blockSize  ,"이전")
			);
		}
		
		for(int page = startPage; page <= lastPage; page++) {
			if(page == pagination.getCurrentPage()) {
				html.append(String.format("<span>%d</span>", page));
			}else {
				html.append(
						String.format(PATTERN, page, page)
						);
			}
		}
		
		if(lastPage < totalPage) {
			html.append(
				String.format(PATTERN, lastPage + 1  ,"다음")
				);
		}
		
		return html.toString();
	}

}
