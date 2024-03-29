<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<div class="d-flex justify-content-center">
		<div class="w-50 d-flex justify-content-center">
			<div class="w-100">
				<%-- 글 쓰기 화면 --%>
				<c:if test="${not empty userId }">
					<div class="border p-2">
						<textarea id="writeTextArea" placeholder="내용을 입력해주세요" rows="5"class="w-100 border-0"></textarea>
						<div class="d-flex justify-content-between">
							<div class="d-flex align-items-center">
								<%-- file 태그를 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것과 같은 효과--%>
								<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif" class="d-none">
								
								<%-- 이미지에 마우스를 올리면 커서가 변하도록 적용 --%>
								<a href="#" id="fileUploadBtn"><img src="/static/img/img_icon.png" width="40" alt="이미지 등록 버튼"></a>
								
								<%-- 업로드 된 임시 이미지 파일 이름 나타내는 곳 --%>
								<div id="fileName" class="ml-2"></div>
							</div>
							<a href="#" id="writeBtn" class="btn btn-info">업로드</a>
						</div>
					</div>
				</c:if>
				<%-- 타임라인 화면 --%>
				<c:forEach items="${cardViewList }" var="card">
					<div class="border mt-5">
						<div class="snsIdCss d-flex justify-content-between align-items-center w-100 px-3 bg-light">
							<h5>${card.user.loginId }</h5>
							<%-- (더보기 ... 버튼) 로그인 된 사람과 글쓴이 정보가 일치할 때 노출 --%>
							<c:if test="${userId eq card.post.userId }">
							<a href="#" class="more-btn" data-toggle="modal" data-target="#modal" data-post-id="${card.post.id }">
								<img src="/static/img/etc_icon.png" width="20" alt="더보기 버튼">
							</a>
							</c:if>
						</div>
						<img src="${card.post.imagePath }" alt="사진" class="p-3 w-100" > 
						<div class="d-flex ml-2">
							<c:if test="${card.filledLike}">
							<a href="#" class="is-heart" data-post-id="${card.post.id }">
								<img src="/static/img/fill-heart-icon.png" alt="좋아요" width="30" id="heartIcon">
							</a>
							</c:if>
							<c:if test="${!card.filledLike}">
							<a href="#" class="is-heart" data-post-id="${card.post.id }">
								<img src="/static/img/heart-icon.png" alt="좋아요" width="30" id="filledHeart">
							</a>
							</c:if>
							<span class="ml-2">좋아요 ${card.likeCount }개</span>
						</div>
						<div class="ml-4 snsIdCss d-flex align-items-center">
							<span class="mr-2 font-weight-bold">${card.user.loginId }</span>
							<span>${card.post.content }</span>
						</div>
						<%-- 댓글 쓰기 --%>
							<div class="font-weight-bold ml-2 mb-2">댓글</div>
							<div class="border-top p-2">
								<c:forEach items="${card.commentList }" var="commentView">
								<div class="my-2 d-flex justify-content-between">
										<div>
										<span class="font-weight-bold ml-2">${commentView.user.loginId } : </span>
										<span class="ml-2">${commentView.comment.content }</span>
										</div>
										<c:if test="${userId eq commentView.comment.userId}">
										<span class="mr-2"><a href="#" class="comment-del-btn" data-comment-id="${commentView.comment.id }">x</a></span>
										</c:if>
								</div>
								</c:forEach>
							</div>
							<div class="border-top d-flex justify-content-between pl-2">
								<input type="text" placeholder="댓글 달기" class="border-0 form-control col-10">
								<button type="button" class="comment-btn btn btn-light border-0" data-user-id="${userId }" data-post-id="${card.post.id }">게시</button>
							</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-post-id="">
	<%-- 
		modal-sm: 작은 모달창
		modal-dialog-centerd: 수직 기준 가운데 위치
	 --%>
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content text-center">
			<div class="py-3 border-bottom">
      			<a href="#" id="postDelete">삭제하기</a>
      		</div>
			<div class="py-3">
				<%-- data-dismiss="modal": 창 닫기 --%>
      			<a href="#" data-dismiss="modal">취소하기</a>
      		</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 파일 이미지 클릭 => 숨겨져 있는 id="file" 동작시킨다.
		$("#fileUploadBtn").on("click", function(e) {
			e.preventDefault(); // a 태그의 기본 동작 멈춤 (스크롤 위로 올라감)
			$("#file").click(); // input file을 클릭한 효과
		}); // - fileuploadbtn
		
		// 사용자가 이미지를 선택하는 순간 유효성 확인 및 업로드 된 파일명 노출
		$("#file").on("change", function(e) {
			// alert("이미지 선택");
			// 취소를 누를 때 비어있는 경우 처리
			let file = e.target.files[0];
			if (file == null) {
				$("file").val(""); // 파일 태그 파일 제거 (보이지 않지만 업로드 될 수 있으므로 주의)
				$("#fileName").text(""); // 보여지는 파일명 비우기
				return;
			}
			
			let fileName = e.target.files[0].name; // gg.jpg
			console.log(fileName);
			
			// 확장자 유효성 체크
			let ext = fileName.split(".").pop().toLowerCase();
			// alert(ext);
			if (ext != "jpg" && ext != "jpeg" && ext != "png" && ext != "gif"){
				alert("이미지만 업로드 할 수 있습니다.")
				$("file").val(""); // 파일 태그 파일 제거 (보이지 않지만 업로드 될 수 있으므로 주의)
				$("#fileName").text(""); // 보여지는 파일명 비우기
				return;
			}
			
			// 유효성 통과한 이미지의 경우 파일명 노출
			$("#fileName").text(fileName);
			
		}); // - 이미지 선택 순간
		
		// 글쓰기
		$("#writeBtn").on("click", function() {
			// alert("게시 버튼");
			
			// 글 내용
			let content = $("#writeTextArea").val();
			
			// 이미지
			let imagePath = $("#file").val();
			
			if (!imagePath) {
				alert("이미지를 등록해주세요.");
				return;
			}
			
			// 이미지 확장자 체크
			// 확장자 유효성 체크
			let ext = imagePath.split(".").pop().toLowerCase();
			// alert(ext);
			if (ext != "jpg" && ext != "jpeg" && ext != "png" && ext != "gif"){
				alert("이미지만 업로드 할 수 있습니다.")
				$("file").val(""); // 파일 태그 파일 제거 (보이지 않지만 업로드 될 수 있으므로 주의)
				$("#fileName").text(""); // 보여지는 파일명 비우기
				return;
			}
			
			// form 태그를 js에서 만든다.
			// 이미지를 업로드 할 때는 반드시 form 태그가 있어야 한다.
			let formData = new FormData();
			formData.append("content", content);
			formData.append("file", $("#file")[0].files[0]);
			
			
			// ajax
			$.ajax ({ // request
				type: "POST"
				, url: "/post/create"
				, data: formData
				, enctype: "multipart/form-data"
				, processData: false
				, contentType: false
				
				// response
				, success: function(data) {
					if (data.code == 200){
						alert("글이 등록 되었습니다.")
						location.href="/timeline/timeline-view";
					} else {
						alert(data.error_message);
					}
				}
				
				, error: function(request, status, error){
					alert("글을 저장하는데 실패했습니다. 관리자에게 문의 주세요.")
				}
				
			}) // - ajax
			
		});
		
		$(".comment-btn").on("click", function() {
			// alert("댓글 쓰기");
			let userId = $(this).data("user-id");
			// alert(userId);
			if (!userId){
				// 비로그인이면 로그인 화면 이동
				alert("로그인을 해주세요.");
				location.href="/user/sign-in-view";
				return;
			}
			
			// 글 번호
			let postId = $(this).data("post-id");
			// alert(postId);
			
			// 댓글 내용 가져오기 
			// 1) 이전 태그 값 가져오기
			// let content = $(this).prev().val(); //하나 전 태그 -> input

			
			// 2) 형제 태그 중 input 값 가져오기
			let content = $(this).siblings("input").val().trim();
			//alert(content);
			
			
			$.ajax ({ // request
				type: "POST"
				, url: "/comment/create"
				, data: {"postId" : postId, "content" : content}
			
				// response
				, success: function(data) {
					if (data.code == 200){
						alert("댓글 등록 완료!");
						location.reload(true);
					} else {
						alert(data.errror_message);
					}
				}
				, error: function(request, status, error){
					alert("댓글 등록에 실패했습니다. 관리자에게 문의 바랍니다.")
				}
				
			}); // - comment ajax
		}); // - comment
		

		$(".comment-del-btn").on("click", function(e) {
			e.preventDefault();
			if (confirm("댓글 삭제")){
				// ajax
				let commentId = $(this).data("comment-id");
				// alert(commentId);
				$.ajax({ // request
					type: "DELETE"
					, url: "/comment/delete"
					, data: {"commentId" : commentId}
				
					// response
					, success: function(data) {
						if (data.code == 200){
							alert("댓글이 삭제 되었습니다.")
							location.reload(true);
						} else {
							alert(data.error_message);
						}
					}
					, error: function(reqeust, status, error){
						alert("댓글 삭제에 실패했습니다. 관리자에게 문의주세요.")
					}
				}); // - comment delete ajax
			}
		}); // - delete comment
		
		// 좋아요 토글
		$(".is-heart").on("click", function(e){
			e.preventDefault();
			// alert("좋아요");
			let postId = $(this).data("post-id");
			// console.log(postId);
			$.ajax({
				url: "/like/" + postId  // /like/13
			
				, success: function(data){
					if (data.code == 200){
						// 토글만 하는 곳
						location.reload(true);
					} else if(data.code == 300){
						alert(data.error_messgae);
						location.href="/user/sign-in-view";
					}
				}
				, error: function(request, status, error){
					alert("좋아요를 하는데 실패했습니다. 관리자에게 문의해주세요.");
				}
			}); // -ajax
			
		}); // - heart
		
		$(".more-btn").on("click", function(e) {
			e.preventDefault(); // a 태그 올라가는 현상 방지
			// alert("더보기 버튼 클릭");
			let postId = $(this).data("post-id"); 	// getting
			// alert(postId);
			
			// 1개로 존재하는 모달에 재활용을 위해 data-post-id를 심는다. (...을 누를때 마다)
			$("#modal").data("post-id", postId) 	//setting
			
		}); // - morebtn
		
		// 모달 안에 있는 삭제하기 클릭
		$("#modal #postDelete").on("click", function(e){
			e.preventDefault();
			// alert("삭제하기");
			
			let postId = $("#modal").data("post-id");
			// alert(postId);
			
			$.ajax({
				type: "DELETE"
				, url: "/post/delete"
				, data: {"postId" : postId}
			
				, success: function(data) {
					if (data.code == 200){
						alert("삭제 되었습니다.");
						location.reload(true);
					} else {
						alert(data.error_message);
						location.href = "/user/sign-in-view";
					}
				}
				, error (request, status, error){
					alert("글 삭제에 실패했습니다. 관리자에게 문의주세요.")
				}
			}) // - delete
			
		}); // - delete plus btn
	
	}); // - document
</script>