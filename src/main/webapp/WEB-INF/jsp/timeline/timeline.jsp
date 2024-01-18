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
				<c:forEach items="${postList }" var="post">
					<div class="border mt-5">
						<div class="snsIdCss d-flex justify-content-between align-items-center w-100 px-3 bg-light">
							<h5>${post.userId }</h5>
							<a href="#"><img src="/static/img/etc_icon.png" width="20" alt="더보기 버튼"></a>
						</div>
						<img src="${post.imagePath }" alt="사진" class="p-3" width="800"> 
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
			
		})
		
	}); // - document
</script>