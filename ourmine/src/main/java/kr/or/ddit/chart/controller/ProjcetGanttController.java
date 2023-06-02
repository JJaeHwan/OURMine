
package kr.or.ddit.chart.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.ddit.chart.vo.ProjectWorkVOWrapperForChart;
import kr.or.ddit.projectwork.service.ProjectWorkService;
import kr.or.ddit.projectwork.vo.ProjectWorkVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/company/{companyId}/project/{projectId}/projectGantt")
public class ProjcetGanttController {
	
	@Inject
	private ProjectWorkService service;
	
	@GetMapping
	public String projectGanttUi(@PathVariable int companyId, @PathVariable int projectId) {
		
		return "project/projectGantt/projectGantt";
	}
	
	
	@GetMapping(value="ganttList", produces = "application/json;charset=utf-8" )
	@ResponseBody
	public List<ProjectWorkVOWrapperForChart> getGanttList(ProjectWorkVO projectWorkVO,
											@PathVariable int companyId,
											@PathVariable int projectId
			){
		// 데이터를 가져오는 로직
		List<ProjectWorkVO> ganttList = service.pwList(projectWorkVO);
		
		List list = new ArrayList<>();
		for(ProjectWorkVO vo : ganttList) {
			Map<String, String> map = new HashMap<>();
			map.put("name",vo.getProjectWorkPic());
			map.put("x",vo.getProjectWorkTitle());
			map.put("start",vo.getProjectWorkStartDate()+"");
			map.put("end",vo.getProjectWorkEndDate()+"");
			map.put("min",vo.getProjectStartDate()+"");
			map.put("max",vo.getProjectEndDate()+"");
			list.add(map);
		}
		log.info("리스트{}@@@@@@@@@@",list);
		return list;
	}
	
}
