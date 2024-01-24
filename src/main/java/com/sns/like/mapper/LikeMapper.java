package com.sns.like.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LikeMapper {

	// input: postId, userId	output: int
	public int selectCountLikeBypostIdUserId(
			@Param("postId") int postId,
			@Param("userId") int userId);
	
	
	// input: postId, userId	output: x
	public void insertLike(
			@Param("postId") int postId,
			@Param("userId") int userId);
	
	// input: postId, userId	output: x
	public void deleteLikeBypostIdUserId(
			@Param("postId") int postId,
			@Param("userId") int userId);
	
	// input: postId	output:int
	public int selectLikeCountByPostId(int postId);
}
