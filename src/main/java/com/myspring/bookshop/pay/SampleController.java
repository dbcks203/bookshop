package com.myspring.bookshop.pay;


import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class SampleController {

    @RequestMapping("/pay/pay.do") 
    public String pay() {
    	 return "pay/pay";
    }
    @RequestMapping("/pay/paySuccess.do") 
    public String paySuccess() {
    	 return "pay/paySuccess";
    }
    @RequestMapping("/pay/payFail.do") 
    public String payFail() {
    	 return "pay/payFail";
    }
}