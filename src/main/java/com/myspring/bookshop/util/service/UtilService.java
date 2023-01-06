package com.myspring.bookshop.util.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.myspring.bookshop.mybatis.mappers.UtilDAO;

@Service
public class UtilService {

	
	@Autowired
	UtilDAO utilDAO;
	
	
	
	public List<String> suggestAnd(Map<String, Object> parameters) {

		return utilDAO.suggestAnd(parameters);
	}
	
	public int totalPageNoAnd(Map<String, Object> parameters) {

		return utilDAO.totalCountAnd(parameters);
	}

	public List<Map<String, Object>> searchAnd(Map<String, Object> parameters) {

		return utilDAO.searchAnd(parameters);
	}

}