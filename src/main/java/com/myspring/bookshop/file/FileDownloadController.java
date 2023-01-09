package com.myspring.bookshop.file;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.myspring.bookshop.file.entity.ManageFile;
import com.myspring.bookshop.file.service.FileUploadService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class FileDownloadController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileDownloadController.class);
	
	@Autowired
	FileUploadService fileUploadService;
	
	
	
	@RequestMapping(value = "/file/image.do")
	public String image(Locale locale, Model model) {
		return "/file/image";
	}
	@RequestMapping(value = "/file/result.do")
	public String result(Locale locale, Model model) {
		return "/file/result";
	}
	@RequestMapping(value = "/file/uploadForm.do")
	public String uploadForm(Locale locale, Model model) {
		return "/file/uploadForm";
	}
	@RequestMapping(value = "/fileDownload.do", method = RequestMethod.GET)
	public void fileDownload(@RequestParam("book_no") String book_no, HttpServletResponse response) 
		throws Exception  {
		ManageFile manageFile = fileUploadService.getManageFile(book_no);
		if (manageFile != null) {
			response.setHeader("Cache-Control", "no-cache");
			response.setContentLength(manageFile.getLength().intValue());
			response.addHeader("Content-disposition", "attachment; fileName=" + manageFile.getOrg_name());
			BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
			BufferedInputStream in = new BufferedInputStream(new FileInputStream("c:\\upload\\" + manageFile.getReal_name()));
			
			byte [] data = new byte[4096];
			int count = 0;
			while(true) {
				count = in.read(data);
				if (count <= 0) break;
				out.write(data);
			}
			out.close();
			in.close();
		}
		
	}
	
	@RequestMapping(value = "/thumbnail.do", method = RequestMethod.GET)
	public void thumbnail(@RequestParam("book_no") String book_no, HttpServletResponse response) 
		throws Exception  {
		ManageFile manageFile = fileUploadService.getManageFile(book_no);
		if (manageFile != null) {
			response.setHeader("Cache-Control", "no-cache");
			response.addHeader("Content-disposition", "attachment; fileName=" + manageFile.getThumbnail());
			BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
			BufferedInputStream in = new BufferedInputStream(new FileInputStream("c:\\upload\\" + manageFile.getThumbnail()));
			
			byte [] data = new byte[4096];
			int count = 0;
			while(true) {
				count = in.read(data);
				if (count <= 0) break;
				out.write(data);
			}
			out.close();
			in.close();
		}
		
	}
}
