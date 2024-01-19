package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;
import com.sns.timeline.domain.CardView;

@Service
public class TimelineBO {
	
	@Autowired
	private PostBO postBO;
	
	// input: X		output:List<CardView>
	// 가공하는 view를 사용할 때는 generate
	public List<CardView> generateCardViewList(){
		List<CardView> cardViewList = new ArrayList<>();
		
		// db select - post 
		// 글 목록 가져온다.
		List<PostEntity> post = postBO.getPostEntityList(); 
		
		// 글 목록 반복문 순회
		CardView cv = new CardView();
		
		for (PostEntity p : post) {
			int i = 0;
			cv.setPost(p);
			cardViewList.add(i, cv);	
			i ++;
		}
		
		return cardViewList;
	}
}
