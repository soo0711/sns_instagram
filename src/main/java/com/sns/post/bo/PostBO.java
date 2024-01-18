package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.post.entity.PostEntity;
import com.sns.post.repository.PostRepository;

@Service
public class PostBO {

	@Autowired
	private PostRepository postRepository;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	// input: X		output: List<PostEntity>
	public List<PostEntity> getPostEntityList(){
		return postRepository.findAllByOrderByIdDesc();
	}
	
	// input: content, file		output: X
	public void addPostEntity(Integer userId, String userLoginId, String content, MultipartFile file) {
		String imagePath = null;
		
		// 업로드할 이미지가 있을 때 업로드
		if (file != null) {
			imagePath = fileManagerService.saveFile(userLoginId, file);
		}
		
		postRepository.save(PostEntity.builder()
							.userId(userId)
							.content(content)
							.imagePath(imagePath)
							.build());
	}
}
