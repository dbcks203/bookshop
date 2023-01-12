package com.myspring.bookshop.purchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.bookshop.mybatis.mappers.PurchaseDAO;

@Service
public class PurchaseService {

	@Autowired
	PurchaseDAO purchaseDAO;



	public String insertCart(String book_no,String member_id) {
		String message = "<script>";
		String url = "\"/bookshop/book/bookInfo.do?book_no=" + book_no + "\";";
		Map<String,String>parameterMap = new HashMap<String,String>();
		try {
			parameterMap.put("book_no", book_no);
			parameterMap.put("member_id", member_id);
			purchaseDAO.insertCart(parameterMap);
			message += " alert('장바구니에 추가 했습니다');";
		} catch (Exception e) {
			message += " alert('뭔가 잘못했습니다 다시해요');";
			e.printStackTrace();
		}
		message += "location.href=" + url + "</script>";
		return message;
	}



	public String viewMemberCart(String member_id) {
		// TODO Auto-generated method stub
		return null;
	}



	public List<Map<String, Object>> getCartList(Map<String, Object> parameters) {

		return purchaseDAO.getCartList(parameters);
	}



	public void deleteOrder(HashMap<String, Object> parameters) {
		purchaseDAO.deleteOrder(parameters);
	}

}