package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.domain.CommentView;
import com.sns.like.bo.LikeBO;
import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;
import com.sns.timeline.domain.CardView;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

import jakarta.servlet.http.HttpSession;

@Service
public class TimelineBO {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired 
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	// input: userId(비로그인: null, 로그인: userId)		output:List<CardView>
	// 가공하는 view를 사용할 때는 generate
	public List<CardView> generateCardViewList(Integer userId){
		
		List<CardView> cardViewList = new ArrayList<>();
		
		// db select - post 
		// 글 목록 가져온다.
		List<PostEntity> postList = postBO.getPostEntityList(); 
		
		// 글 목록 반복문 순회
		for (PostEntity post : postList) {
			// post 하나에 대응되는 하나의 카드를 만든다.
			CardView cardview = new CardView();
			
			// 글 1개
			cardview.setPost(post);
			
			// 글쓴이 정보
			UserEntity user = userBO.getUserEntityById(post.getUserId());
			cardview.setUser(user);
			
			// 댓글들
			List<CommentView> commentList = commentBO.generateCommentViewListByPost(post.getId());
			cardview.setCommentList(commentList);
			
			// 좋아요 개수
			int likeCount = likeBO.getLikeCountByPostId(post.getId());
			cardview.setLikeCount(likeCount);
			
			// 로그인된 사람이 좋아요를 했는지 여부(비로그인 여부)
			// 깔끔하게 하기위해서 if문을 BO에서
			boolean filledLike = likeBO.getLikeCountByPostIdByUserId(post.getId(), userId);
			cardview.setFilledLike(filledLike);
			
			// ★★★★★★ 마지막에 cardView를 list에 넣는다.
			cardViewList.add(cardview);	
		}
		
		return cardViewList;
	}
}
