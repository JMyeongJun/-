<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/basic.css" />
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="container">
		<div id="sidenav">
			<div id="side_top"><%@ include file="/WEB-INF/include/sideTop.jsp" %></div>
			<div id="side_bottom">
				<ul id="sideList">
					<li><a href="/Mypage/Cart" class="active">장바구니</a></li>
					<li><a href="/Mypage/OrderList">주문내역</a></li>
				</ul>
			</div>
		</div>
		<div id="top">
			<h1><a href="/">책방</a></h1>
			<div id="top_bottom"><%@ include file="/WEB-INF/include/topBottom.jsp" %></div>
		</div>
		<div id="main">
			<h2>${username} cart</h2>
		</div>
	</div>
</body>
</html>