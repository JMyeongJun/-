<%@page import="com.bookroom.book.vo.BookVo"%>
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
<script type="text/javascript" src="/js/categoryList.js"></script>
<style>
	#main {
		position:relative;
	}
	/* 책 이미지 박스 */
	.picturebox {
		position: absolute;
		width: 30%;
		left : 3%;
		top  : 5%;
	}
	/* 책 이미지 */
	.itemBookImage{
	 	display:inline-block;
		width:200px;
   	height:280px;
   	overflow:hidden;
   	float: right;
	}
	.picture{
		width:100%;
	    height:100%;
	    object-fit:cover;
	}
	/* 책 정보 박스 */
	.itembox {
		display:inline-block;
	    position: absolute;
	    top: 5%;
		right : 3%;
	    width: 53%;
		height: 280px;
	}
	tr, td{
		font-size: 30px;
		padding: 6px;
		text-align: left;
	}
	/* 수량 표시 텍스트 */
	#amount {
		width : 50px;
		height : 30px;
		margin : 0px 10px 0px 10px;
		text-align: center;
	}
	/* 장바구니, 구매 버튼 */
	#gocart, #gobuy {
		position: absolute;
		top: 60%;
		left: 40%;
		margin-left: -300px;
	}
	#gobuy {
		margin-left: 150px;
	}
	.book_a {
	 	text-align: center;
	  color: white;
	  background-color: #3498DB;
	  width : 300px;
	  float: left;
	  padding: 10px;
	  text-decoration: none;
	  transition: background-color .3s;
	  border: 1px solid #ffffff;
	  border-radius: 5px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/js/categoryList.js"></script>
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
	
	// 책 상세 페이지 수량 조절 함수
	function count(type)  {
	  const resultElement = document.getElementById('amount');
	  let   num           = resultElement.value;
	  
	  if(type == 1) {
	    num = parseInt(num) + 1;
	  }else if(type == -1)  {
	    num = parseInt(num) - 1;
    	if(num <=0) {
				num = 0;	    		
    	}
	  } 
	  resultElement.value = num;
	}
	
	// move 함수
	function move(String) {
		const resultElement = document.getElementById('amount');
		let   num           = resultElement.value;
		
		switch (String) {
			case 'cart': location.href = "/Mypage/Cart?isbn=${book.isbn}&quantity=" + num; break;
			case 'buy' : location.href = "/Mypage/Buy?isbn=${book.isbn}&quantity=" + num; break;
		}
	}
	
</script>
</head>
<body>
	<div id="container">
		<div id="sidenav">
			<div id="side_top"><%@ include file="/WEB-INF/include/sideTop.jsp" %></div>
			<div id="side_bottom">
				<ul id="sideList"></ul>
			</div>
		</div>
		<div id="top">
			<h1><a href="/">책방</a></h1>
			<div id="top_bottom"><%@ include file="/WEB-INF/include/topBottom.jsp" %></div>
		</div>
		<div id="main">
			<div class="picturebox">
				<div class="itemBookImage">
					<img class="picture" src="${book.image}">
				</div>
			</div>
			<div class="itembox">
				<table>
					<tr>
						<td colspan="2" style="font-weight: bold;">${book.title}</td>
					</tr>
					<tr>
						<td>저자</td>
						<td>${book.author}</td>
					</tr>
					<tr>
						<td>출판사</td>
						<td>${book.publisher}</td>
					</tr>
					<tr>
						<td>금액</td>
						<td>${book.price}</td>
					</tr>
					<tr>
						<td>수량</td>
						<td><input type="button" onclick="count(-1)" value="-" />						
						    <input type="number" name="amount" id="amount" value="1" />
						    <input type="button" onclick="count(1)" value="+" />
						</td>
					</tr>
				</table>
			</div>
			<span id="gocart">
				<a class="book_a" href="javascript:void(0)" onclick="move('cart')">장바구니</a>
			</span>
			<span id="gobuy">
				<a class="book_a" href="javascript:void(0)" onclick="move('buy')">바로구매</a>
			</span>
		</div>
	</div>
</body>
</html>