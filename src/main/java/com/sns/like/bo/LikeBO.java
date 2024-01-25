package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.mapper.LikeMapper;

@Service
public class LikeBO {

	@Autowired
	private LikeMapper likeMapper;
	
	// input: postId, userId	output: X
	public void likeToggle(int postId, int userId) {
		// like가 있으면
		if(likeMapper.selectLikeCountByPostIdOrUserId(postId, userId) > 0) {
			// -- 삭제
			likeMapper.deleteLikeBypostIdUserId(postId, userId);
		} else {
			// 없으면
			// -- 추가
			likeMapper.insertLike(postId, userId);
		}
	}
	
	// input: postId	output:int
	public int getLikeCountByPostId(int postId) {
		return likeMapper.selectLikeCountByPostIdOrUserId(postId, null);
	}
	
	// input: postId, userId(null or)	output: boolean
	public boolean getLikeCountByPostIdByUserId(int postId, Integer userId) {
		// 비로그인이면 무조건 빈하트 => false
		if (userId == null) {
			return false;
		}
		
		// 로그인		select가 0보다 크면(1이면) 채운다, 그렇지않으면 false
		return likeMapper.selectLikeCountByPostIdOrUserId(postId, userId) > 0;
		
	}
}
