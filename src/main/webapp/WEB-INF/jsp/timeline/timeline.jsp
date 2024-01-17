<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<div class="d-flex justify-content-center">
		<div class="w-50 d-flex justify-content-center">
			<div>
				<%-- 글 쓰기 화면 --%>
				<c:if test="${not empty userId }">
					<div class="border p-2">
						<textarea cols="100" rows="4" class="border-0" placeholder="내용을 입력해주세요."></textarea>
						<div class="d-flex justify-content-between align-items-center">
							<a href="#"><img src="/static/img/img_icon.png" width="40" alt="이미지 등록 버튼"></a>
							<a href="#" class="btn btn-info">업로드</a>
						</div>
					</div>
				</c:if>
				<%-- 타임라인 화면 --%>
				<c:forEach items="${postList }" var="post">
					<div class="border mt-5">
						<div class="snsIdCss d-flex justify-content-between align-items-center w-100 px-3 bg-light">
							<h5>${post.userId }</h5>
							<a href="#"><img src="/static/img/etc_icon.png" width="20" alt="더보기 버튼"></a>
						</div>
						<img src="${post.imagePath }" alt="사진" class="w-100 p-3">
						<div class="d-flex ml-2">
							<img src="/static/img/heart-icon.png" alt="좋아요" width="30">
							<span class="ml-2">좋아요 11개</span>
						</div>
						<div class="ml-4 snsIdCss d-flex align-items-center">
							<span class="mr-2 font-weight-bold">${post.userId }</span>
							<span>${post.content }</span>
						</div>
						<div class="font-weight-bold ml-2 mb-2">댓글</div>
						<div class="border-top p-3">
							<div>
								<span class="font-weight-bold ml-2">soo : </span>
								<span>안녕하세요</span>
							</div>
							<div>
								<span class="font-weight-bold ml-2">hyun : </span>
								<span>인스타그램!!</span>
							</div>
						</div>
						<div class="border-top d-flex justify-content-between pl-2">
							<input type="text" placeholder="댓글 달기" class="border-0 form-control col-10">
							<button id="commentBtn" class="btn btn-light border-0">게시</button>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>