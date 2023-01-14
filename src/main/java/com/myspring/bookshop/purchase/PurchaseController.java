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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.bookshop.purchase.entity.OrderReceiveVO;
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
	
	@RequestMapping(value = "/purchase/viewMemberPayment.do")
	public String viewMemberPayment(Model model) {
		return "purchase/viewMemberPayment";
	}
	
	@RequestMapping(value = "/purchase/viewMemberDelivery.do")
	public String viewMemberDelivery(Model model) {
		return "purchase/viewMemberDelivery";
	}
	@ResponseBody
	@RequestMapping("/purchase/deleteOrder.do")
	public Map<String, Object> deleteOrder(@RequestParam("order_no") String order_no, Model model) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status", purchaseService.deleteOrder(order_no));
		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value = "/purchase/memberCartList.do", method = RequestMethod.POST)
	public Map<String, Object> memberCartList(@RequestBody() HashMap<String, Object> parameters) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = purchaseService.getCartList(parameters);

		resultMap.put("status", true);
		resultMap.put("list", list);

		return resultMap;
	}

	@ResponseBody
	@RequestMapping("/purchase/memberPaymentList.do")
	public Map<String, Object> memberPaymentList(@RequestParam("key")String key,@RequestParam("value")String value,@RequestParam("status") String status) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = purchaseService.getPaymentList(key,value,status);
		if (null != list) {
			resultMap.put("status", true);
			resultMap.put("list", list);
		} else {
			resultMap.put("status", false);
		}
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/purchase/memberDeliveryList.do")
	public Map<String, Object> memberDeliveryList(@RequestParam("member_id") String member_id) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = purchaseService.getDeliveryList(member_id);
		if (null != list) {
			resultMap.put("status", true);
			resultMap.put("list", list);
		} else {
			resultMap.put("status", false);
		}
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/purchase/adminDeliveryList.do")
	public Map<String, Object> adminDeliveryList(@RequestParam("member_id") String member_id) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = purchaseService.getDeliveryList(member_id);
		if (null != list) {
			resultMap.put("status", true);
			resultMap.put("list", list);
		} else {
			resultMap.put("status", false);
		}
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/purchase/purchaseBook.do")
	public Map<String, Object> purchaseBook(@ModelAttribute("OrderReceiveVO") OrderReceiveVO orderReceiveVO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String paymentKey = purchaseService.purchaseBook(orderReceiveVO);
		if (null != paymentKey) {
			resultMap.put("status", true);
			resultMap.put("url", "/purchase/viewPayment.do?payment_key=" + paymentKey);
		} else {
			resultMap.put("status", false);
		}
		return resultMap;
	}
	

	@RequestMapping("/purchase/viewPayment")
	public String viewPayment(@RequestParam("payment_key") String payment_key, Model model) {
		model.addAttribute("payment_key", payment_key);
		return "purchase/viewPayment";
	}

	@RequestMapping("/purchase/successPayment")
	public String successPayment(@RequestParam("paymentKey") String paymentKey, @RequestParam("orderId") String orderId,
			@RequestParam("amount") String amount, Model model) {
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("orderId", orderId);
		model.addAttribute("amount", amount);
		return "purchase/successPayment";
	}

	@RequestMapping("/purchase/failPayment")
	public String failPayment(@RequestParam("code") String code, @RequestParam("message") String message,
			@RequestParam("orderId") String orderId, Model model) {
		model.addAttribute("code", code);
		model.addAttribute("orderId", orderId);
		model.addAttribute("message", message);
		return "purchase/failPayment";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/purchase/completePayment")
	public Map<String, Object> completePayment(@RequestParam("order_id") String orderId) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String splitKey[] = orderId.split("_");
		resultMap.put("status", purchaseService.completePayment(splitKey[1]));
		resultMap.put("url", "/member/myPageMain.do");
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/purchase/cancleDelivery.do")
	public Map<String, Object> cancleDelivery(@RequestParam("delivery_no") String delivery_no) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",purchaseService.cancleDelivery(delivery_no));
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/purchase/changeDeliveryStatus.do")
	public Map<String, Object> changeDeliveryStatus(@RequestParam("delivery_no") String delivery_no,@RequestParam("status") String status) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status",purchaseService.changeDeliveryStatus(delivery_no,status));
		return resultMap;
	}
	
	

}
