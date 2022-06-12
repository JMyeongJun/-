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
<script src="js/categoryList.js"></script>
<script>
</script>
<style>
	#top {grid-row: 1 / 3;}
	#main {display: none;}
	#top h1 {margin: 150px;}
</style>
</head>
<body>
	<div id="container">
		<div id="sidenav">
			<div id="side_top">
				<button>로그인</button>
				<button>장바구니</button>
				<button>주문내역</button>
				</div>
			<div id="side_bottom">
				<ul id="categoryList"></ul>
			</div>
		</div>
		<div id="top">
			<h1><a href="/">책방</a></h1>
			<div id="top_bottom">
				<form action="/Search">
					<select name="searchOption" >
					  <option value="all">통합검색</option>
					  <option value="title">제목검색</option>
					  <option value="auth">저자검색</option>
				  </select>
				  <input type="hidden" name="pageNum" value="1" />
				  <input type="text" name="keyword" id="keyword" autocomplete='off' placeholder="검색" />
				  <input type="submit" class="btnOk" value="검색" />
				</form>
			</div>
		</div>
		<div id="main">
			<h2>main입니다</h2>
		</div>
	</div>
</body>
</html>