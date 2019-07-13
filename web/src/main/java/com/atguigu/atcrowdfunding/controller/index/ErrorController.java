package com.atguigu.atcrowdfunding.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author changchen
 * @create 2019-06-14 上午 9:15
 */
@Controller
public class ErrorController {

    @RequestMapping("/error.html")
    public String error(){
        return "error";
    }

}
