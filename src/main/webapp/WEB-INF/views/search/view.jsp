<%@page import="com.bookroom.book.vo.BookVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/basic.css" />
<title>책 상세보기</title>
<style>
	#main {
		position:relative;
		width: 1000px;
	}
	/* 책 이미지 박스 */
	.picturebox {
		position: absolute;
		left : 360px;
		top  : 5%;
	}
	
	/* 책 이미지 */
	.itemBookImage{
	 	display:inline-block;
		width:200px;
    	height:280px;
    	overflow:hidden;
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
	    left: 750px;
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
		top: 460px;
		left: 360px;
	}
	
	#gobuy {
		margin-left: 450px;
	
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
	
/*popup*/
.popup_layer {position:fixed;top:0;left:0;z-index: 10000; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.4); }
.popup_box{position: relative;top:50%;left:50%; overflow: auto; height: 375px; width:600px;transform:translate(-50%, -50%);z-index:1002;box-sizing:border-box;background:#fff;box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);-webkit-box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);-moz-box-shadow: 2px 5px 10px 0px rgba(0,0,0,0.35);}
.popup_box .popup_cont {padding:50px;line-height:1.4rem;font-size:30px; text-align: center; }
.popup_btn { position:relative; height:70px; margin-top:80px;}
.popup_btn a {position:absolute; left:33px; width:250px; background:#3498DB; text-align: center;  padding-top: 24px; padding-bottom:24px; border-radius: 10px; font-size:20px; color:white;}
/*popup end*/
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
	
	function move(String) {
		
		const resultElement = document.getElementById('amount');
		let   num           = resultElement.value;
		
		switch (String) {
		case 'cart'    : 
            if ('${username}'== null || '${username}' == "" ) {
               location.href = "/Login";  break;
            } else { 
               document.getElementById("popup_layer").style.display = "block";
               break;
            } 
			case 'buy'     : location.href = "/Mypage/PayCart?isbn=${book.isbn}&quantity=" + num; break;
			case 'confirm' : location.href = "/Mypage/InsertCart?isbn=${book.isbn}&quantity=" + num;   break;
		}
	}

	//팝업 닫기
	function closePop() {
	    document.getElementById("popup_layer").style.display = "none";
	}
	
</script>
<style>
	.active {background-color: yellow;}
</style>
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
				<ul id="sideList"></ul>
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
	
	<!-- 장바구니 팝업-->
	<div class="popup">
		<div class="popup_layer" id="popup_layer" style="display: none;">
			<div class="popup_box">
	     		<div class="popup_cont">
					<h2>상품이 잘 담겼어요</h2>
				</div>
	
				<div class="popup_btn">
					<a href="javascript:void(0)" onclick="move('confirm')">장바구니로 이동</a>
					<a style="left:317px;" href="javascript:closePop();">닫기</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>