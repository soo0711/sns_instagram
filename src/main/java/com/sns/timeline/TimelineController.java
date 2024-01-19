package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.domain.Comment;
import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;
import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.domain.CardView;

@Controller
@RequestMapping("/timeline")
public class TimelineController {
	
	@Autowired
	private TimelineBO timelineBO;
	
	@GetMapping("/timeline-view")
	public String timelineView(
			Model model) {
		
		// 용량이 많아지면 비효율적
		// DB select - post 
		// List<PostEntity> postList = postBO.getPostEntityList();
		
		// timeline에 select 넘기기
		// model.addAttribute("postList", postList);
		
		// DB select - comment
		// List<Comment> commentList = commentBO.getCommentList();
		// model.addAttribute("commentList", commentList);
		
		List<CardView> cardViewList = timelineBO.generateCardViewList(); 
		
		model.addAttribute("cardViewList",cardViewList);
		
		// template에 timeline 화면 넘기기
		model.addAttribute("viewName","timeline/timeline");
		
		return "template/layout";
	}
	
}
