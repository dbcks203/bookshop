package com.myspring.bookshop.mybatis.mappers;

import java.util.List;
import java.util.Map;

import com.myspring.bookshop.purchase.entity.Book_deliveryVO;
import com.myspring.bookshop.purchase.entity.Book_orderVO;
import com.myspring.bookshop.purchase.entity.Book_paymentVO;



public interface PurchaseDAO {
	void insertCart(Map<String, String> parameterMap);
	List<Map<String, Object>> getCartList(Map<String, Object> parameters);
	Book_orderVO selectOneOrder(String order_no);
	void insertPayment(Book_orderVO book_orderVO);
	void deleteOrder(String order_no);
	String checkOverlap(String book_no);
	void increaseQuantity(String dump);
	List<Map<String, Object>> getPaymentList(Map<String, String> parameterMap);
	void updateStatus(Map<String, String> parameterMap);
	List<Book_paymentVO> getPayments(String payment_key);
	void insertDelivery(Book_paymentVO book_paymentVO);
	List<Map<String, Object>> getDeliveryList(String member_id);
	Book_deliveryVO getDelivery(String delivery_no);
}