package com.myspring.bookshop.file.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.bookshop.file.entity.ManageFile;
import com.myspring.bookshop.mybatis.mappers.BookDAO;
import com.myspring.bookshop.mybatis.mappers.ManageFileDAO;
@Service
public class FileUploadService {
	
	@Autowired
	ManageFileDAO manageFileDAO;
	@Autowired
	BookDAO bookDAO;
	
	public boolean FileSave(Map<String, String> map, List<ManageFile> list) {
		try {
			bookDAO.insertBook(map);
			for(ManageFile manageFile : list) {
				manageFile.setBook_no(Integer.parseInt(String.valueOf(map.get("book_no"))));
				manageFileDAO.insert(manageFile);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public ManageFile getManageFile(String book_no) {
		return manageFileDAO.getManageFile(book_no);
	}
}
