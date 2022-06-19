<%@page import="com.bookroom.book.vo.BookVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/basic.css" />
<link rel="stylesheet" href="/css/view.css" />
<title>책방</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/js/categoryList.js"></script>
<script>
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
	
	function move(String) {
		
		const resultElement = document.getElementById('amount');
		let   num           = resultElement.value;
		
		switch (String) {
		case 'cart'    : 
            if ('${username}'== null || '${username}' == "" ) {
               location.href = "/Login";  break;
            } else { 
                   let params = '${book.isbn}';
                   $.ajax({
                       url: '/Mypage/InsertCart',
                       type: 'POST',
                       data: {isbn : params, quantity : num},
                       contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                       dataType: 'json',
                       success: function (res) {
                       }
                   });
               document.getElementById("popup_layer").style.display = "block";
               break;
            } 
			case 'buy'     : location.href = "/Mypage/Pay?isbn=${book.isbn}&quantity=" + num; break;
			case 'confirm' : location.href = "/Mypage/Cart";   break;
		}
	}

	//팝업 닫기
	function closePop() {
	    document.getElementById("popup_layer").style.display = "none";
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
		<div id="bookinfo">
				<div class="picturebox">
						<img class="picture" src="${book.image}">
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
				</div>
				<div id="buttons">
					<a class="book_a" href="javascript:void(0)" onclick="move('cart')">장바구니</a>
					<a class="book_a" href="javascript:void(0)" onclick="move('buy')">바로구매</a>
				</div>
		</div>
	</div>
	
	<!-- 장바구니 팝업-->
	<div class="popup">
		<div class="popup_layer" id="popup_layer" style="display: none;">
			<div class="popup_box">
	     		<div class="popup_cont">
					<h2>상품이 잘 담겼어요</h2>
				</div>
	
				<div class="popup_btn">
					<a onclick="move('confirm')">장바구니로 이동</a>
					<a style="left:317px;" href="javascript:closePop();">닫기</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>