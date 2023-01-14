package com.myspring.bookshop.purchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.bookshop.mybatis.mappers.PurchaseDAO;
import com.myspring.bookshop.purchase.entity.Book_deliveryVO;
import com.myspring.bookshop.purchase.entity.Book_orderVO;
import com.myspring.bookshop.purchase.entity.Book_paymentVO;
import com.myspring.bookshop.purchase.entity.OrderReceiveVO;

@Service
public class PurchaseService {

	@Autowired
	PurchaseDAO purchaseDAO;

	public String insertCart(String book_no, String member_id) {
		String message = "<script>";
		String url = "\"/bookshop/book/bookInfo.do?book_no=" + book_no + "\";";
		Map<String, String> parameterMap = new HashMap<String, String>();
		try {
			String dump = purchaseDAO.checkOverlap(book_no);
			if (null == dump) {
				parameterMap.put("book_no", book_no);
				parameterMap.put("member_id", member_id);
				purchaseDAO.insertCart(parameterMap);
				message += " alert('장바구니에 추가 했습니다');";
			} else {
				purchaseDAO.increaseQuantity(dump);
				message += " alert('장바구니 수량을 증가 했습니다');";
			}

		} catch (Exception e) {
			message += " alert('뭔가 잘못했습니다 다시해요');";
			e.printStackTrace();
		}
		message += "location.href=" + url + "</script>";
		return message;
	}

	public List<Map<String, Object>> getCartList(Map<String, Object> parameters) {
		return purchaseDAO.getCartList(parameters);
	}

	public String purchaseBook(OrderReceiveVO orderReceiveVO) {
		try {
			boolean firstTime = true;
			String paymentKey = null;
			String orders[] = orderReceiveVO.getOrder_array();
			for (String order_no : orders) {
				Book_orderVO book_orderVO = purchaseDAO.selectOneOrder(order_no);

				if (firstTime) {
					paymentKey = order_no;
					firstTime = false;
				}
				book_orderVO.setPayment_key(paymentKey);
				purchaseDAO.deleteOrder(order_no);
				purchaseDAO.insertPayment(book_orderVO);
				
			}
			return paymentKey;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	public boolean deleteOrder(String order_no) {
		try {
			purchaseDAO.deleteOrder(order_no);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	public List<Map<String, Object>> getPaymentList(String key, String value, String status) {
		Map<String, String> parameterMap = new HashMap<String, String>();
		parameterMap.put("key", key);
		parameterMap.put("value", value);
		parameterMap.put("status",status);
		return purchaseDAO.getPaymentList(parameterMap);
	}

	public boolean completePayment(String payment_key) {
		try {
			Map<String, String> parameterMap = new HashMap<String, String>();
			parameterMap.put("key", "payment_key");
			parameterMap.put("value", payment_key);
			parameterMap.put("status", "결제완료");
			parameterMap.put("table", "book_payment");
			purchaseDAO.updateStatus(parameterMap);
			List<Book_paymentVO> list = purchaseDAO.getPayments(payment_key);
			for (Book_paymentVO book_paymentVO : list) {
				purchaseDAO.insertDelivery(book_paymentVO);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Map<String, Object>> getDeliveryList(String member_id) {
		return purchaseDAO.getDeliveryList(member_id);
	}

	public boolean cancleDelivery(String delivery_no) {
		try {
			Book_deliveryVO book_deliveryVO = purchaseDAO.getDelivery(delivery_no);
			Map<String, String> parameterMap = new HashMap<String, String>();
			parameterMap.put("key", "payment_no");
			parameterMap.put("value", book_deliveryVO.getPayment_no());
			parameterMap.put("status", "주문취소");
			parameterMap.put("table", "book_payment");
			purchaseDAO.updateStatus(parameterMap);
			
			parameterMap.put("key", "delivery_no");
			parameterMap.put("value", delivery_no);
			parameterMap.put("status", "배송취소");
			parameterMap.put("table", "book_delivery");
			purchaseDAO.updateStatus(parameterMap);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean changeDeliveryStatus(String delivery_no, String status) {
		
		try {
			Map<String, String> parameterMap = new HashMap<String, String>();
			if(status.equals("배송중"))
				parameterMap.put("status", "배송완료");
			else if(status.equals("배송준비중"))
				parameterMap.put("status", "배송중");
			parameterMap.put("key", "delivery_no");
			parameterMap.put("value", delivery_no);
			
			parameterMap.put("table", "book_delivery");
			purchaseDAO.updateStatus(parameterMap);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}