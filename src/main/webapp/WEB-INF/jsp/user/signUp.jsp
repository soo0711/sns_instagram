<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h1 class="m-4 font-weight-bold">회원가입</h1>
		<div class="bg-light p-4">
			<form id="signUpForm" method="post" action="/user/sign-up">
				<span class="sign-up-subject">ID</span>
				<%-- 인풋 옆에 중복확인 버튼을 옆에 붙이기 위해 div 만들고 d-flex --%>
				<div class="d-flex ml-3 mt-3">
					<input type="text" id="loginId" name="loginId" class="form-control col-6" placeholder="ID를 입력해주세요">
					<button type="button" id="loginIdCheckBtn" class="btn btn-primary ml-4">중복확인</button>
				</div>
				
				<%-- 아이디 체크 결과 --%>
				<div class="ml-3 mb-3">
					<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
					<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
					<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
				</div>
				
				<span class="sign-up-subject">Password</span>
				<div class="m-3">
					<input type="password" id="password" name="password" class="form-control col-6" placeholder="비밀번호를 입력하세요">
				</div>
	
				<span class="sign-up-subject">Confirm password</span>
				<div class="m-3">
					<input type="password" id="confirmPassword" name="confirmPassword" class="form-control col-6" placeholder="비밀번호를 입력하세요">
				</div>
	
				<span class="sign-up-subject">Name</span>
				<div class="m-3">
					<input type="text" name="name" id="name" class="form-control col-6" placeholder="이름을 입력하세요">
				</div>
	
				<span class="sign-up-subject">이메일</span>
				<div class="m-3">
					<input type="text" name="email" id="email" class="form-control col-6" placeholder="이메일을 입력하세요">
				</div>
				
				<br>
				<div class="d-flex justify-content-center m-3">
					<button type="submit" id="signUpBtn" class="btn btn-primary">가입하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		
		// 아이디 중복 확인
		$("#loginIdCheckBtn").on("click", function() {
			// alert("중복 확인");
		}); // - id 중복 확인
		
		// 회원가입
		$("#signUpForm").on("submit", function(e) { // form 태그에서
			e.preventDefault(); // submit 기능 막음
			// alert("회원가입");
			
			// vaildation
			let loginId = $("#loginId").val().trim();
			let password = $("#password").val();
			let confirmPassword = $("#confirmPassword").val();
			let name = $("#name").val().trim();
			let email = $("#email").val().trim();
			
			if (!loginId) {
				alert("아이디를 입력하세요");
				return false;
			}
			
			if (!password || !confirmPassword) {
				alert("비밀번호를 입력하세요");
				return false;
			}
			
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.")
				return false;
			}
			
			if (!name) {
				alert("이름을 입력해주세요.")
				return false;
			}
			
			if (!email) {
				alert("이메일을 입력해주세요.")
				return false;
			}
			
			// ajax 회원가입
			
		}); // - signUpBtn
	}); // - document
</script>