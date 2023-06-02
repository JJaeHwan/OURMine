package kr.or.ddit.advice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorController {

    @RequestMapping("/error-500")
    public String handle500() {
        return "errorPage/error-500";
    }

    @RequestMapping("/error-404")
    public String handle404() {
        return "errorPage/error-404";
    }
}