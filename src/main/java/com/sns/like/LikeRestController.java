package com.sns.like;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sns.like.bo.LikeBO;

import jakarta.servlet.http.HttpSession;

@RestController

public class LikeRestController {
	
	@Autowired
	private LikeBO likeBO;

	// GET: /like?postId=13 @RequestParam("postId")
	// GET: /like/13		@PathVariable -> 와일드카드 문법
	@RequestMapping("/like/{postId}")
	public Map<String, Object> likeToggle(
			@PathVariable(name = "postId") int  postId,
			HttpSession session){
		// 추가 하거나 삭제 하거나의 역할	
		// 로그인 여부 확인
		Integer userId = (Integer) session.getAttribute("userId");
		
		Map<String, Object> result = new HashMap<>();
		
		if(userId == null) {
			result.put("code", 300);
			result.put("error_messgae", "로그인이 필요한 서비스입니다.");
			return result;
		}
		
		// BO 호출 -> likeToggle
		likeBO.likeToggle(postId, userId);
		
		// 응답값
		result.put("code", 200);
		result.put("result", "성공");
		
		return result;
		
	}
}
