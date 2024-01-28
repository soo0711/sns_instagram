package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.comment.bo.CommentBO;
import com.sns.common.FileManagerService;
import com.sns.like.bo.LikeBO;
import com.sns.post.entity.PostEntity;
import com.sns.post.repository.PostRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PostBO {

	@Autowired
	private PostRepository postRepository;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	@Autowired
	private CommentBO	commentBO;
	
	@Autowired
	private LikeBO	likeBO;
	
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
	
	public void deletePostByPostId(int postId, int userId) {
		// 기존 글 가져오기
		PostEntity post = postRepository.findByIdAndUserId(postId, userId);
		if (post == null) {
			log.error("[delete post] postId:{}, userId:{}", postId, userId);
			return;
		}
		
		// 글 삭제
		postRepository.deleteById(postId);
		// postRepository.delete(post);
		
		// 이미지 있으면 삭제
		if (post.getImagePath() != null) {
			fileManagerService.deleteFile(post.getImagePath());
		}
		
		// 댓글들 삭제
		commentBO.deleteCommentByPostId(postId);
		
		// 좋아요들 삭제
		likeBO.deleteLikeByPostId(postId);
	}
}
