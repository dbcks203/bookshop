package com.myspring.bookshop.mybatis.mappers;
import com.myspring.bookshop.file.entity.ManageFile;

public interface ManageFileDAO {
	int insert(ManageFile boardFile);
	ManageFile getManageFile(String f_id);
}
