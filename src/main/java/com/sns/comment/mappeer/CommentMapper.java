package com.sns.comment.mappeer;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sns.comment.domain.Comment;

@Mapper
public interface CommentMapper {
	
	// input: userId, postId, content	// output: X
	public void insertComment(
			@Param("userId") int userId,
			@Param("postId") int postId,
			@Param("content") String content);
	
	// input: postId		output: List<Comment>
	public List<Comment> selectCommentList();
	
}
