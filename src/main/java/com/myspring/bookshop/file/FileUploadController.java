package com.myspring.bookshop.file;

import java.io.File;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.myspring.bookshop.file.entity.ManageFile;
import com.myspring.bookshop.file.service.FileUploadService;

import net.coobird.thumbnailator.Thumbnails;

/**
 * Handles requests for the application home page.
 */
@Controller
public class FileUploadController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);

	@RequestMapping(value = "/fileUploadForm.do", method = RequestMethod.GET)
	public String fileUploadForm() {
		return "/file/uploadForm";
	}
	
	@RequestMapping(value = "/image.do")
	public String image() {
		return "/file/image";
	}
	
	@Autowired
	FileUploadService fileUploadService;
	
	@RequestMapping(value = "/fileUpload.do", method = RequestMethod.POST)
	public String fileUpload(MultipartHttpServletRequest multipartRequest,
			HttpServletResponse response,
			Model model) throws Exception {
		multipartRequest.setCharacterEncoding("UTF-8");
		Map<String, String> map = new HashMap<String, String>();
		Enumeration<?> e = multipartRequest.getParameterNames();
		while(e.hasMoreElements()) {
			String key = (String) e.nextElement();
			map.put(key, new String(multipartRequest.getParameter(key).getBytes("ISO8859-1"), "EUC-KR"));
		}
		logger.info("map -> " + map);
		
		Iterator<String> fileNames = multipartRequest.getFileNames();
		List<ManageFile> manageFileList = new ArrayList<ManageFile>();
		
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			logger.info("fileName : " + fileName);
			
			MultipartFile mFile = multipartRequest.getFile(fileName);
			logger.info("ContentType = " + mFile.getContentType());
			logger.info("OriginalFilename = " + mFile.getOriginalFilename());
			logger.info("size = " + mFile.getSize());
			if (mFile.getSize() == 0) continue;
			String realName = String.valueOf(System.nanoTime());
			String thumbnail = "thumbnail_" + String.valueOf(System.nanoTime());
			String contentType = mFile.getContentType().toLowerCase();
			ManageFile manageFile = ManageFile.builder()
					.number(1)
					.content_type(contentType)
					.org_name(mFile.getOriginalFilename())
					.real_name(realName)
					.length(BigInteger.valueOf(mFile.getSize()))
					.build();
			
			manageFileList.add(manageFile);
			
			File file = new File("C:\\upload\\" + realName);
			mFile.transferTo(file);
			
			if (contentType.contains("image")) {
				manageFile.setThumbnail(thumbnail + ".png");
				File thumbFile = new File(String.valueOf("C:\\upload\\" + thumbnail));
				Thumbnails.of(file).size(50,50).outputFormat("png").toFile(thumbFile);
			}
			
		}
		fileUploadService.FileSave(manageFileList);
		model.addAttribute("manageFileList", manageFileList);
		
		return "/file/result";
	}
	
	
}
