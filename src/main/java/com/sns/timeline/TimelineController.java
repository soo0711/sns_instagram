package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;

@Controller
@RequestMapping("/timeline")
public class TimelineController {

	@Autowired
	private PostBO postBO;
	
	@GetMapping("/timeline-view")
	public String timelineView(
			Model model) {
		
		// DB select
		List<PostEntity> postList = postBO.getPostEntityList();
		
		// timeline에 select 넘기기
		model.addAttribute("postList", postList);
		
		// template에 timeline 화면 넘기기
		model.addAttribute("viewName","timeline/timeline");
		
		return "template/layout";
	}
}
