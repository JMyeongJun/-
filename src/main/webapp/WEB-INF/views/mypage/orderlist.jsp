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
<script>
	$(function(){
		// 로그인버튼 관련
		if("${username}" != "") {
			$("#login").attr("href", "/Login/Logout");
			$("#login button").html("로그아웃");
		}
		
		// 검색창 submit 제한
		$("#searchForm").submit(function(event){
			var keyword = $("#keyword").val();
			if(keyword == ""){
				alert("검색어를 입력하세요.");
				event.preventDefault();
				return;
			}
		});
	});
</script>
</head>
<body>
	<div id="container">
		<div id="sidenav">
			<div id="side_top">
				<a href="/Login" id="login"><button>로그인</button></a>
				<a href="/Mypage/Cart"><button>장바구니</button></a>
				<a href="/Mypage/OrderList"><button>주문내역</button></a>
				<c:choose>
					<c:when test="${username != null}">
						<div id="printname"  style="text-align:center;">${username}님</div>
			    </c:when>
				</c:choose>
			</div>
			<div id="side_bottom">
				<ul id="sideList">
					<li><a href="/Mypage/Cart">장바구니</a></li>
					<li><a href="/Mypage/Orderlist" class="active">주문내역</a></li>
					<li><a href="/Mypage/Pay">결제</a></li>
				</ul>
			</div>
		</div>
		<div id="top">
			<h1><a href="/">책방</a></h1>
			<div id="top_bottom">
				<form action="/Search" id="searchForm">
					<select name="searchOption" >
					  <option value="all">통합검색</option>
					  <option value="title">제목검색</option>
					  <option value="auth">저자검색</option>
				  </select>
				  <input type="text" name="keyword" id="keyword" autocomplete='off' placeholder="검색" />
				  <input type="submit" class="btnOk" value="검색" />
				</form>
			</div>
		</div>
		<div id="main">
			<h2>${username} orderlist</h2>
		</div>
	</div>
</body>
</html>