<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="h-100 d-flex justify-content-between align-items-center">
	<%-- logo --%>
	<div class="ml-4">
		<h1>Instagram</h1>
	</div>
	
	<%-- 로그인 정보 --%>
	<div class="mr-4">
		<span>${userName }님 안녕하세요</span>
		<a href="/user/sign-out">로그아웃</a>
	</div>
</div>