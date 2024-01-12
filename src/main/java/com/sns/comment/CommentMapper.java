package com.sns.comment;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentMapper {

	// input: X
	// output: List<Map>
	public List<Map<String, Object>> selectCommentList();
}
