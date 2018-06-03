package com.chat.websocketchat.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class UserImageService {

	@Value("${user.images.path}")
	private String imagePath;
	
	public void storeUserImage(MultipartFile file,long userId) throws IOException {
		try (InputStream inputStream = file.getInputStream();
				FileOutputStream fileOutputStream = new FileOutputStream(imagePath+userId)) {
			IOUtils.copy(inputStream, fileOutputStream);
		}
	}

	public File getFile(long userId) {
		return new File(imagePath+userId);
	}
}
