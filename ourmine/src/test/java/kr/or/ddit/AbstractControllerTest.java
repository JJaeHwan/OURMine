package kr.or.ddit;


import javax.inject.Inject;

import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
@ContextHierarchy({
	@ContextConfiguration("file:src/main/resources/kr/or/ddit/spring/*-context.xml")
	,@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/*-context.xml")
})
@WebAppConfiguration
public abstract class AbstractControllerTest {
	
	@Inject
	private WebApplicationContext context;
	
	protected MockMvc mockMvc;
	
	@Before
	public void setUp() throws Exception {
		 mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
}
