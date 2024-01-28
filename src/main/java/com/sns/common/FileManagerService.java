package com.sns.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class FileManagerService {

	// 학원
	// public static final String FILE_UPLOAD_PATH = "D:\\jeonsoohyun\\6_spring_project\\sns\\sns_workspace\\images/";
	
	// 집
	 public static final String FILE_UPLOAD_PATH = "D:\\spring_img\\images/";
	
	// input: File 원본, userLoginId(폴더명)		output: 이미지 경로 
	public String saveFile(String loginId, MultipartFile file) {
		String directoryName = loginId + "_" + System.currentTimeMillis();
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;
		}
		
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + "/" +  file.getOriginalFilename());
			Files.write(path, bytes); // 실제 파일 업로드
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		
		return "/images/" + directoryName + "/" + file.getOriginalFilename();
	}
	
	// input: ImagePath		output: x
	public void deleteFile(String imagePath) { ///images/sooo_1706159478390/gg.jpg
		// D:\memo_spirng_img\images/images/sooo_1706159478390/gg.jpg
		// 주소에 겹치는 /images/를 지운다.	
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
	
		// 삭제할 이미지 존재?
		if (Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				log.info("[파일 매니저 삭제] 이미지 삭제 실패. path():{}", path );
				return;
			}
			
			// 폴더 (디렉토리 삭제)
			path = path.getParent();
			if (Files.exists(path)) {
				try {
					Files.delete(path);
				} catch (IOException e) {
					log.info("[파일 매니저 삭제] 이미지 삭제 실패. path():{}", path );
					return;
				}
			}
		}
		
	
	}
}


