package com.myspring.bookshop.mybatis.mappers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface PurchaseDAO {
	void insertCart(Map<String, String> parameterMap);
	List<Map<String, Object>> getCartList(Map<String, Object> parameters);
	void deleteOrder(HashMap<String, Object> parameters);
}
