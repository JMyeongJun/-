<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>BookMall(LOGIN)</title>
<style>
	body {
	background-color: rgba(194, 222, 209);
	width:100%;
	margin-top: 250px;
	text-align: center;
	}
	#logo {
 	text-decoration: none;
 	color: black;
	font-size:28px;
}
</style>
<script>
window.onpageshow = function(event) { 
	// Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
	if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
		//세션 아이디가 없을경우
		if(sessionStorage.getItem("userid") == null || sessionStorage.getItem("userid") == ''){
			window.location.reload (true)
		}
	}
}
</script>
</head>
<body>
		<h1><a id="logo" href="/">책방</a></h1>
		<br>
		<h2 style="font-size: 20">간편 로그인</h2>
		<div id="naver_id_login">
			<a href="${url}">
			<img width="300" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/>
			</a>
		</div>
</body>
</html>
