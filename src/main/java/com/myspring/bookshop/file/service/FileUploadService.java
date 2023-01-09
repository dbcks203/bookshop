package com.myspring.bookshop.file.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.bookshop.file.entity.ManageFile;
import com.myspring.bookshop.mybatis.mappers.ManageFileDAO;
@Service
public class FileUploadService {
	
	@Autowired
	ManageFileDAO manageFileDAO;
	
	public void FileSave(List<ManageFile> list) {
		for(ManageFile manageFile : list) {
			manageFileDAO.insert(manageFile);
		}
	}

	public ManageFile getManageFile(String f_id) {
		return manageFileDAO.getManageFile(f_id);
	}
}
