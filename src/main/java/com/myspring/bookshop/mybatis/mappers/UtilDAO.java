package com.myspring.bookshop.mybatis.mappers;

import java.util.List;
import java.util.Map;

public interface UtilDAO {

	int totalCountAnd(Map<String, Object> parameters);

	List<Map<String, Object>> searchAnd(Map<String, Object> parameters);

	List<String> suggestAnd(Map<String, Object> parameters);
	
}
