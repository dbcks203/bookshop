package com.myspring.bookshop.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.bookshop.purchase.service.PurchaseService;

@Controller
public class PurchaseController {

	@Autowired
	PurchaseService purchaseService;

	@RequestMapping(value = "/purchase/insertCart.do")
	public ResponseEntity insertCart(@RequestParam(value = "book_no", required = true) String book_no,
			@RequestParam(value = "member_id", required = true) String member_id, Locale locale, Model model)
			throws Exception {
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		String message = purchaseService.insertCart(book_no, member_id);
		ResponseEntity resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;

	}

	
	@RequestMapping(value = "/purchase/viewMemberCart.do")
	public String viewMemberCart(Model model) {
		return "purchase/viewMemberCart";
	}
	
	@RequestMapping(value = "/purchase/deleteOrder.do", method = RequestMethod.POST)
	public void viewMemberCart(@RequestBody()HashMap<String, Object> parameters) {
		purchaseService.deleteOrder(parameters);
	}
	
	@ResponseBody
	@RequestMapping(value = "/purchase/memberCartList.do",  method = RequestMethod.POST)
	public Map<String, Object> memberCartList(@RequestBody()HashMap<String, Object> parameters) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = purchaseService.getCartList(parameters);
		
		resultMap.put("status", true);
		resultMap.put("list", list);
		
		return resultMap;
	}
	
}
